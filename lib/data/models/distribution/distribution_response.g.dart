// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distribution_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistributionResponse _$DistributionResponseFromJson(
        Map<String, dynamic> json) =>
    DistributionResponse(
      (json['data'] as List<dynamic>?)
          ?.map((e) => DistributionData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['succeeded'] as bool?,
      json['message'] as String?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$DistributionResponseToJson(
        DistributionResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
