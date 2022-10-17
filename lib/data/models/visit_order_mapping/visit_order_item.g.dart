// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_order_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitOrderItem _$VisitOrderItemFromJson(Map<String, dynamic> json) =>
    VisitOrderItem(
      orderId: json['orderId'] as int?,
      visitId: json['visitId'] as int?,
      isActive: json['isActive'] as bool?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
      paymentCollectionId: json['paymentCollectionId'] as int?,
      salesReturnRegisterId: json['salesReturnRegisterId'] as int?,
    );

Map<String, dynamic> _$VisitOrderItemToJson(VisitOrderItem instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'visitId': instance.visitId,
      'isActive': instance.isActive,
      'paymentCollectionId': instance.paymentCollectionId,
      'salesReturnRegisterId': instance.salesReturnRegisterId,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
    };
