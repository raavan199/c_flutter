// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_punch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagePunchResponse _$ManagePunchResponseFromJson(Map<String, dynamic> json) =>
    ManagePunchResponse(
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$ManagePunchResponseToJson(
        ManagePunchResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
