import 'package:json_annotation/json_annotation.dart';
import 'product_category_list_data_items_response.dart';

part 'product_category_list_data_response.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a product category list data response class which is used
/// to get product category list data response.

@JsonSerializable()
class ProductCategoryListDataResponse {
  ProductCategoryListDataResponse(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory ProductCategoryListDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryListDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryListDataResponseToJson(this);

  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  bool hasPreviousPage;
  bool hasNextPage;
  List<ProductCategoryListDataItemsResponse>? items;
}
