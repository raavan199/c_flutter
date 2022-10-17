// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'financial_year_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FinancialYearData _$FinancialYearDataFromJson(Map<String, dynamic> json) =>
    FinancialYearData(
      json['name'] as String?,
      json['startDate'] as String?,
      json['endDate'] as String?,
      json['isCurrentYear'] as bool,
      json['createdBy'] as int?,
      json['createdOn'] as String?,
      json['modifiedBy'] as int?,
      json['modifiedOn'] as String?,
      json['id'] as int?,
    );

Map<String, dynamic> _$FinancialYearDataToJson(FinancialYearData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'isCurrentYear': instance.isCurrentYear,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
    };
