import 'package:json_annotation/json_annotation.dart';
import 'state_data_response.dart';

part 'state_response.g.dart';

/// Created by Dev 1051 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a parent reset pin response which will be used to parse the
/// response of reset pin.
@JsonSerializable()
class StateResponse {
  StateResponse(this.data, this.succeeded, this.message, this.error);

  factory StateResponse.fromJson(Map<String, dynamic> json) =>
      _$StateResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StateResponseToJson(this);

  @JsonKey(name: "data")
  StateDataResponse? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  bool? message;

  @JsonKey(name: "errors")
  String? error;
}
