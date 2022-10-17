// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_history_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnHistoryResponse _$SalesReturnHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    SalesReturnHistoryResponse(
      json['succeeded'] as bool?,
      json['errors'] as String?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => SalesReturnItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lastSyncTimeStamp = json['lastSyncTimeStamp'] as String?;

Map<String, dynamic> _$SalesReturnHistoryResponseToJson(
        SalesReturnHistoryResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'message': instance.message,
      'lastSyncTimeStamp': instance.lastSyncTimeStamp,
      'data': instance.data,
    };
