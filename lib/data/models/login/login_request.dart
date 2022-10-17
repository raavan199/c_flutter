import 'package:json_annotation/json_annotation.dart';

part 'login_request.g.dart';

/// Created by Dev 1051 on 7/15/2021
/// Modified by Dev 1051 on 12/23/2021
/// Purpose : This is a login request class which is used in login api call.
@JsonSerializable()
class LoginRequest {

  LoginRequest({
    required this.mobileNumber,
    required this.pin,
    this.applicationVersion,
    this.deviceName,
    this.deviceType,
    this.osVersion
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);

  @JsonKey(name: "mobileNumber")
  String mobileNumber;

  @JsonKey(name: "pin")
  String pin;

  @JsonKey(name: "deviceType")
  String? deviceType;

  @JsonKey(name: "osVersion")
  String? osVersion;

  @JsonKey(name: "applicationVersion")
  String? applicationVersion;

  @JsonKey(name: "deviceName")
  String? deviceName;

}
