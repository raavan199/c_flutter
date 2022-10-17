part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object?> get props => [];
}

class GetItemsFromCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class GetUomListFromDB extends CartEvent {
  @override
  List<Object> get props => [];
}

class GetProductListCart extends CartEvent {
  const GetProductListCart();

  @override
  List<Object> get props => [];
}

class DeleteProductFromCart extends CartEvent {
  const DeleteProductFromCart({
    required this.id,
    required this.index,
  });

  final int id;
  final int index;

  @override
  List<Object> get props => [id];

  @override
  String toString() => 'DeleteProductFromCart { id: $id }';
}

class DeleteAllDataFromCart extends CartEvent {
   DeleteAllDataFromCart({required this.needScreenRedirection});

  bool needScreenRedirection;

  @override
  List<Object> get props => [needScreenRedirection];
}

class InsertOrderIntoOrderRecord extends CartEvent {
  InsertOrderIntoOrderRecord({required this.orderRecord});

  OrderRecordDataResponse orderRecord;

  @override
  List<Object> get props => [orderRecord];
}

class InsertOrderItemIntoDB extends CartEvent {
  InsertOrderItemIntoDB({required this.orderItemList});

  List<OrderItemDataResponse> orderItemList;

  @override
  List<Object> get props => [orderItemList];

  @override
  String toString() => 'InsertOrderItemIntoDB {orderItemList: $orderItemList }';
}

class GetUnSyncOrderFromDB extends CartEvent {
  const GetUnSyncOrderFromDB();

  @override
  List<Object> get props => [];
}


class PlaceOrderAPICall extends CartEvent {
  PlaceOrderAPICall({required this.placeOrderItem, required this.index});

  OrderRecordDataResponse placeOrderItem;
  int index;

  @override
  List<Object> get props => [placeOrderItem, index];
}

class DeleteUnSyncOrder extends CartEvent {
  const DeleteUnSyncOrder();

  @override
  List<Object> get props => [];
}

///event to get the lastSync Time of the perticular table
class GetLastTimeStampFromDb extends CartEvent {
  const GetLastTimeStampFromDb();

  @override
  List<Object> get props => [];
}

// Order Record List API event
class CallOrderRecordApi extends CartEvent {
  const CallOrderRecordApi({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
CallOrderRecordApi { fromTimeStamp: $fromTimeStamp }''';
}

// Order Item List API event
class CallOrderItemApi extends CartEvent {
  const CallOrderItemApi({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
CallOrderRecordApi { fromTimeStamp: $fromTimeStamp }''';
}

// Order Item List API event
class GetSchemeDataFromDB extends CartEvent {
  GetSchemeDataFromDB({required this.totalAmount, required this.totalQuantity});

  double totalAmount;
  double totalQuantity;

  @override
  List<Object> get props => [totalAmount, totalQuantity];
}

// Order Item List API event
class GetFreeProduct extends CartEvent {
  GetFreeProduct({required this.freeProduct});

  ProductWithPriceModel freeProduct;

  @override
  List<Object> get props => [freeProduct];
}

// To get the mapping of visit and order
class GetVisitOrderMappingApi extends CartEvent {
  const GetVisitOrderMappingApi({
    required this.fromTimeStamp,
  });

  final String? fromTimeStamp;

  @override
  List<Object> get props => [fromTimeStamp!];

  @override
  String toString() => '''
CallVisitOrderMappingApi { fromTimeStamp: $fromTimeStamp }''';
}

class CallVisitApi extends CartEvent {
  const CallVisitApi({required this.pageIndex, required this.fromTimeStamp});

  final int pageIndex;
  final String? fromTimeStamp;

  @override
  List<Object> get props => [pageIndex, fromTimeStamp!];

  @override
  String toString() => '''
         CallVisitApi { pageIndex: $pageIndex, fromTimeStamp: $fromTimeStamp }''';
}
