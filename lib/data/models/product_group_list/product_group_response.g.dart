// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductGroupResponse _$ProductGroupResponseFromJson(
        Map<String, dynamic> json) =>
    ProductGroupResponse(
      json['data'] == null
          ? null
          : ProductGroupData.fromJson(json['data'] as Map<String, dynamic>),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$ProductGroupResponseToJson(
        ProductGroupResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
