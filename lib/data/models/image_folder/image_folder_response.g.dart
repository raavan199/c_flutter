// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_folder_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageFolderResponse _$ImageFolderResponseFromJson(Map<String, dynamic> json) =>
    ImageFolderResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              ImageFolderDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$ImageFolderResponseToJson(
        ImageFolderResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
