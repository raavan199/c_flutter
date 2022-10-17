import 'package:json_annotation/json_annotation.dart';

part 'reset_pin_response.g.dart';

/// Created by Dev 1051 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a parent reset pin response which will be used to parse the
/// response of reset pin.
@JsonSerializable()
class ResetPinResponse {
  ResetPinResponse(this.data, this.succeeded, this.message, this.error);

  factory ResetPinResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPinResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ResetPinResponseToJson(this);

  @JsonKey(name: "data")
  bool? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  bool? message;

  @JsonKey(name: "errors")
  String? error;
}
