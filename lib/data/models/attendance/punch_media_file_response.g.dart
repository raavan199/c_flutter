// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punch_media_file_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PunchMediaFileResponse _$PunchMediaFileResponseFromJson(
        Map<String, dynamic> json) =>
    PunchMediaFileResponse(
      json['data'] == null
          ? null
          : PunchMediaFileData.fromJson(json['data'] as Map<String, dynamic>),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$PunchMediaFileResponseToJson(
        PunchMediaFileResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
