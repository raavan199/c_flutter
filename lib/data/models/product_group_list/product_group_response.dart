

import 'package:json_annotation/json_annotation.dart';

import 'product_group_data_response.dart';


part 'product_group_response.g.dart';

@JsonSerializable()
class ProductGroupResponse{

  @JsonKey(name: "data")
  ProductGroupData? data;

  @JsonKey(name:"succeeded")
  bool? succeeded;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;

  factory ProductGroupResponse.fromJson(Map<String,dynamic> json)=>
      _$ProductGroupResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$ProductGroupResponseToJson(this);


  ProductGroupResponse(
      this.data, this.succeeded, this.message, this.errors);
}