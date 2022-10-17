// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'state_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StateResponse _$StateResponseFromJson(Map<String, dynamic> json) =>
    StateResponse(
      json['data'] == null
          ? null
          : StateDataResponse.fromJson(json['data'] as Map<String, dynamic>),
      json['succeeded'] as bool?,
      json['message'] as bool?,
      json['errors'] as String?,
    );

Map<String, dynamic> _$StateResponseToJson(StateResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.error,
    };
