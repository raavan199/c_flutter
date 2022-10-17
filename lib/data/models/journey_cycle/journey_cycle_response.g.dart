// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_cycle_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JourneyCycleResponse _$JourneyCycleResponseFromJson(
        Map<String, dynamic> json) =>
    JourneyCycleResponse(
      json['succeeded'] as bool?,
      json['errors'] as String?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => JourneyCycleData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lastSyncTimeStamp = json['lastSyncTimeStamp'] as String?;

Map<String, dynamic> _$JourneyCycleResponseToJson(
        JourneyCycleResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'message': instance.message,
      'lastSyncTimeStamp': instance.lastSyncTimeStamp,
      'data': instance.data,
    };
