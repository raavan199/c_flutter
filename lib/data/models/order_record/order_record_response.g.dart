// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRecordResponse _$OrderRecordResponseFromJson(Map<String, dynamic> json) =>
    OrderRecordResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              OrderRecordDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$OrderRecordResponseToJson(
        OrderRecordResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
