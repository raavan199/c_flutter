// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerTypeResponse _$CustomerTypeResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerTypeResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              CustomerTypeDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$CustomerTypeResponseToJson(
        CustomerTypeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
