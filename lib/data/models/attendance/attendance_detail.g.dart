// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceDetails _$AttendanceDetailsFromJson(Map<String, dynamic> json) =>
    AttendanceDetails(
      attendanceId: json['attendanceId'] as int?,
      punchInTime: json['punchInTime'] as String?,
      punchOutTime: json['punchOutTime'] as String?,
      punchInMediaFileId: json['punchInMediaFileId'] as int?,
      punchOutMediaFileId: json['punchOutMediaFileId'] as int?,
      status: json['status'] as int?,
      punchInImagePath: json['punchInImagePath'] as String?,
      punchOutImagePath: json['punchOutImagePath'] as String?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$AttendanceDetailsToJson(AttendanceDetails instance) =>
    <String, dynamic>{
      'attendanceId': instance.attendanceId,
      'punchInTime': instance.punchInTime,
      'punchOutTime': instance.punchOutTime,
      'punchInMediaFileId': instance.punchInMediaFileId,
      'punchOutMediaFileId': instance.punchOutMediaFileId,
      'status': instance.status,
      'punchInImagePath': instance.punchInImagePath,
      'punchOutImagePath': instance.punchOutImagePath,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
    };
