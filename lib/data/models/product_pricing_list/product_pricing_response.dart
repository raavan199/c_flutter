

import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'product_pricing_response.g.dart';


@JsonSerializable()
class ProductPricingResponse{

  @JsonKey(name: "data")
  ProductPricingData? data;

  @JsonKey(name:"succeeded")
  bool? succeeded;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;

  factory ProductPricingResponse.fromJson(Map<String,dynamic> json)=>
      _$ProductPricingResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$ProductPricingResponseToJson(this);


  ProductPricingResponse(
      this.data, this.succeeded, this.message, this.errors);
}