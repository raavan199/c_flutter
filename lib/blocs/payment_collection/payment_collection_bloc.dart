import 'package:equatable/equatable.dart';

import '../../data/models/invoice/invoice_item.dart';
import '../../data/models/invoice/invoice_statement_item.dart';
import '../../data/models/invoice/manage_payment_collection_request.dart';
import '../../data/models/route/get_route_by_user_request.dart';
import '../../data/models/sales_return/sales_return_item.dart';
import '../../database/db_module.dart';
import '../../resources/app_strings.dart';
import '../../ui/screens/add_new_order/product_price_calculation.dart';
import '../base/base_bloc.dart';

part 'payment_collection_event.dart';

part 'payment_collection_state.dart';

class PaymentCollectionBloc extends BaseBloc<PaymentCollectionEvent> {
  PaymentCollectionBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetInvoicesFromDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.invoiceMappingDao
          .getInvoiceListBasedOnCustomer(event.customerId)
          .then((value) async {
        if (value != null && value.isNotEmpty) {
          final ids = <int>[];
          for (final element in value) {
            ids.add(element.id);
          }

          await dbModule.dbInstance.invoiceItemDao
              .getInvoiceListBasedOnInvoice(ids)
              .then((invoiceItems) {
            for (final invoice in value) {
              var data = invoiceItems?.where((conditionData) =>
              conditionData.secondaryInvoiceId == invoice.id);
              if (data != null) {
                invoice.secondaryInvoiceItems = [];
                invoice.secondaryInvoiceItems?.addAll(data);
              }
            }
          });

          await dbModule.dbInstance.invoiceStatementDao
              .getInvoiceStatementBasedOnInvoices(ids)
              .then((invoiceStatementValue) {
            if (invoiceStatementValue != null &&
                invoiceStatementValue.isNotEmpty) {
              for (final element in value) {
                final data = invoiceStatementValue.where(
                        (conditionData) =>
                    conditionData.invoiceId == element.id);
                if (data.isNotEmpty) {
                  final totalPaidAmount =
                  getTotalOfPaymentForInvoices(data.toList());
                  final totalAmountOfInvoice =
                  getTotalAmountOfInvoices(element.secondaryInvoiceItems!);
                  element.totalAmountOfInvoice = totalAmountOfInvoice;
                  element.totalPaidAmountOfInvoice = totalPaidAmount;
                  if (totalAmountOfInvoice - totalPaidAmount != 0) {
                    element.invoiceStatementItems = [];
                    element.invoiceStatementItems?.addAll(data);
                  }
                }
              }
            }
          });
        }
        emit(GetInvoicesSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetInvoicesFailedState(msg: AppStrings.msgNoDataToDisplay));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<AddCollectedPayment>((event, emit) async {
      emit(const LoadingState());

      await dbModule.dbInstance.financialYearDao
          .getCurrentFinancialYear()
          .then((value) {
        if (value.isNotEmpty) {
          event.invoiceStatement.fyId = value[0].id!;
        }
      });
      await dbModule.dbInstance.journeyCycleDao
          .getCurrentJourneyCycle(event.invoiceStatement.fyId)
          .then((value) {
        if (value!.isNotEmpty) {
          event.invoiceStatement.jcId = value[0].id!;
        }
      });

      await dbModule.dbInstance.invoiceStatementDao
          .insertInvoiceStatement(event.invoiceStatement)
          .then((value) async {
        await dbModule.dbInstance.invoiceStatementDao
            .getUnSyncedStatements()
            .then((unSyncedStatements) async {
          var list = <InvoiceStatementItem>[];
          unSyncedStatements?.forEach((statementElement) {
            statementElement.id = 0;
            list.add(statementElement);
          });
          final request = ManagePaymentCollectionRequest(list);
          await apiService.client!
              .postInvoiceStatement(request)
              .then((postValue) async {
            await dbModule.dbInstance.invoiceStatementDao.deleteUnSyncedData();

            await dbModule.dbInstance.database
                .rawQuery(
                "select max(d) from (select created_on d from InvoiceStatement union select modified_on d from InvoiceStatement)")
                .then((value) async {
              String? syncDateTime;
              if (value[0]["max(d)"] != null) {
                syncDateTime = value[0]["max(d)"].toString();
              }
              await getUpdatedInvoiceStatement(syncDateTime, 1);
            });
          }).catchError((onError) {});
        });
        emit(const PostInvoiceStatementSuccessState());
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const PostInvoiceStatementFailedState(
            msg: AppStrings.msgNoDataToDisplay));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetLatestInvoiceStatement>((event, emit) async {
      emit(const LoadingState());
      InvoiceStatementItem? latestInvoiceItem;
      List<SalesReturnItem>? approvedSalesReturnItems;
      await dbModule.dbInstance.invoiceStatementDao
          .getLatestStatementBasedOnInvoiceId(event.invoiceId)
          .then((value) {
        latestInvoiceItem=value;
      });

      await dbModule.dbInstance.salesReturnDao.getApprovedSalesReturnForInvoice(
          event.invoiceId).then((approvedSalesReturn){
        approvedSalesReturnItems=approvedSalesReturn;
      });

      emit(LatestInvoiceStatementSuccessState(latestInvoiceStatement: latestInvoiceItem,
      approvedSalesReturn: approvedSalesReturnItems));
      emit(const LoadingState(isLoading: false));
    });
  }

  getUpdatedInvoiceStatement(String? lastSyncTimeStamp, int pageIndex) async {
    await apiService.client!
        .getInvoiceStatement(GetRouteByUserRequest(
      pageIndex: pageIndex,
      fromTimeStamp: lastSyncTimeStamp,
    ))
        .then((value) {
      _saveInvoiceStatementsIntoDatabase(value.data!.items);
      if (value.data!.hasNextPage == true) {
        getUpdatedInvoiceStatement(lastSyncTimeStamp, pageIndex + 1);
      }
    });
  }

  Future<void> _saveInvoiceStatementsIntoDatabase(
      List<InvoiceStatementItem>? data) async =>
      await dbModule.dbInstance.invoiceStatementDao
          .insertInvoiceStatements(data ?? []);

  double getTotalOfPaymentForInvoices(List<InvoiceStatementItem> items) {
    var _totalPaymentDone = 0.0;
    for (final element in items) {
      _totalPaymentDone = _totalPaymentDone + element.amount!;
    }
    return _totalPaymentDone;
  }

  double getTotalAmountOfInvoices(List<InvoiceItem> items) {
    var price = 0.0;
    var totalTax = 0.0;
    for (final element in items) {
      price = price +
          ProductPriceCalculation.calculatePriceOfProduct(
              element.basePrice ?? 1, element.billQuantity?.toDouble() ?? 1);
      totalTax = totalTax +
          ProductPriceCalculation.calculateTotalTaxWithPrice(
              element.basePrice ?? 1,
              element.billQuantity?.toDouble() ?? 1,
              element.igst ?? 1,
          0.0);
    }
    return price + totalTax;
  }
}
