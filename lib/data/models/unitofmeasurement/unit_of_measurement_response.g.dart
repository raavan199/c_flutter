// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_of_measurement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UOMResponse _$UOMResponseFromJson(Map<String, dynamic> json) => UOMResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => UOMDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['succeeded'] as bool?,
      json['message'] as bool?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$UOMResponseToJson(UOMResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.error,
    };
