part of 'view_invoice_bloc.dart';

@immutable
abstract class ViewInvoiceEvent {
  @override
  List<Object?> get props => [];
}

class GetInvoiceDetails extends ViewInvoiceEvent {
  GetInvoiceDetails({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}

class GetSupplierDetails extends ViewInvoiceEvent {
  GetSupplierDetails({
    required this.id,
  });

  final int id;

  @override
  List<Object> get props => [id];
}
