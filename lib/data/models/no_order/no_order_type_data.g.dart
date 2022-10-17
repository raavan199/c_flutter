// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_order_type_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoOrderTypeData _$NoOrderTypeDataFromJson(Map<String, dynamic> json) =>
    NoOrderTypeData(
      typeName: json['typeName'] as String?,
      isActive: json['isActive'] as bool?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$NoOrderTypeDataToJson(NoOrderTypeData instance) =>
    <String, dynamic>{
      'typeName': instance.typeName,
      'isActive': instance.isActive,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
    };
