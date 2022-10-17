// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListRequest _$ProductListRequestFromJson(Map<String, dynamic> json) =>
    ProductListRequest(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
    );

Map<String, dynamic> _$ProductListRequestToJson(ProductListRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
    };
