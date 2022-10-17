import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../dao/invoice_mapping_dao.dart';
import '../../data/models/closing_balance/closing_balance.dart';
import '../../data/models/financial_year/financial_year_data.dart';
import '../../data/models/invoice/invoice_item.dart';
import '../../data/models/invoice/invoice_statement_item.dart';
import '../../data/models/invoice/order_invoice_mapping.dart';
import '../../data/models/sales_return/sales_return_item.dart';
import '../../database/db_module.dart';
import '../../exports/resources.dart';
import '../../ui/screens/add_new_order/product_price_calculation.dart';
import '../base/base_bloc.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends BaseBloc<AccountEvent> {
  AccountBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetInvoicesFromDB>((event, emit) async {
      emit(const LoadingState());
      final ids = <int>[];
      final orderInvoiceMappingList = <OrderInvoiceMapping>[];
      if (event.orderId == -1) {
        await dbModule.dbInstance.invoiceMappingDao
            .getInvoiceListBasedOnCustomerAndDate(
                event.customerId, event.startDate, event.endDate)
            .then((value) {
          if (value != null && value.isNotEmpty) {
            orderInvoiceMappingList.addAll(value);
            for (final element in value) {
              ids.add(element.id);
            }
          }
        });
      } else {
        await dbModule.dbInstance.invoiceMappingDao
            .getInvoiceListBasedOnCustomerAndOrderId(
                event.customerId, event.orderId)
            .then((value) {
          if (value != null && value.isNotEmpty) {
            orderInvoiceMappingList.addAll(value);
            for (final element in value) {
              ids.add(element.id);
            }
          }
        });
      }
      if(ids.isEmpty){
        emit(GetInvoicesSuccessState(data: orderInvoiceMappingList));
        emit(const LoadingState(isLoading: false));
        return;
      }
      await dbModule.dbInstance.invoiceStatementDao
          .getInvoiceStatementBasedOnInvoices(ids)
          .then((invoiceStatementValue) {
        if (invoiceStatementValue != null && invoiceStatementValue.isNotEmpty) {
          for (final element in orderInvoiceMappingList) {
            final data = invoiceStatementValue.where(
                (conditionData) => conditionData.invoiceId == element.id);
            if (data.isNotEmpty) {
              element.invoiceStatementItems = [];
              element.invoiceStatementItems?.addAll(data);
            }
          }
        }
      });

      await dbModule.dbInstance.invoiceItemDao
          .getInvoiceListBasedOnInvoice(ids)
          .then((invoiceItems) {
        for (final invoice in orderInvoiceMappingList) {
          var data = invoiceItems?.where((conditionData) =>
              conditionData.secondaryInvoiceId == invoice.id);
          if (data != null) {
            invoice.secondaryInvoiceItems = [];
            invoice.secondaryInvoiceItems?.addAll(data);
          }
        }
      });

      emit(GetInvoicesSuccessState(data: orderInvoiceMappingList));
      emit(const LoadingState(isLoading: false));
    });

    on<GetDataForTopLayoutFromDB>((event, emit) async {
      emit(const LoadingState());
      final _invoiceItemsForOpeningBalance = <InvoiceItem>[];
      final _salesReturnForOpeningBalance = <SalesReturnItem>[];
      final _invoiceStatementForOpeningBalance = <InvoiceStatementItem>[];
      var openingBalance = 0.0;
      var newBilling = 0.0;
      var paidOrAdjustmentAmount = 0.0;

      FinancialYearData? currentFinancialYearData;
      //to get the current financial year
      await dbModule.dbInstance.financialYearDao
          .getCurrentFinancialYear()
          .then((currentFinancialYear) {
        currentFinancialYearData = currentFinancialYear[0];
      });

      // to get the opening balance of current financial year
      await dbModule.dbInstance.closingBalanceDao
          .getCurrentFinancialYearOpeningBalance(
              event.customerId, currentFinancialYearData!.id!)
          .then((openingBalanceValue) {
        if (openingBalanceValue?.isNotEmpty == true) {
          openingBalance = openingBalanceValue![0].obAmount!;
        }
      });

      //to get the invoice items from start date of current financial year to current date.
      await dbModule.dbInstance.database
          .rawQuery(getQueryForOpeningBalanceInvoiceItem(
              currentFinancialYearData!.startDate!,
              event.startDate,
              event.customerId))
          .then((invoice) {
        var price = 0.0;
        var tax = 0.0;
        var discount = 0.0;
        for (final value in invoice) {
          var inDiscount = 0.0;
          var item = InvoiceItem.fromJson(value);
          _invoiceItemsForOpeningBalance.add(item);
          price = price +
              ProductPriceCalculation.calculatePriceOfProduct(
                  item.basePrice ?? 1, item.billQuantity!.toDouble());
          if (item.discount != null && item.discount != 0.0) {
            inDiscount = ProductPriceCalculation.calculateDiscountValue(
                item.basePrice ?? 0,
                item.discount!,
                item.billQuantity!.toDouble());
            discount = discount + inDiscount;
          }
          tax = tax +
              ProductPriceCalculation.calculateTotalTaxWithPrice(
                  item.basePrice ?? 0,
                  item.billQuantity!.toDouble(),
                  item.igst ?? 0,
                  inDiscount);
        }
        openingBalance = price + tax - discount;
      });

      // to get the sales return of the current financial year to selected date.
      await dbModule.dbInstance.database
          .rawQuery(getQueryForOpeningBalanceSalesReturn(event.startDate,
              currentFinancialYearData!.startDate!, event.customerId))
          .then((salesReturnValue) {
        var price = 0.0;
        var tax = 0.0;
        for (final value in salesReturnValue) {
          final item = SalesReturnItem.fromJsonForRowQuery(value);
          _salesReturnForOpeningBalance.add(item);
          price = price +
              ProductPriceCalculation.calculatePriceOfProduct(
                  item.rate ?? 1, item.sellableQuantity!.toDouble());

          tax = tax +
              ProductPriceCalculation.calculateTotalTaxWithPrice(item.rate ?? 1,
                  item.sellableQuantity!.toDouble(), item.igst ?? 1, 0.0);

          if (item.damagedQuantity != null) {
            price = price +
                ProductPriceCalculation.calculatePriceOfProduct(
                    item.rate ?? 1, item.damagedQuantity!.toDouble());

            tax = tax +
                ProductPriceCalculation.calculateTotalTaxWithPrice(
                    item.rate ?? 1,
                    item.damagedQuantity!.toDouble(),
                    item.igst ?? 1,
                    0.0);
          }
          openingBalance = openingBalance - price - tax;
        }
      });

      await dbModule.dbInstance.database
          .rawQuery(getQueryForOpeningBalanceInvoiceStatement(event.startDate,
              currentFinancialYearData!.startDate!, event.customerId))
          .then((invoiceStatementValue) {
        var price = 0.0;
        for (final value in invoiceStatementValue) {
          final item = InvoiceStatementItem.fromJson(value);
          _invoiceStatementForOpeningBalance.add(item);
          price = price + item.amount!;
        }
        openingBalance = openingBalance - price;
      });

      //to get the new billing of the current selected dates
      print(getQueryForOpeningBalanceInvoiceItem(
          event.startDate, event.endDate, event.customerId));
      await dbModule.dbInstance.database
          .rawQuery(getQueryForOpeningBalanceInvoiceItem(
              event.startDate, event.endDate, event.customerId))
          .then((invoice) {
        var price = 0.0;
        var tax = 0.0;
        var discount = 0.0;
        for (final value in invoice) {
          var inDiscount = 0.0;
          var item = InvoiceItem.fromJson(value);
          _invoiceItemsForOpeningBalance.add(item);
          price = price +
              ProductPriceCalculation.calculatePriceOfProduct(
                  item.basePrice ?? 1, item.billQuantity!.toDouble());
          if (item.discount != null && item.discount != 0.0) {
            inDiscount = ProductPriceCalculation.calculateDiscountValue(
                item.basePrice ?? 0,
                item.discount!,
                item.billQuantity!.toDouble());
            discount = discount + inDiscount;
          }
          tax = tax +
              ProductPriceCalculation.calculateTotalTaxWithPrice(
                  item.basePrice ?? 0,
                  item.billQuantity!.toDouble(),
                  item.igst ?? 0,
                  inDiscount);
        }
        newBilling = price + tax - discount;
      });

      //to get the adjustment of the selected dates
      await dbModule.dbInstance.database
          .rawQuery(getQueryForOpeningBalanceSalesReturn(
              event.endDate, event.startDate, event.customerId))
          .then((salesReturnValue) {
        var price = 0.0;
        var tax = 0.0;
        for (final value in salesReturnValue) {
          final item = SalesReturnItem.fromJsonForRowQuery(value);
          _salesReturnForOpeningBalance.add(item);
          price = price +
              ProductPriceCalculation.calculatePriceOfProduct(
                  item.rate ?? 1, item.sellableQuantity!.toDouble());

          tax = tax +
              ProductPriceCalculation.calculateTotalTaxWithPrice(item.rate ?? 1,
                  item.sellableQuantity!.toDouble(), item.igst ?? 1, 0.0);

          if (item.damagedQuantity != null) {
            price = price +
                ProductPriceCalculation.calculatePriceOfProduct(
                    item.rate ?? 1, item.damagedQuantity!.toDouble());

            tax = tax +
                ProductPriceCalculation.calculateTotalTaxWithPrice(
                    item.rate ?? 1,
                    item.damagedQuantity!.toDouble(),
                    item.igst ?? 1,
                    0.0);
          }
          paidOrAdjustmentAmount = paidOrAdjustmentAmount + price + tax;
        }
      });

      await dbModule.dbInstance.database
          .rawQuery(getQueryForOpeningBalanceInvoiceStatement(
              event.endDate, event.startDate, event.customerId))
          .then((invoiceStatementValue) {
        var price = 0.0;
        for (final value in invoiceStatementValue) {
          final item = InvoiceStatementItem.fromJson(value);
          _invoiceStatementForOpeningBalance.add(item);
          price = price + item.amount!;
        }
        paidOrAdjustmentAmount = paidOrAdjustmentAmount + price;
      });

      emit(GetTopLayoutDataSuccessState(
          openingBalance: double.parse(openingBalance.toStringAsFixed(2)),
          newBilling: double.parse(newBilling.toStringAsFixed(2)),
          paymentAdjustment:
              double.parse(paidOrAdjustmentAmount.toStringAsFixed(2))));
      emit(const LoadingState(isLoading: false));
    });
  }

  String getQueryForOpeningBalanceSalesReturn(
          String startDate, String fyStartDate, int customerID) =>
      "select sr.* from SalesReturn "
      "as sr inner join OrderInvoiceMapping "
      "as oim on oim.id=sr.secondaryInvoiceId "
      "where date(oim.date) between date('$fyStartDate') and date ('$startDate') "
      "and oim.customerId=${customerID} and sr.isApprove=1";

  String getQueryForOpeningBalanceInvoiceStatement(
          String startDate, String fyStartDate, int customerID) =>
      "select ivs.* from InvoiceStatement as ivs "
      "inner join OrderInvoiceMapping as oim "
      "on oim.id=ivs.invoiceId "
      "where date(oim.date) between date('$fyStartDate') and date ('$startDate')"
      "and oim.customerId=$customerID";

  String getQueryForOpeningBalanceInvoiceItem(
          String fyStartDate, String startDate, int customerID) =>
      "select ii.* from InvoiceItem as ii "
      "inner join OrderInvoiceMapping as oim on oim.id=ii.secondaryInvoiceId "
      "where  date(oim.date) between date('$fyStartDate') and date ('$startDate') "
      "and oim.customerId=$customerID";
}
