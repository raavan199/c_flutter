
import 'package:json_annotation/json_annotation.dart';

import 'product_group_item.dart';

part 'product_group_data_response.g.dart';

/// Created by Dev 1051 on 1/6/2022

@JsonSerializable()
class ProductGroupData{

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
  List<ProductGroupItems>? items;





  ProductGroupData({required this.pageIndex, required this.pageSize, required this.totalCount,
    required this.totalPages, required this.hasPreviousPage, this.hasNextPage,
    this.items});

  factory ProductGroupData.fromJson(Map<String,dynamic> json)=>
      _$ProductGroupDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductGroupDataToJson(this);


}