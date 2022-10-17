// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_return_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesReturnRequest _$SalesReturnRequestFromJson(Map<String, dynamic> json) =>
    SalesReturnRequest(
      (json['data'] as List<dynamic>?)
          ?.map((e) => SalesReturnItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SalesReturnRequestToJson(SalesReturnRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
