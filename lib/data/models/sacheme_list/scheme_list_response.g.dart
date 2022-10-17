// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheme_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemeListResponse _$SchemeListResponseFromJson(Map<String, dynamic> json) =>
    SchemeListResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => SchemeListDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$SchemeListResponseToJson(SchemeListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
