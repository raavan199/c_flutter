// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_item_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderItemDataResponse _$OrderItemDataResponseFromJson(
        Map<String, dynamic> json) =>
    OrderItemDataResponse(
      orderId: json['orderId'] as int?,
      storageId: json['storageId'] as int?,
      grnId: json['grnId'] as int?,
      rId: json['rId'] as int?,
      productId: json['productId'] as int?,
      hsnCode: json['hsnCode'] as String?,
      cgst: (json['cgst'] as num?)?.toDouble(),
      sgst: (json['sgst'] as num?)?.toDouble(),
      igst: (json['igst'] as num?)?.toDouble(),
      vat: (json['vat'] as num?)?.toDouble(),
      uoM: json['uoM'] as int?,
      pickAndPackStatus: json['pickAndPackStatus'] as int? ?? 0,
      availableQuantity: (json['availableQuantity'] as num?)?.toDouble() ?? 1,
      basePrice: (json['basePrice'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      orderQuantity: (json['orderQuantity'] as num?)?.toDouble(),
      schemeId: json['schemeId'] as int?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$OrderItemDataResponseToJson(
        OrderItemDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'storageId': instance.storageId,
      'grnId': instance.grnId,
      'rId': instance.rId,
      'productId': instance.productId,
      'hsnCode': instance.hsnCode,
      'cgst': instance.cgst,
      'sgst': instance.sgst,
      'igst': instance.igst,
      'vat': instance.vat,
      'uoM': instance.uoM,
      'pickAndPackStatus': instance.pickAndPackStatus,
      'availableQuantity': instance.availableQuantity,
      'basePrice': instance.basePrice,
      'discount': instance.discount,
      'orderQuantity': instance.orderQuantity,
      'schemeId': instance.schemeId,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
    };
