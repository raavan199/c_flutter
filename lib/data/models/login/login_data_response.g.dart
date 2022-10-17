// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginDataResponse _$LoginDataResponseFromJson(Map<String, dynamic> json) =>
    LoginDataResponse(
      fullName: json['fullName'] as String?,
      email: json['email'] as String?,
      jwtToken: json['jwtToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      image: json['image'] as String?,
      userId: json['userId'] as int?,
      isAdmin: json['isAdmin'] as bool?,
      userRoleName: json['userRoleName'] as String?,
      pinHash: json['pinHash'] as String?,
      userRoleRights: (json['userRoleRights'] as List<dynamic>?)
          ?.map(
              (e) => UserRoleRightsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LoginDataResponseToJson(LoginDataResponse instance) =>
    <String, dynamic>{
      'fullName': instance.fullName,
      'email': instance.email,
      'jwtToken': instance.jwtToken,
      'refreshToken': instance.refreshToken,
      'image': instance.image,
      'userId': instance.userId,
      'isAdmin': instance.isAdmin,
      'userRoleName': instance.userRoleName,
      'pinHash': instance.pinHash,
      'userRoleRights': instance.userRoleRights,
    };
