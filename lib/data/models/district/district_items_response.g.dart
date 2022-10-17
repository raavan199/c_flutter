// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictItems _$DistrictItemsFromJson(Map<String, dynamic> json) =>
    DistrictItems(
      name: json['name'] as String?,
      stateId: json['stateId'] as int?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$DistrictItemsToJson(DistrictItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'stateId': instance.stateId,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
