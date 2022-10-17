

import 'package:cygneto/exports/models.dart';
import 'package:json_annotation/json_annotation.dart';


part 'customer_category_response.g.dart';

@JsonSerializable()
class CustomerCategoryResponse{

  @JsonKey(name: "data")
  List<CustomerCategoryDataResponse>? data;

  @JsonKey(name:"succeeded")
  bool? succeeded;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"errors")
  String? errors;

  factory CustomerCategoryResponse.fromJson(Map<String,dynamic> json)=>
      _$CustomerCategoryResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$CustomerCategoryResponseToJson(this);


  CustomerCategoryResponse(
      this.data, this.succeeded, this.message, this.errors);
}