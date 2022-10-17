// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_file_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageFileResponse _$ImageFileResponseFromJson(Map<String, dynamic> json) =>
    ImageFileResponse(
      data: json['data'] as String?,
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$ImageFileResponseToJson(ImageFileResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
