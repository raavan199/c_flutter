// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'no_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoOrderRequest _$NoOrderRequestFromJson(Map<String, dynamic> json) =>
    NoOrderRequest(
      id: json['id'] as int?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      customerId: json['customerId'] as int?,
      noOrderTypeId: json['noOrderTypeId'] as int?,
      remarks: json['remarks'] as String?,
      isActive: json['isActive'] as bool?,
      visitId: json['visitId'] as int?,
    );

Map<String, dynamic> _$NoOrderRequestToJson(NoOrderRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'customerId': instance.customerId,
      'noOrderTypeId': instance.noOrderTypeId,
      'remarks': instance.remarks,
      'isActive': instance.isActive,
      'visitId': instance.visitId,
    };
