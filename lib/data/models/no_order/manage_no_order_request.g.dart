// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_no_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageNoOrderRequest _$ManageNoOrderRequestFromJson(
        Map<String, dynamic> json) =>
    ManageNoOrderRequest(
      (json['data'] as List<dynamic>?)
          ?.map((e) => NoOrderRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManageNoOrderRequestToJson(
        ManageNoOrderRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
