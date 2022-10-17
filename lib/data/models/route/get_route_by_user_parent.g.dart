// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_route_by_user_parent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetRouteByUserParent _$GetRouteByUserParentFromJson(
        Map<String, dynamic> json) =>
    GetRouteByUserParent(
      json['data'] == null
          ? null
          : RouteData.fromJson(json['data'] as Map<String, dynamic>),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$GetRouteByUserParentToJson(
        GetRouteByUserParent instance) =>
    <String, dynamic>{
      'data': instance.routeData,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
