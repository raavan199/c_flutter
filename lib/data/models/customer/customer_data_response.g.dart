// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDataResponse _$CustomerDataResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerDataResponse(
      json['pageIndex'] as int?,
      json['pageSize'] as int?,
      json['totalCount'] as int?,
      json['totalPages'] as int?,
      json['hasPreviousPage'] as bool?,
      json['hasNextPage'] as bool?,
      (json['items'] as List<dynamic>?)
          ?.map((e) =>
              CustomerDataItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerDataResponseToJson(
        CustomerDataResponse instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
