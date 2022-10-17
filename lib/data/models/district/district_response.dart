

import 'package:json_annotation/json_annotation.dart';

import 'district_data_response.dart';

part 'district_response.g.dart';

@JsonSerializable()
class DistrictResponse{
  DistrictResponse(
      this.routeData, this.succeeded, this.message, this.errors);

  factory DistrictResponse.fromJson(Map<String,dynamic> json)=>
      _$DistrictResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$DistrictResponseToJson(this);

  @JsonKey(name: "data")
  DistrictData? routeData;

  @JsonKey(name:"succeeded")
  bool? succeeded;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"errors")
  String? errors;
}