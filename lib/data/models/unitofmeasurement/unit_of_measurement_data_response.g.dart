// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'unit_of_measurement_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UOMDataResponse _$UOMDataResponseFromJson(Map<String, dynamic> json) =>
    UOMDataResponse(
      id: json['id'] as int?,
      uoMName: json['uoMName'] as String?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$UOMDataResponseToJson(UOMDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uoMName': instance.uoMName,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
