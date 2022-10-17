// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_attendance_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadAttendanceRequest _$UploadAttendanceRequestFromJson(
        Map<String, dynamic> json) =>
    UploadAttendanceRequest(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AttendanceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UploadAttendanceRequestToJson(
        UploadAttendanceRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
