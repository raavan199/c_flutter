// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateRequest _$StateRequestFromJson(Map<String, dynamic> json) => StateRequest(
      pageIndex: json['pageIndex'] as int,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
    );

Map<String, dynamic> _$StateRequestToJson(StateRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };
