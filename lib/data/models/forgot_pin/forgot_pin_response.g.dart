// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_pin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgotPinResponse _$ForgotPinResponseFromJson(Map<String, dynamic> json) =>
    ForgotPinResponse(
      json['data'] as bool?,
      json['succeeded'] as bool?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$ForgotPinResponseToJson(ForgotPinResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'errors': instance.error,
    };
