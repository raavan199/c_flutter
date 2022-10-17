// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_order_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoOrderData _$NoOrderDataFromJson(Map<String, dynamic> json) => NoOrderData(
      json['pageIndex'] as int?,
      json['pageSize'] as int?,
      json['totalCount'] as int?,
      json['totalPages'] as int?,
      json['hasPreviousPage'] as bool?,
      json['hasNextPage'] as bool?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => NoOrderRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NoOrderDataToJson(NoOrderData instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
