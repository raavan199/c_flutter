// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_pin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPinResponse _$ResetPinResponseFromJson(Map<String, dynamic> json) =>
    ResetPinResponse(
      json['data'] as bool?,
      json['succeeded'] as bool?,
      json['message'] as bool?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$ResetPinResponseToJson(ResetPinResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.error,
    };
