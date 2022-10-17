import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_response.g.dart';

/// Created by Dev 1051 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a parent verify otp response which will be used to parse the
/// response of verify otp.
@JsonSerializable()
class VerifyOtpResponse {
  VerifyOtpResponse(this.data, this.succeeded, this.message, this.error);

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpResponseFromJson(json);
  Map<String, dynamic> toJson() => _$VerifyOtpResponseToJson(this);

  @JsonKey(name: "data")
  bool? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  bool? message;

  @JsonKey(name: "errors")
  String? error;
}
