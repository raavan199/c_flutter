import 'package:json_annotation/json_annotation.dart';

part 'customer_category_request.g.dart';

/// Created by Dev 1051 on 1/10/2022
/// Purpose : This is a customer category request class which is used in customer
/// category api call.
@JsonSerializable()
class CustomerCategoryRequest {


  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;


  CustomerCategoryRequest({this.fromTimeStamp});

  factory CustomerCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerCategoryRequestFromJson(json);
  Map<String,dynamic> toJson() => _$CustomerCategoryRequestToJson(this);


}
