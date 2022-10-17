// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miss_punch_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissedPunchDetails _$MissedPunchDetailsFromJson(Map<String, dynamic> json) =>
    MissedPunchDetails(
      missedPunchId: json['missedPunchId'] as int?,
      punchInTime: json['punchInTime'] as String?,
      punchOutTime: json['punchOutTime'] as String?,
      punchInMediaFileId: json['punchInMediaFileId'] as int?,
      punchOutMediaFileId: json['punchOutMediaFileId'] as int?,
      status: json['status'] as int?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$MissedPunchDetailsToJson(MissedPunchDetails instance) =>
    <String, dynamic>{
      'missedPunchId': instance.missedPunchId,
      'punchInTime': instance.punchInTime,
      'punchOutTime': instance.punchOutTime,
      'punchInMediaFileId': instance.punchInMediaFileId,
      'punchOutMediaFileId': instance.punchOutMediaFileId,
      'status': instance.status,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
    };
