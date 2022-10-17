// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveDataRequest _$LeaveDataRequestFromJson(Map<String, dynamic> json) =>
    LeaveDataRequest(
      leaves: (json['leaves'] as List<dynamic>?)
          ?.map((e) => LeaveBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => LeaveItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeaveDataRequestToJson(LeaveDataRequest instance) =>
    <String, dynamic>{
      'leaves': instance.leaves,
      'items': instance.items,
    };
