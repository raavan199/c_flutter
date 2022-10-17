// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_trends_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductTrendsItem _$ProductTrendsItemFromJson(Map<String, dynamic> json) =>
    ProductTrendsItem(
      id: json['id'] as int?,
      productId: json['productId'] as int?,
      isFocus: json['isFocus'] as bool?,
      isNew: json['isNew'] as bool?,
      isMustSell: json['isMustSell'] as bool?,
      isOutletTrend: json['isOutletTrend'] as bool?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      isActive: json['isActive'] as bool?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      productTrendLocations: (json['productTrendLocations'] as List<dynamic>?)
          ?.map((e) =>
              ProductTrendsLocationItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProductTrendsItemToJson(ProductTrendsItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'isFocus': instance.isFocus,
      'isNew': instance.isNew,
      'isMustSell': instance.isMustSell,
      'isOutletTrend': instance.isOutletTrend,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isActive': instance.isActive,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'productTrendLocations': instance.productTrendLocations,
    };
