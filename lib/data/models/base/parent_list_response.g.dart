// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentListResponse _$ParentListResponseFromJson(Map<String, dynamic> json) =>
    ParentListResponse(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => ProductTrendsItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParentListResponseToJson(ParentListResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
