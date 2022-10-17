

import 'package:json_annotation/json_annotation.dart';

import 'distribution_data_response.dart';

part 'distribution_response.g.dart';

@JsonSerializable()
class DistributionResponse{

  @JsonKey(name: "data")
  List<DistributionData>? data;

  @JsonKey(name:"succeeded")
  bool? succeeded;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;

  factory DistributionResponse.fromJson(Map<String,dynamic> json)=>
      _$DistributionResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$DistributionResponseToJson(this);


  DistributionResponse(
      this.data, this.succeeded, this.message, this.errors);
}