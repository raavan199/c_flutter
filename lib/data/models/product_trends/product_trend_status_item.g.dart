// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_trend_status_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTrendStatusItem _$ProductTrendStatusItemFromJson(
        Map<String, dynamic> json) =>
    ProductTrendStatusItem(
      data: ProductTrendPaginationItem.fromJson(
          json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$ProductTrendStatusItemToJson(
        ProductTrendStatusItem instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
