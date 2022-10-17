// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseRequest _$WarehouseRequestFromJson(Map<String, dynamic> json) =>
    WarehouseRequest(
      pageIndex: json['pageIndex'] as int?,
      fromTimeStamp: json['fromTimeStamp'] as String?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
    );

Map<String, dynamic> _$WarehouseRequestToJson(WarehouseRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'fromTimeStamp': instance.fromTimeStamp,
    };
