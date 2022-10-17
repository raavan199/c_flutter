// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductListResponse _$ProductListResponseFromJson(Map<String, dynamic> json) =>
    ProductListResponse(
      data: json['data'] == null
          ? null
          : ProductListDataResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$ProductListResponseToJson(
        ProductListResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
