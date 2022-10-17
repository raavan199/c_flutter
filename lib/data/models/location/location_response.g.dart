// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      json['data'] == null
          ? null
          : Locationdata.fromJson(json['data'] as Map<String, dynamic>),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
