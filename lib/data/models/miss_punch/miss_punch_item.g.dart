// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miss_punch_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissPunchItem _$MissPunchItemFromJson(Map<String, dynamic> json) =>
    MissPunchItem(
      attendanceId: json['attendanceId'] as int?,
      missedPunchStatus: json['missedPunchStatus'] as int?,
      status: json['status'] as int?,
      applyReason: json['applyReason'] as String?,
      reApplyReason: json['reApplyReason'] as String?,
      approverRemark: json['approverRemark'] as String?,
      missedPunchDetails: (json['missedPunchDetails'] as List<dynamic>?)
          ?.map((e) => MissedPunchDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      hours: json['hours'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$MissPunchItemToJson(MissPunchItem instance) =>
    <String, dynamic>{
      'attendanceId': instance.attendanceId,
      'missedPunchStatus': instance.missedPunchStatus,
      'status': instance.status,
      'applyReason': instance.applyReason,
      'reApplyReason': instance.reApplyReason,
      'approverRemark': instance.approverRemark,
      'missedPunchDetails': instance.missedPunchDetails,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'hours': instance.hours,
      'id': instance.id,
    };
