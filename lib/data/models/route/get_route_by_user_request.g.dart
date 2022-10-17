// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_route_by_user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRouteByUserRequest _$GetRouteByUserRequestFromJson(
        Map<String, dynamic> json) =>
    GetRouteByUserRequest(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int? ?? 10,
      fromTimeStamp: json['fromTimeStamp'] as String?,
    );

Map<String, dynamic> _$GetRouteByUserRequestToJson(
        GetRouteByUserRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'fromTimeStamp': instance.fromTimeStamp,
    };
