import 'package:json_annotation/json_annotation.dart';

part 'forgot_pin_request.g.dart';

/// Created by Dev 2136 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a forgot pin request class which is used in forgot pin api call.
@JsonSerializable()
class ForgotPinRequest {
  ForgotPinRequest({
    required this.mobileNumber,
  });

  factory ForgotPinRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgotPinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPinRequestToJson(this);

  @JsonKey(name: "mobileNumber")
  String mobileNumber;
}
