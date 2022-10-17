// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_group_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGroupItems _$ProductGroupItemsFromJson(Map<String, dynamic> json) =>
    ProductGroupItems(
      name: json['name'] as String?,
      groupId: json['groupId'] as int?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ProductGroupItemsToJson(ProductGroupItems instance) =>
    <String, dynamic>{
      'name': instance.name,
      'groupId': instance.groupId,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
    };
