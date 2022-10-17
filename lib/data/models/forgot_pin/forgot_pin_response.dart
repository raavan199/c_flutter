import 'package:json_annotation/json_annotation.dart';

part 'forgot_pin_response.g.dart';

/// Created by Dev 1051 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a parent forgot pin response which will be used to parse the
/// response of forgot pin.
@JsonSerializable()
class ForgotPinResponse {
  ForgotPinResponse(this.data, this.succeeded, this.error);

  factory ForgotPinResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPinResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ForgotPinResponseToJson(this);

  @JsonKey(name: "data")
  bool? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "errors")
  String? error;
}
