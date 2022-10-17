part of 'add_new_order_bloc.dart';

abstract class AddNewOrderEvent extends Equatable {
  const AddNewOrderEvent();

  @override
  List<Object?> get props => [];
}

class GetGroupListFromDB extends AddNewOrderEvent {
  @override
  List<Object> get props => [];
}

class GetCategoryListFromDB extends AddNewOrderEvent {
  @override
  List<Object> get props => [];
}

class GetUomListFromDB extends AddNewOrderEvent {
  @override
  List<Object> get props => [];
}

class GetProductSchemaFromDB extends AddNewOrderEvent {
  GetProductSchemaFromDB(
      {required this.id,
      required this.totalAmount,
      required this.totalQuantity,
      required this.orderedUomId});

  int id;
  double totalAmount;
  int totalQuantity;
  int orderedUomId;

  @override
  List<Object> get props => [id, totalAmount, totalQuantity, orderedUomId];
}

class AddProductToCart extends AddNewOrderEvent {
  AddProductToCart({required this.productWithPriceModel});

  ProductWithPriceModel productWithPriceModel;

  @override
  List<Object> get props => [];
}

class GetAvailableStockOrder extends AddNewOrderEvent {
  const GetAvailableStockOrder({
    required this.warehouseId,
    required this.productId,
    required this.uoM,
  });

  final int warehouseId;
  final int productId;
  final int uoM;

  @override
  List<Object> get props => [warehouseId, productId, uoM];

  @override
  String toString() => '''
GetProductList {warehouseId: $warehouseId, productId: $productId, uoM: $uoM''';
}

class GetProductListCart extends AddNewOrderEvent {
  const GetProductListCart();

  @override
  List<Object> get props => [];
}

class GetProductPrice extends AddNewOrderEvent {
  const GetProductPrice({
    required this.productId,
  });

  final int productId;

  @override
  List<Object> get props => [productId];
}
class GetFreeProduct extends AddNewOrderEvent {
  const GetFreeProduct({
    required this.productId,
    required this.uomId,
  });

  final int productId;
  final int uomId;

  @override
  List<Object> get props => [productId,uomId];
}
