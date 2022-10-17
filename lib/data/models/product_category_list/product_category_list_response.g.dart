// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductCategoryListResponse _$ProductCategoryListResponseFromJson(
        Map<String, dynamic> json) =>
    ProductCategoryListResponse(
      data: json['data'] == null
          ? null
          : ProductCategoryListDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$ProductCategoryListResponseToJson(
        ProductCategoryListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
