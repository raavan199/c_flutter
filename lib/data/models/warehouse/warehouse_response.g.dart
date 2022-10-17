// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'warehouse_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseResponse _$WarehouseResponseFromJson(Map<String, dynamic> json) =>
    WarehouseResponse(
      data: json['data'] == null
          ? null
          : WarehouseDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$WarehouseResponseToJson(WarehouseResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
