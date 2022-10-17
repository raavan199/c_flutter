// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_stock_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvailableStockResponse _$AvailableStockResponseFromJson(
        Map<String, dynamic> json) =>
    AvailableStockResponse(
      (json['data'] as num?)?.toDouble(),
      json['succeeded'] as bool,
      json['message'] as String?,
      json['error'] as String?,
    );

Map<String, dynamic> _$AvailableStockResponseToJson(
        AvailableStockResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'error': instance.error,
    };
