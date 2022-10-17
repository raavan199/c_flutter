// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCustomerResponse _$AddCustomerResponseFromJson(Map<String, dynamic> json) =>
    AddCustomerResponse(
      data: json['data'] == null
          ? null
          : CustomerDataItemsResponse.fromJson(
              json['data'] as Map<String, dynamic>),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$AddCustomerResponseToJson(
        AddCustomerResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
