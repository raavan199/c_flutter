// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_category_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerCategoryDataResponse _$CustomerCategoryDataResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerCategoryDataResponse(
      subscriberId: json['subscriberId'] as int?,
      categoryName: json['categoryName'] as String?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CustomerCategoryDataResponseToJson(
        CustomerCategoryDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subscriberId': instance.subscriberId,
      'categoryName': instance.categoryName,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
