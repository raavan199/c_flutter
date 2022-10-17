// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_list_data_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryListDataItemsResponse
    _$ProductCategoryListDataItemsResponseFromJson(Map<String, dynamic> json) =>
        ProductCategoryListDataItemsResponse(
          name: json['name'] as String?,
          categoryId: json['categoryId'] as int?,
          createdBy: json['createdBy'] as int?,
          createdOn: json['createdOn'] as String?,
          modifiedBy: json['modifiedBy'] as int?,
          modifiedOn: json['modifiedOn'] as String?,
          id: json['id'] as int?,
        );

Map<String, dynamic> _$ProductCategoryListDataItemsResponseToJson(
        ProductCategoryListDataItemsResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'categoryId': instance.categoryId,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
    };
