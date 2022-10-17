import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'attendance_item.dart';

part 'upload_attendance_request.g.dart';

@JsonSerializable()
class UploadAttendanceRequest {
  List<AttendanceItem>? data;

  UploadAttendanceRequest({this.data});

  factory UploadAttendanceRequest.fromJson(Map<String, dynamic> json) =>
      _$UploadAttendanceRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    print('save Attendance request Json: ${jsonEncode(data)}');
    return data;
  }
}