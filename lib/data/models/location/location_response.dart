

import 'package:cygneto/exports/models.dart';
import 'package:json_annotation/json_annotation.dart';


part 'location_response.g.dart';

@JsonSerializable()
class LocationResponse{

  @JsonKey(name: "data")
  Locationdata? data;

  @JsonKey(name:"succeeded")
  bool? succeeded;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;

  factory LocationResponse.fromJson(Map<String,dynamic> json)=>
      _$LocationResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$LocationResponseToJson(this);


  LocationResponse(
      this.data, this.succeeded, this.message, this.errors);
}