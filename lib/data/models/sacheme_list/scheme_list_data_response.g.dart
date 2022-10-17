// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scheme_list_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SchemeListDataResponse _$SchemeListDataResponseFromJson(
        Map<String, dynamic> json) =>
    SchemeListDataResponse(
      subscriberId: json['subscriberId'] as int?,
      name: json['name'] as String?,
      schemeType: json['schemeType'] as int?,
      distributorId: json['distributorId'] as int?,
      distributorType: json['distributorType'] as int?,
      customerId: json['customerId'] as int?,
      customerType: json['customerType'] as int?,
      customerCategory: json['customerCategory'] as int?,
      stateId: json['stateId'] as int?,
      fyId: json['fyId'] as int?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
      minTotalValue: (json['minTotalValue'] as num?)?.toDouble(),
      maxTotalValue: (json['maxTotalValue'] as num?)?.toDouble(),
      minOrderQnty: (json['minOrderQnty'] as num?)?.toDouble(),
      maxOrderQnty: (json['maxOrderQnty'] as num?)?.toDouble(),
      orderUOM: json['orderUOM'] as int?,
      complementaryQntyPercent:
          (json['complementaryQntyPercent'] as num?)?.toDouble(),
      complementaryUOM: json['complementaryUOM'] as int?,
      freeProductId: json['freeProductId'] as int?,
      additionalDiscountPercent:
          (json['additionalDiscountPercent'] as num?)?.toDouble(),
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$SchemeListDataResponseToJson(
        SchemeListDataResponse instance) =>
    <String, dynamic>{
      'subscriberId': instance.subscriberId,
      'name': instance.name,
      'schemeType': instance.schemeType,
      'distributorId': instance.distributorId,
      'distributorType': instance.distributorType,
      'customerId': instance.customerId,
      'customerType': instance.customerType,
      'customerCategory': instance.customerCategory,
      'stateId': instance.stateId,
      'fyId': instance.fyId,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'minTotalValue': instance.minTotalValue,
      'maxTotalValue': instance.maxTotalValue,
      'minOrderQnty': instance.minOrderQnty,
      'maxOrderQnty': instance.maxOrderQnty,
      'orderUOM': instance.orderUOM,
      'complementaryQntyPercent': instance.complementaryQntyPercent,
      'complementaryUOM': instance.complementaryUOM,
      'freeProductId': instance.freeProductId,
      'additionalDiscountPercent': instance.additionalDiscountPercent,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
    };
