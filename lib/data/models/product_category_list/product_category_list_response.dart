import 'package:json_annotation/json_annotation.dart';
import 'product_category_list_data_response.dart';

part 'product_category_list_response.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a product category list parent response class which is
/// used to get product category list response.

@JsonSerializable()
class ProductCategoryListResponse {
  ProductCategoryListResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory ProductCategoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryListResponseToJson(this);

  @JsonKey(name: "data")
  ProductCategoryListDataResponse? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
