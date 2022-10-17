part of 'add_sales_return_bloc.dart';

abstract class AddSalesReturnEvent extends Equatable {
  const AddSalesReturnEvent();

  @override
  List<Object?> get props => [];
}

class GetProductList extends AddSalesReturnEvent {
  const GetProductList();

  @override
  List<Object> get props => [];
}

class GetReasonList extends AddSalesReturnEvent {
  const GetReasonList();

  @override
  List<Object> get props => [];
}

class GetInvoiceList extends AddSalesReturnEvent {
  const GetInvoiceList(this.customerId,);

  final int customerId;
  @override
  List<Object> get props => [customerId];
}

class GetDistributorList extends AddSalesReturnEvent {
  const GetDistributorList(
    this.customerId,
  );

  final int customerId;

  @override
  List<Object> get props => [customerId];
}

class GetWarehouseList extends AddSalesReturnEvent {
  const GetWarehouseList(
    this.distributorId,
  );

  final int distributorId;

  @override
  List<Object> get props => [distributorId];
}
class InsertIntoDBList extends AddSalesReturnEvent {
  const InsertIntoDBList(
    this.salesReturnData,
  );

  final SalesReturnItem salesReturnData;

  @override
  List<Object> get props => [salesReturnData];
}
