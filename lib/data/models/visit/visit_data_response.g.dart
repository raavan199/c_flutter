// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitDataResponse _$VisitDataResponseFromJson(Map<String, dynamic> json) =>
    VisitDataResponse(
      json['pageIndex'] as int?,
      json['pageSize'] as int?,
      json['totalCount'] as int?,
      json['totalPages'] as int?,
      json['hasPreviousPage'] as bool,
      json['hasNextPage'] as bool,
      (json['items'] as List<dynamic>?)
          ?.map(
              (e) => VisitDataItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$VisitDataResponseToJson(VisitDataResponse instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
