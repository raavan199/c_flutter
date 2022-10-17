import 'package:json_annotation/json_annotation.dart';
import 'product_list_data_items_response.dart';

part 'product_list_data_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type data response class which is used to get customer
/// type data response.

@JsonSerializable()
class ProductListDataResponse {
  ProductListDataResponse(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory ProductListDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListDataResponseToJson(this);

  @JsonKey(name: "pageIndex")
  int? pageIndex;

  @JsonKey(name: "pageSize")
  int? pageSize;

  @JsonKey(name: "totalCount")
  int? totalCount;

  @JsonKey(name: "totalPages")
  int? totalPages;

  @JsonKey(name: "hasPreviousPage")
  bool? hasPreviousPage;

  @JsonKey(name: "hasNextPage")
  bool? hasNextPage;

  @JsonKey(name: "items")
  List<ProductListDataItemsResponse>? items;
}
