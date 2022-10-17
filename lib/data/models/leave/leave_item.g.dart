// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveItem _$LeaveItemFromJson(Map<String, dynamic> json) => LeaveItem(
      id: json['id'] as int?,
      fromDate: json['fromDate'] as String?,
      toDate: json['toDate'] as String?,
      isHalfDay: json['isHalfDay'] as bool?,
      isFirstHalf: json['isFirstHalf'] as bool?,
      leaveTypeId: json['leaveTypeId'] as int?,
      remarks: json['remarks'] as String?,
      approverRemark: json['approverRemark'] as String?,
      leaveStatus: json['leaveStatus'] as int?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$LeaveItemToJson(LeaveItem instance) => <String, dynamic>{
      'id': instance.id,
      'fromDate': instance.fromDate,
      'toDate': instance.toDate,
      'isHalfDay': instance.isHalfDay,
      'isFirstHalf': instance.isFirstHalf,
      'leaveTypeId': instance.leaveTypeId,
      'remarks': instance.remarks,
      'approverRemark': instance.approverRemark,
      'leaveStatus': instance.leaveStatus,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
    };
