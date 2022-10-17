// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_registered_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRegisteredResponse _$ActivityRegisteredResponseFromJson(
        Map<String, dynamic> json) =>
    ActivityRegisteredResponse(
      data: json['data'] == null
          ? null
          : ActivityRegisteredData.fromJson(
              json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$ActivityRegisteredResponseToJson(
        ActivityRegisteredResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
