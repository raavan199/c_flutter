// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_data_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseDataItemsResponse _$WarehouseDataItemsResponseFromJson(
        Map<String, dynamic> json) =>
    WarehouseDataItemsResponse(
      id: json['id'] as int,
      name: json['name'] as String?,
      locationId: json['locationId'] as int?,
      distributorId: json['distributorId'] as int?,
      subscriberId: json['subscriberId'] as int?,
      lastDamageUpdatedOn: json['lastDamageUpdatedOn'] as String?,
      lastExpiryUpdatedOn: json['lastExpiryUpdatedOn'] as String?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$WarehouseDataItemsResponseToJson(
        WarehouseDataItemsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'locationId': instance.locationId,
      'distributorId': instance.distributorId,
      'subscriberId': instance.subscriberId,
      'lastDamageUpdatedOn': instance.lastDamageUpdatedOn,
      'lastExpiryUpdatedOn': instance.lastExpiryUpdatedOn,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
