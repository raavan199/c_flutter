import 'package:json_annotation/json_annotation.dart';

part 'unit_of_measurement_request.g.dart';

/// Created by Dev 1051 on /6/2022
/// Purpose : This is a unit of measurement request class which
/// is used in unit of measurement api call.
@JsonSerializable()
class UOMRequest {


  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;


  UOMRequest({
    required this.fromTimeStamp
  });

  factory UOMRequest.fromJson(Map<String, dynamic> json) =>
      _$UOMRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UOMRequestToJson(this);


}
