// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'closing_balance_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClosingBalanceResponse _$ClosingBalanceResponseFromJson(
        Map<String, dynamic> json) =>
    ClosingBalanceResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ClosingBalance.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$ClosingBalanceResponseToJson(
        ClosingBalanceResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
