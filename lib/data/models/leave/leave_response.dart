import 'package:cygneto/exports/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_response.g.dart';

@JsonSerializable()
class LeaveResponse{

  LeaveDataRequest? data;

  bool? succeeded;

  String? message;

  String? errors;

  String? lastSyncTimeStamp;

  factory LeaveResponse.fromJson(Map<String,dynamic> json)=>
      _$LeaveResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$LeaveResponseToJson(this);


  LeaveResponse(
      this.data, this.succeeded, this.message, this.errors);
}