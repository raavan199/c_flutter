// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_registered_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRegisteredItem _$ActivityRegisteredItemFromJson(
        Map<String, dynamic> json) =>
    ActivityRegisteredItem(
      date: json['date'] as String?,
      details: json['details'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      activityTypeId: json['activityTypeId'] as int?,
      activityRegisterStatus: json['activityRegisterStatus'] as int?,
      status: json['status'] as int?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ActivityRegisteredItemToJson(
        ActivityRegisteredItem instance) =>
    <String, dynamic>{
      'date': instance.date,
      'details': instance.details,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'activityTypeId': instance.activityTypeId,
      'activityRegisterStatus': instance.activityRegisterStatus,
      'status': instance.status,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
    };
