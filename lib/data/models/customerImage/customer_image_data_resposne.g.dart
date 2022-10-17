// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_image_data_resposne.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerImageDataResponse _$CustomerImageDataResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerImageDataResponse(
      pageIndex: json['pageIndex'] as int?,
      pageSize: json['pageSize'] as int?,
      totalCount: json['totalCount'] as int?,
      totalPages: json['totalPages'] as int?,
      hasPreviousPage: json['hasPreviousPage'] as bool?,
      hasNextPage: json['hasNextPage'] as bool?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) =>
              CustomerImageItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerImageDataResponseToJson(
        CustomerImageDataResponse instance) =>
    <String, dynamic>{
      'pageIndex': instance.pageIndex,
      'pageSize': instance.pageSize,
      'totalCount': instance.totalCount,
      'totalPages': instance.totalPages,
      'hasPreviousPage': instance.hasPreviousPage,
      'hasNextPage': instance.hasNextPage,
      'items': instance.items,
    };
