import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../login/login_data_response.dart';

part 'user_role_rights_response.g.dart';

/// Created by Dev 2136 on 12/23/2021
/// Modified by Dev 2136 on 12/23/2021
/// Purpose : This is a login data response which will be used to parse the
/// response of login data.

@JsonSerializable()
@Entity(foreignKeys: [
  ForeignKey(
      childColumns: ["user_id"],
      parentColumns: ["user_id"],
      entity: LoginDataResponse,
      onDelete: ForeignKeyAction.cascade)
])
class UserRoleRightsResponse {
  UserRoleRightsResponse(
      {this.userRoleId,
      this.userId,
      this.moduleName,
      this.functionName,
      this.interfaceName,
      this.create,
      this.modify,
      this.delete,
      this.cancel,
      this.selectPreview,
      this.print,
      this.export,
      this.approve,
      this.rejectDiscard,
      this.transfer,
      this.returnData,
      this.search,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.id});

  factory UserRoleRightsResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRoleRightsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserRoleRightsResponseToJson(this);

  @primaryKey
  @JsonKey(name: "id")
  int? id;

  @ColumnInfo(name: "user_role_id")
  @JsonKey(name: "userRoleId")
  int? userRoleId;

  @JsonKey(name: "moduleName")
  String? moduleName;

  @JsonKey(name: "functionName")
  String? functionName;

  @JsonKey(name: "interfaceName")
  String? interfaceName;

  @JsonKey(name: "create")
  bool? create;

  @JsonKey(name: "modify")
  bool? modify;

  @JsonKey(name: "delete")
  bool? delete;

  @JsonKey(name: "cancel")
  bool? cancel;

  @JsonKey(name: "selectPreview")
  bool? selectPreview;

  @JsonKey(name: "print")
  bool? print;

  @JsonKey(name: "export")
  bool? export;

  @JsonKey(name: "approve")
  bool? approve;

  @JsonKey(name: "rejectDiscard")
  bool? rejectDiscard;

  @JsonKey(name: "transfer")
  bool? transfer;

  @JsonKey(name: "return")
  bool? returnData;

  @JsonKey(name: "search")
  bool? search;

  @JsonKey(name: "createdBy")
  int? createdBy;

  @JsonKey(name: "createdOn")
  String? createdOn;

  @JsonKey(name: "modifiedBy")
  int? modifiedBy;

  @JsonKey(name: "modifiedOn")
  String? modifiedOn;

  @ColumnInfo(name: "user_id")
  @JsonKey(ignore: true)
  int? userId;
}
