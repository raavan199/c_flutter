
import 'package:cygneto/data/models/product_pricing_list/product_pricing_items.dart';
import 'package:json_annotation/json_annotation.dart';


part 'product_pricing_data_response.g.dart';

/// Created by Dev 1051 on 1/7/2022

@JsonSerializable()
class ProductPricingData{

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
  List<ProductPricingItems>? items;





  ProductPricingData({required this.pageIndex, required this.pageSize, required this.totalCount,
    required this.totalPages, required this.hasPreviousPage, this.hasNextPage,
    this.items});

  factory ProductPricingData.fromJson(Map<String,dynamic> json)=>
      _$ProductPricingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPricingDataToJson(this);


}