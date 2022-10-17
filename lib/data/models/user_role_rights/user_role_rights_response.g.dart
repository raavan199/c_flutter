// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_role_rights_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRoleRightsResponse _$UserRoleRightsResponseFromJson(
        Map<String, dynamic> json) =>
    UserRoleRightsResponse(
      userRoleId: json['userRoleId'] as int?,
      moduleName: json['moduleName'] as String?,
      functionName: json['functionName'] as String?,
      interfaceName: json['interfaceName'] as String?,
      create: json['create'] as bool?,
      modify: json['modify'] as bool?,
      delete: json['delete'] as bool?,
      cancel: json['cancel'] as bool?,
      selectPreview: json['selectPreview'] as bool?,
      print: json['print'] as bool?,
      export: json['export'] as bool?,
      approve: json['approve'] as bool?,
      rejectDiscard: json['rejectDiscard'] as bool?,
      transfer: json['transfer'] as bool?,
      returnData: json['return'] as bool?,
      search: json['search'] as bool?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$UserRoleRightsResponseToJson(
        UserRoleRightsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userRoleId': instance.userRoleId,
      'moduleName': instance.moduleName,
      'functionName': instance.functionName,
      'interfaceName': instance.interfaceName,
      'create': instance.create,
      'modify': instance.modify,
      'delete': instance.delete,
      'cancel': instance.cancel,
      'selectPreview': instance.selectPreview,
      'print': instance.print,
      'export': instance.export,
      'approve': instance.approve,
      'rejectDiscard': instance.rejectDiscard,
      'transfer': instance.transfer,
      'return': instance.returnData,
      'search': instance.search,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
