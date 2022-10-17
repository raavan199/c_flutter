// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miss_punch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissPunchResponse _$MissPunchResponseFromJson(Map<String, dynamic> json) =>
    MissPunchResponse(
      data: json['data'] == null
          ? null
          : MissPunchData.fromJson(json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$MissPunchResponseToJson(MissPunchResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
