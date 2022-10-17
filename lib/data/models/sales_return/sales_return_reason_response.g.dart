// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_reason_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnReasonResponse _$SalesReturnReasonResponseFromJson(
        Map<String, dynamic> json) =>
    SalesReturnReasonResponse(
      json['succeeded'] as bool?,
      json['errors'] as String?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => SalesReturnReason.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lastSyncTimeStamp = json['lastSyncTimeStamp'] as String?;

Map<String, dynamic> _$SalesReturnReasonResponseToJson(
        SalesReturnReasonResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'message': instance.message,
      'lastSyncTimeStamp': instance.lastSyncTimeStamp,
      'data': instance.data,
    };
