// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_trends_location_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTrendsLocationItem _$ProductTrendsLocationItemFromJson(
        Map<String, dynamic> json) =>
    ProductTrendsLocationItem(
      id: json['id'] as int?,
      productTrendId: json['productTrendId'] as int?,
      locationId: json['locationId'] as int?,
      isActive: json['isActive'] as bool?,
    );

Map<String, dynamic> _$ProductTrendsLocationItemToJson(
        ProductTrendsLocationItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productTrendId': instance.productTrendId,
      'locationId': instance.locationId,
      'isActive': instance.isActive,
    };
