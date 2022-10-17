// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'manage_visit_punch_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ManageVisitPunchRequest _$ManageVisitPunchRequestFromJson(
        Map<String, dynamic> json) =>
    ManageVisitPunchRequest(
      (json['data'] as List<dynamic>?)
          ?.map(
              (e) => VisitDataItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ManageVisitPunchRequestToJson(
        ManageVisitPunchRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
