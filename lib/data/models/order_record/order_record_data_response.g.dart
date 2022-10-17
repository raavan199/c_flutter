// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_record_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderRecordDataResponse _$OrderRecordDataResponseFromJson(
        Map<String, dynamic> json) =>
    OrderRecordDataResponse(
      orderDate: json['orderDate'] as String?,
      orderSerialNumber: json['orderSerialNumber'] as String?,
      warehouseId: json['warehouseId'] as int?,
      distributorId: json['distributorId'] as int?,
      customerId: json['customerId'] as int?,
      orderType: json['orderType'] as int?,
      fsmOrderType: json['fsmOrderType'] as int?,
      totalBalanceDue: (json['totalBalanceDue'] as num?)?.toDouble() ?? 0,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      paymentMode: json['paymentMode'] as int? ?? 6,
      paymentStatus: json['paymentStatus'] as int? ?? 2,
      receivedAmount: (json['receivedAmount'] as num?)?.toDouble() ?? 0,
      pickAndPackStatus: json['pickAndPackStatus'] as int? ?? 0,
      billStatus: json['billStatus'] as int? ?? 0,
      subscriberId: json['subscriberId'] as int?,
      fyId: json['fyId'] as int?,
      jcId: json['jcId'] as int?,
      shippingAddress: json['shippingAddress'] as int?,
      billingAddress: json['billingAddress'] as int?,
      schemeId: json['schemeId'] as int?,
      referenceNumber: json['referenceNumber'] as String? ?? '',
      addedDiscount: (json['addedDiscount'] as num?)?.toDouble(),
      visitId: json['visitId'] as int?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      orderItem: (json['orderItem'] as List<dynamic>?)
          ?.map(
              (e) => OrderItemDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int?,
      visitPartnerName: json['visitPartnerName'] as String?,
      fullName: json['fullName'] as String?,
      TotalOrder: json['TotalOrder'] as int?,
    );

Map<String, dynamic> _$OrderRecordDataResponseToJson(
        OrderRecordDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderDate': instance.orderDate,
      'orderSerialNumber': instance.orderSerialNumber,
      'warehouseId': instance.warehouseId,
      'distributorId': instance.distributorId,
      'customerId': instance.customerId,
      'orderType': instance.orderType,
      'fsmOrderType': instance.fsmOrderType,
      'totalBalanceDue': instance.totalBalanceDue,
      'totalAmount': instance.totalAmount,
      'paymentMode': instance.paymentMode,
      'paymentStatus': instance.paymentStatus,
      'receivedAmount': instance.receivedAmount,
      'pickAndPackStatus': instance.pickAndPackStatus,
      'billStatus': instance.billStatus,
      'subscriberId': instance.subscriberId,
      'fyId': instance.fyId,
      'jcId': instance.jcId,
      'shippingAddress': instance.shippingAddress,
      'billingAddress': instance.billingAddress,
      'schemeId': instance.schemeId,
      'referenceNumber': instance.referenceNumber,
      'addedDiscount': instance.addedDiscount,
      'visitId': instance.visitId,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'orderItem': instance.orderItem,
      'visitPartnerName': instance.visitPartnerName,
      'fullName': instance.fullName,
      'TotalOrder': instance.TotalOrder,
    };
