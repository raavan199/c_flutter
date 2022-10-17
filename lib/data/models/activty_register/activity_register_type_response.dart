import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'activity_register_type_response.g.dart';

/// Created by Dev 2183 on 02/17/2022
/// Modified by Dev 2183 on 02/17/2022
/// Purpose : This is a Activity Type response class which is used
/// to get Activity Type data response.

@JsonSerializable()
class ActivityRegisterTypeResponse {
  ActivityRegisterTypeResponse(
      this.data,
      this.succeeded, this.message, this.errors
      );

  factory ActivityRegisterTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$ActivityRegisterTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRegisterTypeResponseToJson(this);

  List<ActivityRegisterTypeData>? data;
  bool? succeeded;
  String? message;
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
