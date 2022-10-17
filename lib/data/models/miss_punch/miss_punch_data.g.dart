// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'miss_punch_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MissPunchData _$MissPunchDataFromJson(Map<String, dynamic> json) =>
    MissPunchData(
      json['pageIndex'] as int?,
      json['pageSize'] as int?,
      json['totalCount'] as int?,
      json['totalPages'] as int?,
      json['hasPreviousPage'] as bool,
      json['hasNextPage'] as bool,
      (json['items'] as List<dynamic>?)
          ?.map((e) => MissPunchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MissPunchDataToJson(MissPunchData instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
