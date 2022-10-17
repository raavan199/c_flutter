// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_route_by_user_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RouteData _$RouteDataFromJson(Map<String, dynamic> json) => RouteData(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int?,
      totalCount: json['totalCount'] as int?,
      totalPages: json['totalPages'] as int?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => RouteItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RouteDataToJson(RouteData instance) => <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
