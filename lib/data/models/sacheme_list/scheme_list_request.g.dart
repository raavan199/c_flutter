// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheme_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemeListRequest _$SchemeListRequestFromJson(Map<String, dynamic> json) =>
    SchemeListRequest(
      pageIndex: json['pageIndex'] as int,
      fromTimeStamp: json['fromTimeStamp'] as String?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
    );

Map<String, dynamic> _$SchemeListRequestToJson(SchemeListRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'fromTimeStamp': instance.fromTimeStamp,
    };
