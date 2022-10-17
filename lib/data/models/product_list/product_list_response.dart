import 'package:json_annotation/json_annotation.dart';
import 'product_list_data_response.dart';

part 'product_list_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type parent response class which is used to get customer
/// type response.

@JsonSerializable()
class ProductListResponse {
  ProductListResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory ProductListResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListResponseToJson(this);

  @JsonKey(name: "data")
  ProductListDataResponse? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
