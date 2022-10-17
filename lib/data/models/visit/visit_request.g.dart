// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitRequest _$VisitRequestFromJson(Map<String, dynamic> json) => VisitRequest(
      pageIndex: json['pageIndex'] as int,
      fromTimeStamp: json['fromTimeStamp'] as String?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
    );

Map<String, dynamic> _$VisitRequestToJson(VisitRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'fromTimeStamp': instance.fromTimeStamp,
    };
