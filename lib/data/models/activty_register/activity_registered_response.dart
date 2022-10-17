import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'activity_registered_response.g.dart';

@JsonSerializable()
class ActivityRegisteredResponse {
  ActivityRegisteredData? data;
  bool? succeeded;
  String? message;
  String? errors;
  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;


  ActivityRegisteredResponse(
      {this.data, this.succeeded, this.message, this.errors});


  factory ActivityRegisteredResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityRegisteredResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRegisteredResponseToJson(this);

}