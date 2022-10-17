import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';


part 'attendance_response.g.dart';

@JsonSerializable()
class AttendanceResponse {
  AttendanceData? data;
  bool? succeeded;
  String? message;
  String? errors;

  String? lastSyncTimeStamp;

  AttendanceResponse({this.data, this.succeeded, this.message, this.errors});

  factory AttendanceResponse.fromJson(Map<String, dynamic> json) =>
      _$AttendanceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceResponseToJson(this);

}