// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryListRequest _$ProductCategoryListRequestFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryListRequest(
      pageIndex: json['pageIndex'] as int?,
      status: json['status'] as int?,
      sortBy: json['sortBy'] as String?,
      sortDesc: json['sortDesc'] as bool?,
      fromTimeStamp: json['fromTimeStamp'] as String?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
    );

Map<String, dynamic> _$ProductCategoryListRequestToJson(
        ProductCategoryListRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'status': instance.status,
      'sortBy': instance.sortBy,
      'sortDesc': instance.sortDesc,
      'fromTimeStamp': instance.fromTimeStamp,
    };
