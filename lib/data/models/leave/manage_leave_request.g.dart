// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_leave_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageLeaveRequest _$ManageLeaveRequestFromJson(Map<String, dynamic> json) =>
    ManageLeaveRequest(
      (json['data'] as List<dynamic>?)
          ?.map((e) => LeaveItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManageLeaveRequestToJson(ManageLeaveRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
