// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'punch_media_file_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PunchMediaFileData _$PunchMediaFileDataFromJson(Map<String, dynamic> json) =>
    PunchMediaFileData(
      module: json['module'] as int?,
      filePath: json['filePath'] as String?,
      fileName: json['fileName'] as String?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$PunchMediaFileDataToJson(PunchMediaFileData instance) =>
    <String, dynamic>{
      'module': instance.module,
      'filePath': instance.filePath,
      'fileName': instance.fileName,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
    };
