// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationRequest _$LocationRequestFromJson(Map<String, dynamic> json) =>
    LocationRequest(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
      districtId: json['districtId'] as int?,
      fromTimeStamp: json['fromTimeStamp'] as String?,
    );

Map<String, dynamic> _$LocationRequestToJson(LocationRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'districtId': instance.districtId,
      'fromTimeStamp': instance.fromTimeStamp,
    };
