// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitOrderResponse _$VisitOrderResponseFromJson(Map<String, dynamic> json) =>
    VisitOrderResponse(
      data: (json['data'] as List<dynamic>)
          .map((e) => VisitOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$VisitOrderResponseToJson(VisitOrderResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
