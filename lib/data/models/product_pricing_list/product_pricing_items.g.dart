// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_pricing_items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductPricingItems _$ProductPricingItemsFromJson(Map<String, dynamic> json) =>
    ProductPricingItems(
      subscriberId: json['subscriberId'] as int?,
      productId: json['productId'] as int?,
      pricingType: json['pricingType'] as int?,
      hsn: json['hsn'] as String?,
      sgst: (json['sgst'] as num?)?.toDouble(),
      igst: (json['igst'] as num?)?.toDouble(),
      cgst: (json['cgst'] as num?)?.toDouble(),
      id: json['id'] as int?,
      mrp: (json['mrp'] as num?)?.toDouble(),
      minBasePrice: (json['minBasePrice'] as num?)?.toDouble(),
      maxBasePrice: (json['maxBasePrice'] as num?)?.toDouble(),
      stateId: json['stateId'] as int?,
      distributorId: json['distributorId'] as int?,
      distributorType: json['distributorType'] as int?,
      customerId: json['customerId'] as int?,
      customerType: json['customerType'] as int?,
      customerCategory: json['customerCategory'] as int?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      uoM: json['uoM'] as int?,
    );

Map<String, dynamic> _$ProductPricingItemsToJson(
        ProductPricingItems instance) =>
    <String, dynamic>{
      'subscriberId': instance.subscriberId,
      'productId': instance.productId,
      'pricingType': instance.pricingType,
      'hsn': instance.hsn,
      'cgst': instance.cgst,
      'sgst': instance.sgst,
      'igst': instance.igst,
      'mrp': instance.mrp,
      'minBasePrice': instance.minBasePrice,
      'maxBasePrice': instance.maxBasePrice,
      'stateId': instance.stateId,
      'distributorId': instance.distributorId,
      'distributorType': instance.distributorType,
      'customerId': instance.customerId,
      'customerType': instance.customerType,
      'customerCategory': instance.customerCategory,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
      'uoM': instance.uoM,
    };
