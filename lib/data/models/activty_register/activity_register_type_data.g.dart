// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_register_type_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRegisterTypeData _$ActivityRegisterTypeDataFromJson(
        Map<String, dynamic> json) =>
    ActivityRegisterTypeData(
      name: json['name'] as String?,
      status: json['status'] as int?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ActivityRegisterTypeDataToJson(
        ActivityRegisterTypeData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'status': instance.status,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
    };
