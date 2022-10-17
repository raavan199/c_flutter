// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveBalance _$LeaveBalanceFromJson(Map<String, dynamic> json) => LeaveBalance(
      id: json['id'] as int?,
      leaveTypeName: json['leaveTypeName'] as String?,
      totalLeaves: json['totalLeaves'] as int?,
      availLeaves: (json['availLeaves'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LeaveBalanceToJson(LeaveBalance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'leaveTypeName': instance.leaveTypeName,
      'totalLeaves': instance.totalLeaves,
      'availLeaves': instance.availLeaves,
    };
