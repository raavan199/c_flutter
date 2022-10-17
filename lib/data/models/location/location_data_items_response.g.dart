// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_data_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDataItems _$LocationDataItemsFromJson(Map<String, dynamic> json) =>
    LocationDataItems(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      countryId: json['countryId'] as int?,
      stateId: json['stateId'] as int?,
      districtId: json['districtId'] as int?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$LocationDataItemsToJson(LocationDataItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'countryId': instance.countryId,
      'stateId': instance.stateId,
      'districtId': instance.districtId,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
    };
