import 'package:cygneto/data/models/state/state_data_response.dart';
import 'package:json_annotation/json_annotation.dart';

import 'unit_of_measurement_data_response.dart';

part 'unit_of_measurement_response.g.dart';

/// Created by Dev 1051 on 1/06/2022
/// Purpose : This is a parent unit of measurement response which will be used to parse the
/// response of unit of measurement
@JsonSerializable()
class UOMResponse {
  UOMResponse(this.data, this.succeeded, this.message, this.error);

  factory UOMResponse.fromJson(Map<String, dynamic> json) =>
      _$UOMResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UOMResponseToJson(this);

  @JsonKey(name: "data")
  List<UOMDataResponse>? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  bool? message;

  @JsonKey(name: "errors")
  String? error;
}
