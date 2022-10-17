import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../user_role_rights/user_role_rights_response.dart';

part 'login_data_response.g.dart';

/// Created by Dev 2136 on 12/23/2021
/// Modified by Dev 2136 on 12/23/2021
/// Purpose : This is a login data response which will be used to parse the
/// response of login data.

@JsonSerializable()
@entity
class LoginDataResponse {
  LoginDataResponse({
    this.fullName,
    this.email,
    this.jwtToken,
    this.refreshToken,
    this.image,
    this.userId,
    this.isAdmin,
    this.userRoleName,
    this.pinHash,
    this.userRoleRights,
  });

  factory LoginDataResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginDataResponseToJson(this);

  @ColumnInfo(name: "full_name")
  @JsonKey(name: "fullName")
  String? fullName;

  @JsonKey(name: "email")
  String? email;

  @JsonKey(name: "jwtToken")
  String? jwtToken;

  @JsonKey(name: "refreshToken")
  String? refreshToken;

  @JsonKey(name: "image")
  String? image;

  @primaryKey
  @ColumnInfo(name: "user_id")
  @JsonKey(name: "userId")
  int? userId;

  @JsonKey(name: "isAdmin")
  bool? isAdmin;

  @JsonKey(name: "userRoleName")
  String? userRoleName;

  @ColumnInfo(name: "pin_hash")
  @JsonKey(name: "pinHash")
  String? pinHash;

  @ignore
  @JsonKey(name: "userRoleRights")
  List<UserRoleRightsResponse>? userRoleRights;
}
