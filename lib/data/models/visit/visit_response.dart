import 'package:json_annotation/json_annotation.dart';

import 'visit_data_response.dart';

part 'visit_response.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a visit response class which is used in
/// visit api call.

@JsonSerializable()
class VisitResponse {
  VisitResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory VisitResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitResponseToJson(this);

  VisitDataResponse data;
  bool? succeeded;
  String? message;
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;

}
