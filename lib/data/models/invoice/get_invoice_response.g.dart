// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_invoice_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetInvoiceResponse _$GetInvoiceResponseFromJson(Map<String, dynamic> json) =>
    GetInvoiceResponse(
      data: json['data'] == null
          ? null
          : GetInvoiceDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$GetInvoiceResponseToJson(GetInvoiceResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
