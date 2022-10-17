// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_pricing_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPricingRequest _$ProductPricingRequestFromJson(
        Map<String, dynamic> json) =>
    ProductPricingRequest(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
    );

Map<String, dynamic> _$ProductPricingRequestToJson(
        ProductPricingRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };
