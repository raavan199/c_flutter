// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_statement_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceStatementItem _$InvoiceStatementItemFromJson(
        Map<String, dynamic> json) =>
    InvoiceStatementItem(
      id: json['id'] as int,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      customerId: json['customerId'] as int,
      invoiceId: json['invoiceId'] as int,
      paidBy: json['paidBy'] as int,
      referenceNumber: json['referenceNumber'] as String?,
      amount: (json['amount'] as num?)?.toDouble(),
      distributorId: json['distributorId'] as int,
      subscriberId: json['subscriberId'] as int?,
      fyId: json['fyId'] as int,
      jcId: json['jcId'] as int,
      isSync: json['isSync'] as int?,
      visitId: json['visitId'] as int?,
    );

Map<String, dynamic> _$InvoiceStatementItemToJson(
        InvoiceStatementItem instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'invoiceId': instance.invoiceId,
      'paidBy': instance.paidBy,
      'referenceNumber': instance.referenceNumber,
      'amount': instance.amount,
      'distributorId': instance.distributorId,
      'subscriberId': instance.subscriberId,
      'fyId': instance.fyId,
      'jcId': instance.jcId,
      'isSync': instance.isSync,
      'visitId': instance.visitId,
      'id': instance.id,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
