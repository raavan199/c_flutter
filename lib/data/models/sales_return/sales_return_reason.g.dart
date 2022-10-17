// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_reason.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnReason _$SalesReturnReasonFromJson(Map<String, dynamic> json) =>
    SalesReturnReason(
      json['createdBy'] as int?,
      json['createdOn'] as String?,
      json['modifiedBy'] as int?,
      json['modifiedOn'] as String?,
      json['subscriberId'] as int?,
      json['distributorId'] as int?,
      json['name'] as String,
      json['id'] as int?,
    );

Map<String, dynamic> _$SalesReturnReasonToJson(SalesReturnReason instance) =>
    <String, dynamic>{
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
      'subscriberId': instance.subscriberId,
      'distributorId': instance.distributorId,
      'name': instance.name,
    };
