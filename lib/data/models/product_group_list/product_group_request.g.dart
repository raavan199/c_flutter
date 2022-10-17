// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_group_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGroupRequest _$ProductGroupRequestFromJson(Map<String, dynamic> json) =>
    ProductGroupRequest(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int? ?? PageIndex.pageSize,
      status: json['status'] as int?,
      sortBy: json['sortBy'] as String?,
      sortDesc: json['sortDesc'] as bool?,
      fromTimeStamp: json['fromTimeStamp'] as String?,
    );

Map<String, dynamic> _$ProductGroupRequestToJson(
        ProductGroupRequest instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'status': instance.status,
      'sortBy': instance.sortBy,
      'sortDesc': instance.sortDesc,
      'fromTimeStamp': instance.fromTimeStamp,
    };
