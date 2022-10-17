// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'district_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistrictRequest _$DistrictRequestFromJson(Map<String, dynamic> json) =>
    DistrictRequest(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
    );

Map<String, dynamic> _$DistrictRequestToJson(DistrictRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };
