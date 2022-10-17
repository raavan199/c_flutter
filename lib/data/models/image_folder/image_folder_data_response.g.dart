// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_folder_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageFolderDataResponse _$ImageFolderDataResponseFromJson(
        Map<String, dynamic> json) =>
    ImageFolderDataResponse(
      id: json['id'] as int,
      name: json['name'] as String,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$ImageFolderDataResponseToJson(
        ImageFolderDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
