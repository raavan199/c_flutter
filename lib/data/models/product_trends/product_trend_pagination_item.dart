import 'package:json_annotation/json_annotation.dart';

import 'product_trends_item.dart';

part 'product_trend_pagination_item.g.dart';
@JsonSerializable()
class ProductTrendPaginationItem{

  ProductTrendPaginationItem(
      {this.pageIndex,
        this.pageSize,
        this.totalCount,
        this.hasPreviousPage,
        this.hasNextPage, this.totalPages,
        required this.items});

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
  List<ProductTrendsItem>? items;


  factory ProductTrendPaginationItem.fromJson(Map<String, dynamic> json) =>
      _$ProductTrendPaginationItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTrendPaginationItemToJson(this);
}