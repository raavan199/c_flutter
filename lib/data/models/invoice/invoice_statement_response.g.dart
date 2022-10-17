// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_statement_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceStatementResponse _$InvoiceStatementResponseFromJson(
        Map<String, dynamic> json) =>
    InvoiceStatementResponse(
      data: json['data'] == null
          ? null
          : InvoiceStatementPaginationItem.fromJson(
              json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$InvoiceStatementResponseToJson(
        InvoiceStatementResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
