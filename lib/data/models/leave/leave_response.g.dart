// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveResponse _$LeaveResponseFromJson(Map<String, dynamic> json) =>
    LeaveResponse(
      json['data'] == null
          ? null
          : LeaveDataRequest.fromJson(json['data'] as Map<String, dynamic>),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    )..lastSyncTimeStamp = json['lastSyncTimeStamp'] as String?;

Map<String, dynamic> _$LeaveResponseToJson(LeaveResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
      'lastSyncTimeStamp': instance.lastSyncTimeStamp,
    };
