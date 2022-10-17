// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_partners_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitPartnersResponse _$VisitPartnersResponseFromJson(
        Map<String, dynamic> json) =>
    VisitPartnersResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              VisitPartnersDataResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$VisitPartnersResponseToJson(
        VisitPartnersResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
