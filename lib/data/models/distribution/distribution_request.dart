import 'package:json_annotation/json_annotation.dart';

part 'distribution_request.g.dart';

/// Created by Dev 1051 on /6/2022
/// Purpose : This is a distribution request class which is used in distribution api call.
@JsonSerializable()
class DistributionRequest {
  DistributionRequest({
    required this.fromTimeStamp
  });

  factory DistributionRequest.fromJson(Map<String, dynamic> json) =>
      _$DistributionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DistributionRequestToJson(this);

  String? fromTimeStamp;
}
