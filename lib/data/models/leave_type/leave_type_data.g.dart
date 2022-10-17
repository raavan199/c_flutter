// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeData _$LeaveTypeDataFromJson(Map<String, dynamic> json) =>
    LeaveTypeData(
      name: json['name'] as String?,
      totalDays: json['totalDays'] as int?,
      status: json['status'] as int?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$LeaveTypeDataToJson(LeaveTypeData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'totalDays': instance.totalDays,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
