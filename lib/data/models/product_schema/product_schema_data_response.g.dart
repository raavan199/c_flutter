// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_schema_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductSchemaData _$ProductSchemaDataFromJson(Map<String, dynamic> json) =>
    ProductSchemaData(
      product_id: json['productId'] as int?,
      scheme_id: json['schemeId'] as int?,
      is_active: json['isActive'] as bool?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$ProductSchemaDataToJson(ProductSchemaData instance) =>
    <String, dynamic>{
      'productId': instance.product_id,
      'schemeId': instance.scheme_id,
      'isActive': instance.is_active,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
    };
