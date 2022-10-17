// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_type_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerTypeDataResponse _$CustomerTypeDataResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerTypeDataResponse(
      json['id'] as int?,
      json['subscriberId'] as int?,
      json['typeName'] as String?,
      json['createdBy'] as int?,
      json['createdOn'] as String?,
      json['modifiedBy'] as int?,
      json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$CustomerTypeDataResponseToJson(
        CustomerTypeDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subscriberId': instance.subscriberId,
      'typeName': instance.typeName,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
