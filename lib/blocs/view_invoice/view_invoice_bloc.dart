import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/invoice/invoice_item.dart';
import '../../database/db_module.dart';
import '../base/base_bloc.dart';
import '../cart/cart_bloc.dart';

part 'view_invoice_event.dart';

part 'view_invoice_state.dart';

class ViewInvoiceBloc extends BaseBloc<ViewInvoiceEvent> {
  ViewInvoiceBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetInvoiceDetails>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(getQueryToGetTheInvoiceItems(event.id))
          .then((value) async {
        var invoiceItems = <InvoiceItem>[];
        for (final element in value) {
          invoiceItems.add(InvoiceItem.fromJson(element));
        }

        await dbModule.dbInstance.database
            .rawQuery(queryToGetBillScheme(event.id))
            .then((billValue) {
          emit(GetInvoiceItemsSuccessState(
              data: invoiceItems, billScheme: billValue));
        });
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetInvoiceItemFailedState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
    });

    on<GetSupplierDetails>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.distributionDao
          .getDistributionObject(event.id)
          .then((value) {
        emit(GetSupplierDetailsSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const LoadingState(isLoading: false));
      });
    });
  }

  String getQueryToGetTheInvoiceItems(int invoiceId) {
    return "select pl.name, "
        "uom.uom_name, "
        "s.name as scheme_name, "
        "s.minTotalValue, "
        "s.maxTotalValue, "
        "s.minOrderQnty, "
        "s.maxOrderQnty, "
        "s.additionalDiscountPercent, "
        "s.freeProductId, "
        "ii.* from invoiceitem as ii "
        "inner join productList as pl on ii.productId =pl.id "
        "inner join unitofmeasure as uom on ii.uoM=uom.id "
        "left join scheme as s on ii.schemeId=s.id "
        "where ii.secondaryInvoiceId=$invoiceId";
  }

  String queryToGetBillScheme(int invoiceId) {
    return "select s.* from orderinvoicemapping as oim "
        "inner join orderrecord as ord on ord.id=oim.orderId "
        "inner join scheme as s on ord.scheme_id=s.id "
        "where oim.id=$invoiceId";
  }
}
