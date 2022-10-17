// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_stock_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableStockRequest _$AvailableStockRequestFromJson(
        Map<String, dynamic> json) =>
    AvailableStockRequest(
      warehouseId: json['warehouseId'] as int,
      productId: json['productId'] as int,
      uoM: json['uoM'] as int,
    );

Map<String, dynamic> _$AvailableStockRequestToJson(
        AvailableStockRequest instance) =>
    <String, dynamic>{
      'warehouseId': instance.warehouseId,
      'productId': instance.productId,
      'uoM': instance.uoM,
    };
