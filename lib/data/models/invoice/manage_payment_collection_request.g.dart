// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_payment_collection_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManagePaymentCollectionRequest _$ManagePaymentCollectionRequestFromJson(
        Map<String, dynamic> json) =>
    ManagePaymentCollectionRequest(
      (json['data'] as List<dynamic>?)
          ?.map((e) => InvoiceStatementItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManagePaymentCollectionRequestToJson(
        ManagePaymentCollectionRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
