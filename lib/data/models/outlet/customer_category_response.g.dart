// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_category_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerCategoryResponse _$CustomerCategoryResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerCategoryResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) =>
              CustomerCategoryDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$CustomerCategoryResponseToJson(
        CustomerCategoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
