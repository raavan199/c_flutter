part of 'view_invoice_bloc.dart';

@immutable
abstract class ViewInvoiceState {
  const ViewInvoiceState();
}

class ViewInvoiceInitial extends ViewInvoiceState {
  @override
  List<Object> get props => [];
}
class GetInvoiceItemsSuccessState extends BaseState {
  const GetInvoiceItemsSuccessState({this.data,this.billScheme});

  final dynamic data;
  final dynamic billScheme;

  @override
  List<Object> get props => <Object>[data,billScheme];
}

class GetInvoiceItemFailedState extends BaseState {
  const GetInvoiceItemFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
class GetSupplierDetailsSuccessState extends BaseState {
  const GetSupplierDetailsSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}