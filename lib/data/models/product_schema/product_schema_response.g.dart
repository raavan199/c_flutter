// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_schema_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSchemaResponse _$ProductSchemaResponseFromJson(
        Map<String, dynamic> json) =>
    ProductSchemaResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => ProductSchemaData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$ProductSchemaResponseToJson(
        ProductSchemaResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
