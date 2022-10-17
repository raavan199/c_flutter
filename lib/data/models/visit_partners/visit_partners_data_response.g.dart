// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_partners_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitPartnersDataResponse _$VisitPartnersDataResponseFromJson(
        Map<String, dynamic> json) =>
    VisitPartnersDataResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      createdOn: json['createdOn'] as String?,
      modifiedOn: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$VisitPartnersDataResponseToJson(
        VisitPartnersDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdOn': instance.createdOn,
      'modifiedOn': instance.modifiedOn,
    };
