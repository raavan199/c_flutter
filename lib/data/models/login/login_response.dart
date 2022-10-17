import 'package:json_annotation/json_annotation.dart';
import 'login_data_response.dart';

part 'login_response.g.dart';

/// Created by Dev 1051 on 7/15/2021
/// Modified by Dev 2136 on 12/23/2021
/// Purpose : This is a parent login response which will be used to parse the
/// response of login.
@JsonSerializable()
class LoginResponse {
  LoginResponse(this.userData, this.error);

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

  @JsonKey(name: "data")
  LoginDataResponse userData;

  @JsonKey(name: "errors")
  String? error;
}
