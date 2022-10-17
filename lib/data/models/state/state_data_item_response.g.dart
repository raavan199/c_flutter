// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_data_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateDataItemResponse _$StateDataItemResponseFromJson(
        Map<String, dynamic> json) =>
    StateDataItemResponse(
      json['id'] as int?,
      json['code'] as String?,
      json['name'] as String?,
      json['countryId'] as int?,
      json['createdBy'] as int?,
      json['createdOn'] as String?,
      json['modifiedBy'] as int?,
      json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$StateDataItemResponseToJson(
        StateDataItemResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'countryId': instance.countryId,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
