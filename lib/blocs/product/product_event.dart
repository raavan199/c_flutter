part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

class GetProductList extends ProductEvent {
  const GetProductList({required this.outletInfo, required this.result});

  final CustomerDataItemsResponse outletInfo;
  final Map<String, int?> result;

  @override
  List<Object> get props => [outletInfo, result];

  @override
  String toString() => '''
GetProductList {}''';
}

class GetProductTrendList extends ProductEvent {
  const GetProductTrendList({required this.locationId});

  final int locationId;

  @override
  List<Object> get props => [locationId];
}
class DeleteAllProductsFromCart extends ProductEvent {
  const DeleteAllProductsFromCart();

  @override
  List<Object> get props => [];
}

class GetAvailableStock extends ProductEvent {
  const GetAvailableStock({
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

class GetProductListFromCart extends ProductEvent {
  const GetProductListFromCart();

  @override
  List<Object> get props => [];
}
