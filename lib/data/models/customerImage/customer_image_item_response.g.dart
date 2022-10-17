// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_image_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerImageItemResponse _$CustomerImageItemResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerImageItemResponse(
      fileName: json['fileName'] as String?,
      folderId: json['folderId'] as int?,
      mediaFileId: json['mediaFileId'] as int?,
      customerId: json['customerId'] as int?,
      isCover: json['isCover'] as bool?,
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CustomerImageItemResponseToJson(
        CustomerImageItemResponse instance) =>
    <String, dynamic>{
      'fileName': instance.fileName,
      'folderId': instance.folderId,
      'mediaFileId': instance.mediaFileId,
      'customerId': instance.customerId,
      'isCover': instance.isCover,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
      'id': instance.id,
    };
