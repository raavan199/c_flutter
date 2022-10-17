import 'package:json_annotation/json_annotation.dart';

import 'journey_cycle_data.dart';

part 'journey_cycle_response.g.dart';

@JsonSerializable()
class JourneyCycleResponse {
  JourneyCycleResponse(this.succeeded, this.errors, this.message, this.data);

  factory JourneyCycleResponse.fromJson(Map<String, dynamic> json) =>
      _$JourneyCycleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JourneyCycleResponseToJson(this);

  bool? succeeded;
  String? errors;
  String? message;
  String? lastSyncTimeStamp;
  List<JourneyCycleData>? data;
}
