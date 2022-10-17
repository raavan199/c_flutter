// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_registered_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActivityRegisteredData _$ActivityRegisteredDataFromJson(
        Map<String, dynamic> json) =>
    ActivityRegisteredData(
      json['pageIndex'] as int?,
      json['pageSize'] as int?,
      json['totalCount'] as int?,
      json['totalPages'] as int?,
      json['hasPreviousPage'] as bool?,
      json['hasNextPage'] as bool?,
      (json['items'] as List<dynamic>?)
          ?.map(
              (e) => ActivityRegisteredItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ActivityRegisteredDataToJson(
        ActivityRegisteredData instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
