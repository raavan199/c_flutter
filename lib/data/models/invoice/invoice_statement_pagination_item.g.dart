// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invoice_statement_pagination_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvoiceStatementPaginationItem _$InvoiceStatementPaginationItemFromJson(
        Map<String, dynamic> json) =>
    InvoiceStatementPaginationItem(
      json['pageIndex'] as int?,
      json['pageSize'] as int?,
      json['totalCount'] as int?,
      json['totalPages'] as int?,
      json['hasPreviousPage'] as bool?,
      json['hasNextPage'] as bool?,
      (json['items'] as List<dynamic>?)
          ?.map((e) => InvoiceStatementItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InvoiceStatementPaginationItemToJson(
        InvoiceStatementPaginationItem instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
