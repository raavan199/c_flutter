// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_invoice_mapping.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderInvoiceMapping _$OrderInvoiceMappingFromJson(Map<String, dynamic> json) =>
    OrderInvoiceMapping(
      id: json['id'] as int,
      orderId: json['orderId'] as int,
      date: json['date'] as String,
      secondaryInvoiceSerialNumber:
          json['secondaryInvoiceSerialNumber'] as String,
      distributorId: json['distributorId'] as int,
      fyId: json['fyId'] as int,
      jcId: json['jcId'] as int,
      customerId: json['customerId'] as int,
      deliveryStatus: json['deliveryStatus'] as int,
      subscriberId: json['subscriberId'] as int,
      secondaryInvoiceItems: (json['secondaryInvoiceItems'] as List<dynamic>?)
          ?.map((e) => InvoiceItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      vehicleId: json['vehicleId'] as int?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      invoiceStatementItems: (json['invoiceStatementItems'] as List<dynamic>?)
          ?.map((e) => InvoiceStatementItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPaid: json['isPaid'] as bool?,
      totalAmountOfInvoice: (json['totalAmountOfInvoice'] as num?)?.toDouble(),
      totalPaidAmountOfInvoice:
          (json['totalPaidAmountOfInvoice'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderInvoiceMappingToJson(
        OrderInvoiceMapping instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderId': instance.orderId,
      'date': instance.date,
      'secondaryInvoiceSerialNumber': instance.secondaryInvoiceSerialNumber,
      'distributorId': instance.distributorId,
      'fyId': instance.fyId,
      'jcId': instance.jcId,
      'customerId': instance.customerId,
      'vehicleId': instance.vehicleId,
      'deliveryStatus': instance.deliveryStatus,
      'subscriberId': instance.subscriberId,
      'secondaryInvoiceItems': instance.secondaryInvoiceItems,
      'invoiceStatementItems': instance.invoiceStatementItems,
      'isPaid': instance.isPaid,
      'totalAmountOfInvoice': instance.totalAmountOfInvoice,
      'totalPaidAmountOfInvoice': instance.totalPaidAmountOfInvoice,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
