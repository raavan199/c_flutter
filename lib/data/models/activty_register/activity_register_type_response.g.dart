// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_register_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRegisterTypeResponse _$ActivityRegisterTypeResponseFromJson(
        Map<String, dynamic> json) =>
    ActivityRegisterTypeResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ActivityRegisterTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$ActivityRegisterTypeResponseToJson(
        ActivityRegisterTypeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
