// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AttendanceItem _$AttendanceItemFromJson(Map<String, dynamic> json) =>
    AttendanceItem(
      status: json['status'] as int?,
      attendanceDetails: (json['attendanceDetails'] as List<dynamic>?)
          ?.map((e) => AttendanceDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      attendanceStatus: json['attendanceStatus'] as int?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
      approverRemark: json['approverRemark'] as String?,
    );

Map<String, dynamic> _$AttendanceItemToJson(AttendanceItem instance) =>
    <String, dynamic>{
      'status': instance.status,
      'attendanceDetails': instance.attendanceDetails,
      'attendanceStatus': instance.attendanceStatus,
      'approverRemark': instance.approverRemark,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
    };
