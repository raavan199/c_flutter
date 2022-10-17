// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_data_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListDataItemsResponse _$ProductListDataItemsResponseFromJson(
        Map<String, dynamic> json) =>
    ProductListDataItemsResponse(
      id: json['id'] as int?,
      name: json['name'] as String?,
      productCode: json['productCode'] as String?,
      groupId: json['groupId'] as int?,
      subGroupId: json['subGroupId'] as int?,
      categoryId: json['categoryId'] as int?,
      subCategoryId: json['subCategoryId'] as int?,
      uom: json['uom'] as int?,
      uoM1: json['uoM1'] as int?,
      uoM2: json['uoM2'] as int?,
      uoM3: json['uoM3'] as int?,
      uoM4: json['uoM4'] as int?,
      subscriberId: json['subscriberId'] as int?,
      uoM2Value: json['uoM2Value'] as int?,
      uoM3Value: json['uoM3Value'] as int?,
      isSellableUoM1: json['isSellableUoM1'] as bool?,
      isSellableUoM2: json['isSellableUoM2'] as bool?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      uom1Name: json['uom1Name'] as String?,
      uom2Name: json['uom2Name'] as String?,
    );

Map<String, dynamic> _$ProductListDataItemsResponseToJson(
        ProductListDataItemsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'productCode': instance.productCode,
      'groupId': instance.groupId,
      'subGroupId': instance.subGroupId,
      'categoryId': instance.categoryId,
      'subCategoryId': instance.subCategoryId,
      'uom': instance.uom,
      'uoM1': instance.uoM1,
      'uoM2': instance.uoM2,
      'uoM3': instance.uoM3,
      'uoM4': instance.uoM4,
      'subscriberId': instance.subscriberId,
      'uoM2Value': instance.uoM2Value,
      'uoM3Value': instance.uoM3Value,
      'isSellableUoM1': instance.isSellableUoM1,
      'isSellableUoM2': instance.isSellableUoM2,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'uom1Name': instance.uom1Name,
      'uom2Name': instance.uom2Name,
    };
