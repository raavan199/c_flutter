import 'package:json_annotation/json_annotation.dart';

part 'reset_pin_request.g.dart';

/// Created by Dev 2136 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a reset pin request class which is used in reset pin api call.
@JsonSerializable()
class ResetPinRequest {
  ResetPinRequest({
    required this.mobileNumber,
    required this.pin,
  });

  factory ResetPinRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPinRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPinRequestToJson(this);

  @JsonKey(name: "mobileNumber")
  String mobileNumber;

  @JsonKey(name: "pin")
  String pin;
}
