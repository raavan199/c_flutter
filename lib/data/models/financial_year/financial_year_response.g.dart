// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_year_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancialYearResponse _$FinancialYearResponseFromJson(
        Map<String, dynamic> json) =>
    FinancialYearResponse(
      json['succeeded'] as bool?,
      json['errors'] as String?,
      json['message'] as String?,
      (json['data'] as List<dynamic>?)
          ?.map((e) => FinancialYearData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )..lastSyncTimeStamp = json['lastSyncTimeStamp'] as String?;

Map<String, dynamic> _$FinancialYearResponseToJson(
        FinancialYearResponse instance) =>
    <String, dynamic>{
      'succeeded': instance.succeeded,
      'errors': instance.errors,
      'message': instance.message,
      'lastSyncTimeStamp': instance.lastSyncTimeStamp,
      'data': instance.data,
    };
