import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cygneto/blocs/base/base_bloc.dart';
import 'package:cygneto/database/db_module.dart';
import 'package:cygneto/exports/resources.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../data/models/sales_return/sales_return_item.dart';
import '../../data/models/sales_return/sales_return_request.dart';
import '../../exports/models.dart';
import '../../services/api/api_service.dart';

part 'add_sales_return_event.dart';

part 'add_sales_return_state.dart';

class AddSalesReturnBloc extends BaseBloc<AddSalesReturnEvent> {
  AddSalesReturnBloc(this.dbModule) : super() {
    _onEvent();
  }

  //variable declaration
  late DBModule dbModule;

  void _onEvent() {
    on<GetProductList>((event, emit) async {
      emit(const LoadingState());
      if (kDebugMode) {
        print(getQueryForProduct());
      }
      await dbModule.dbInstance.database
          .rawQuery(getQueryForProduct())
          .then((value) {
        emit(ProductSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const ProductFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetReasonList>((event, emit) async {
      emit(const LoadingState());

      await dbModule.dbInstance.salesReturnReasonDao.getAllData().then((value) {
        emit(GetReasonSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetReasonFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
    on<GetDistributorList>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(getQueryForDistributor(event.customerId))
          .then((distributorValue) async {
        await dbModule.dbInstance.warehouseDao
            .getWarehouseData()
            .then((wareHouseValue) async {
          emit(GetDistributorAndWarehouseSuccessState(
              distributorData: distributorValue,
              warehouseData: wareHouseValue));
          emit(const LoadingState(isLoading: false));
        });
      }).catchError((e) {
        emit(const GetDistributorAndWarehouseFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetInvoiceList>((event, emit) async {
      emit(const LoadingState());

      await dbModule.dbInstance.invoiceMappingDao
          .getInvoiceListBasedOnCustomer(event.customerId)
          .then((value) {
        emit(GetInvoiceSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetInvoiceFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<InsertIntoDBList>((event, emit) async {
      emit(const LoadingState());

      await dbModule.dbInstance.financialYearDao
          .getCurrentFinancialYear()
          .then((value) {
        if (value.isNotEmpty) {
          event.salesReturnData.fyId = value[0].id;
        }
      });
      await dbModule.dbInstance.journeyCycleDao
          .getCurrentJourneyCycle(event.salesReturnData.fyId!)
          .then((value) {
        if (value!.isNotEmpty) {
          event.salesReturnData.jcId = value[0].id;
        }
      });

      await dbModule.dbInstance.salesReturnDao
          .insertSalesReturnData(event.salesReturnData)
          .then((value) async {
        await ApiService().checkInternet().then((internet) async {
          if (internet) {
            await dbModule.dbInstance.salesReturnDao
                .getAllUnSyncData()
                .then((unSyncedValue) async {
              for (final element in unSyncedValue) {
                element.id = 0;
              }

              await apiService.client!
                  .addSalesReturn(SalesReturnRequest(unSyncedValue))
                  .then((addSalesReturnResponse) async {
                await dbModule.dbInstance.salesReturnDao
                    .deleteUnSyncedData()
                    .whenComplete(() async {
                  await getUpdatedSalesReturn().whenComplete(() {
                    emit(const AddSalesReturnSuccessState());
                    emit(const LoadingState(isLoading: false));
                  });
                });
              }).catchError((onError) {
                emit(const AddSalesReturnSuccessState());
                emit(const LoadingState(isLoading: false));
              });
              return;
            }).catchError((onError) {
              emit(const AddSalesReturnSuccessState());
              emit(const LoadingState(isLoading: false));
            });
          } else {
            emit(const AddSalesReturnSuccessState());
            emit(const LoadingState(isLoading: false));
          }
          return;
        });
        return;
      }).catchError((e) {
        emit(const AddSalesReturnFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  Future<void> getUpdatedSalesReturn() async {
    await dbModule.dbInstance.database
        .rawQuery(
            "select max(d) from (select created_on d from SalesReturn union select modified_on d from SalesReturn)")
        .then((dateValue) async {
      String? syncDateTime;
      if (dateValue[0]["max(d)"] != null) {
        syncDateTime = dateValue[0]["max(d)"].toString();
      } else {
        syncDateTime = null;
      }
      await apiService.client!
          .getSalesReturn(OrderRecordRequest(fromTimeStamp: syncDateTime))
          .then((value) async {
        await dbModule.dbInstance.salesReturnDao
            .insertAllData(value.data!)
            .then((insertedValue) {});
      }).catchError((onError) {});
    });
    return;
  }

  String getQueryForProduct() {
    return "SELECT uom1.uom_name as uom1Name, "
        "uom2.uom_name as uom2Name, "
        "pl.* FROM productList as pl "
        "LEFT JOIN unitofmeasure as uom1 on pl.uom_1=uom1.id "
        "AND pl.is_sellable_uom1=1 "
        "LEFT JOIN unitofmeasure as uom2 on pl.uom_2=uom2.id "
        "AND pl.is_sellable_uom2=1";
  }

  String getQueryForDistributor(int customerId) {
    return "select d.* from distribution as d "
        "left join customer as c on c.distributorId_1=d.id "
        "or c.distributorId_2=d.id or c.distributorId_3=d.id where c.id=$customerId";
  }
}
