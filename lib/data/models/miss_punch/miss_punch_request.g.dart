// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miss_punch_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissPunchRequest _$MissPunchRequestFromJson(Map<String, dynamic> json) =>
    MissPunchRequest(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
      missedPunchStatus: json['missedPunchStatus'] as int?,
    );

Map<String, dynamic> _$MissPunchRequestToJson(MissPunchRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'missedPunchStatus': instance.missedPunchStatus,
    };
