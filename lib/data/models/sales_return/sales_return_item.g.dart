// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnItem _$SalesReturnItemFromJson(Map<String, dynamic> json) =>
    SalesReturnItem(
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
      returnDate: json['returnDate'] as String?,
      warehouseId: json['warehouseId'] as int?,
      customerId: json['customerId'] as int?,
      productId: json['productId'] as int?,
      secondaryInvoiceId: json['secondaryInvoiceId'] as int?,
      rate: (json['rate'] as num?)?.toDouble(),
      storageId: json['storageId'] as int?,
      sellableQuantity: (json['sellableQuantity'] as num?)?.toDouble(),
      damagedQuantity: (json['damagedQuantity'] as num?)?.toDouble(),
      uoM: json['uoM'] as int?,
      reasonId: json['reasonId'] as int?,
      fyId: json['fyId'] as int?,
      jcId: json['jcId'] as int?,
      remark: json['remark'] as String?,
      grnId: json['grnId'] as int?,
      rId: json['rId'] as int?,
      subscriberId: json['subscriberId'] as int?,
      distributorId: json['distributorId'] as int?,
      batchNumber: json['batchNumber'] as String?,
      cgst: (json['cgst'] as num?)?.toDouble(),
      sgst: (json['sgst'] as num?)?.toDouble(),
      igst: (json['igst'] as num?)?.toDouble(),
      isApprove: json['isApprove'] as bool?,
      isCancel: json['isCancel'] as bool?,
      isSync: json['isSync'] as int?,
      productName: json['productName'] as String?,
      uomName: json['uomName'] as String?,
      visitId: json['visitId'] as int?,
    );

Map<String, dynamic> _$SalesReturnItemToJson(SalesReturnItem instance) =>
    <String, dynamic>{
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
      'returnDate': instance.returnDate,
      'warehouseId': instance.warehouseId,
      'customerId': instance.customerId,
      'productId': instance.productId,
      'secondaryInvoiceId': instance.secondaryInvoiceId,
      'rate': instance.rate,
      'storageId': instance.storageId,
      'sellableQuantity': instance.sellableQuantity,
      'damagedQuantity': instance.damagedQuantity,
      'uoM': instance.uoM,
      'reasonId': instance.reasonId,
      'fyId': instance.fyId,
      'jcId': instance.jcId,
      'remark': instance.remark,
      'grnId': instance.grnId,
      'rId': instance.rId,
      'subscriberId': instance.subscriberId,
      'distributorId': instance.distributorId,
      'batchNumber': instance.batchNumber,
      'cgst': instance.cgst,
      'sgst': instance.sgst,
      'igst': instance.igst,
      'isApprove': instance.isApprove,
      'isCancel': instance.isCancel,
      'productName': instance.productName,
      'uomName': instance.uomName,
      'isSync': instance.isSync,
      'visitId': instance.visitId,
    };