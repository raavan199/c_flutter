// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey_cycle_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JourneyCycleData _$JourneyCycleDataFromJson(Map<String, dynamic> json) =>
    JourneyCycleData(
      json['financialYearId'] as int?,
      json['name'] as String?,
      json['startDate'] as String?,
      json['endDate'] as String?,
      json['createdBy'] as int?,
      json['createdOn'] as String?,
      json['modifiedBy'] as int?,
      json['modifiedOn'] as String?,
      json['id'] as int?,
    );

Map<String, dynamic> _$JourneyCycleDataToJson(JourneyCycleData instance) =>
    <String, dynamic>{
      'financialYearId': instance.financialYearId,
      'name': instance.name,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
    };
