// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_activity_register_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveActivityRegisterRequest _$SaveActivityRegisterRequestFromJson(
        Map<String, dynamic> json) =>
    SaveActivityRegisterRequest(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ActivityRegisteredItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SaveActivityRegisterRequestToJson(
        SaveActivityRegisterRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
