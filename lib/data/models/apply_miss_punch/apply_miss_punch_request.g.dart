// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_miss_punch_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyMissPunchRequest _$ApplyMissPunchRequestFromJson(
        Map<String, dynamic> json) =>
    ApplyMissPunchRequest(
      id: json['id'] as int?,
      applyReason: json['applyReason'] as String?,
      reApplyReason: json['reApplyReason'] as String?,
      missedPunchDetails: (json['missedPunchDetails'] as List<dynamic>?)
          ?.map((e) =>
              ApplyMissedPunchDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ApplyMissPunchRequestToJson(
        ApplyMissPunchRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'applyReason': instance.applyReason,
      'reApplyReason': instance.reApplyReason,
      'missedPunchDetails': instance.missedPunchDetails,
    };
