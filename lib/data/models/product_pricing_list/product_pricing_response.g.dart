// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_pricing_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPricingResponse _$ProductPricingResponseFromJson(
        Map<String, dynamic> json) =>
    ProductPricingResponse(
      json['data'] == null
          ? null
          : ProductPricingData.fromJson(json['data'] as Map<String, dynamic>),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$ProductPricingResponseToJson(
        ProductPricingResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
