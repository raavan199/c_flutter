// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_pin_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPinRequest _$ResetPinRequestFromJson(Map<String, dynamic> json) =>
    ResetPinRequest(
      mobileNumber: json['mobileNumber'] as String,
      pin: json['pin'] as String,
    );

Map<String, dynamic> _$ResetPinRequestToJson(ResetPinRequest instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'pin': instance.pin,
    };
