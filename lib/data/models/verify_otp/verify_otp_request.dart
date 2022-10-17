import 'package:json_annotation/json_annotation.dart';

part 'verify_otp_request.g.dart';

/// Created by Dev 2136 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a verify otp request class which is used in verify otp api call.
@JsonSerializable()
class VerifyOtpRequest {
  VerifyOtpRequest({
    required this.mobileNumber,
    required this.otp,
  });

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);

  @JsonKey(name: "mobileNumber")
  String mobileNumber;

  @JsonKey(name: "otp")
  String otp;
}
