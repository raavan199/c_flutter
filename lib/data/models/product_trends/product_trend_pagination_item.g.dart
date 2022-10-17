// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_trend_pagination_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTrendPaginationItem _$ProductTrendPaginationItemFromJson(
        Map<String, dynamic> json) =>
    ProductTrendPaginationItem(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int?,
      totalCount: json['totalCount'] as int?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      totalPages: json['totalPages'] as int?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ProductTrendsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductTrendPaginationItemToJson(
        ProductTrendPaginationItem instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
