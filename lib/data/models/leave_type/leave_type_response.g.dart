// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_type_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeaveTypeResponse _$LeaveTypeResponseFromJson(Map<String, dynamic> json) =>
    LeaveTypeResponse(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => LeaveTypeData.fromJson(e as Map<String, dynamic>))
          .toList(),
      succeeded: json['succeeded'] as bool?,
      message: json['message'] as String?,
      errors: json['errors'] as String?,
    );

Map<String, dynamic> _$LeaveTypeResponseToJson(LeaveTypeResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'succeeded': instance.succeeded,
      'message': instance.message,
      'errors': instance.errors,
    };
