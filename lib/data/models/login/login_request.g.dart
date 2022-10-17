// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) => LoginRequest(
      mobileNumber: json['mobileNumber'] as String,
      pin: json['pin'] as String,
      applicationVersion: json['applicationVersion'] as String?,
      deviceName: json['deviceName'] as String?,
      deviceType: json['deviceType'] as String?,
      osVersion: json['osVersion'] as String?,
    );

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{
      'mobileNumber': instance.mobileNumber,
      'pin': instance.pin,
      'deviceType': instance.deviceType,
      'osVersion': instance.osVersion,
      'applicationVersion': instance.applicationVersion,
      'deviceName': instance.deviceName,
    };
