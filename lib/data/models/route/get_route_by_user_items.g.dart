// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_route_by_user_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteItems _$RouteItemsFromJson(Map<String, dynamic> json) => RouteItems(
      id: json['id'] as int?,
      name: json['name'] as String?,
      status: json['status'] as int?,
      subscriberId: json['subscriberId'] as int?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      totalOutlets: json['totalOutlets'] as int?,
      visitsCount: json['visitsCount'] as int?,
    );

Map<String, dynamic> _$RouteItemsToJson(RouteItems instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'subscriberId': instance.subscriberId,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'totalOutlets': instance.totalOutlets,
      'visitsCount': instance.visitsCount,
    };
