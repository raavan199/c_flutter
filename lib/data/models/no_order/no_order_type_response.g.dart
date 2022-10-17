// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_order_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoOrderTypeResponse _$NoOrderTypeResponseFromJson(Map<String, dynamic> json) =>
    NoOrderTypeResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => NoOrderTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$NoOrderTypeResponseToJson(
        NoOrderTypeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
