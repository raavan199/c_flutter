// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Locationdata _$LocationdataFromJson(Map<String, dynamic> json) => Locationdata(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int?,
      totalCount: json['totalCount'] as int?,
      totalPages: json['totalPages'] as int?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => LocationDataItems.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationdataToJson(Locationdata instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
