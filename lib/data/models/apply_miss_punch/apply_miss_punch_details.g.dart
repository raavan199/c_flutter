// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apply_miss_punch_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApplyMissedPunchDetails _$ApplyMissedPunchDetailsFromJson(
        Map<String, dynamic> json) =>
    ApplyMissedPunchDetails(
      id: json['id'] as int?,
      missedPunchId: json['missedPunchId'] as int?,
      punchInTime: json['punchInTime'] as String?,
      punchOutTime: json['punchOutTime'] as String?,
      status: json['status'] as int?,
    );

Map<String, dynamic> _$ApplyMissedPunchDetailsToJson(
        ApplyMissedPunchDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'missedPunchId': instance.missedPunchId,
      'punchInTime': instance.punchInTime,
      'punchOutTime': instance.punchOutTime,
      'status': instance.status,
    };
