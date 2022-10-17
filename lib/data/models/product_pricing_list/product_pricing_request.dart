import 'package:cygneto/constants/app_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_pricing_request.g.dart';

/// Created by Dev 1051 on 1/7/2022
/// Purpose : This is a product pricing  request class which is used
/// in product pricing list api call.
@JsonSerializable()
class ProductPricingRequest {


  @JsonKey(name: "pageIndex")
  int? pageIndex;
  @JsonKey(name: "pageSize")
  int? pageSize;



  factory ProductPricingRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductPricingRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProductPricingRequestToJson(this);

  ProductPricingRequest({this.pageIndex,this.pageSize=PageIndex.pageSize,});
}
