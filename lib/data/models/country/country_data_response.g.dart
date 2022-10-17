// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryData _$CountryDataFromJson(Map<String, dynamic> json) => CountryData(
      id: json['id'] as int?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      timeZone: json['timeZone'] as String?,
      currency: json['currency'] as String?,
      isDefault: json['isDefault'] as bool?,
      isActive: json['isActive'] as bool?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$CountryDataToJson(CountryData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'name': instance.name,
      'timeZone': instance.timeZone,
      'isDefault': instance.isDefault,
      'isActive': instance.isActive,
      'currency': instance.currency,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
    };
