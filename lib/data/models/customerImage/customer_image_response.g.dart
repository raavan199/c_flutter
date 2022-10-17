// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerImageResponse _$CustomerImageResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerImageResponse(
      json['data'] == null
          ? null
          : CustomerImageDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$CustomerImageResponseToJson(
        CustomerImageResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
