import 'package:json_annotation/json_annotation.dart';

import 'punch_media_file_data.dart';

part 'punch_media_file_response.g.dart';

/// Created by Dev 2183 on 02/18/2022
/// Modified by Dev 2183 on 01/18/2022
/// Purpose : This is a visit data response class which is used
/// to get visit data response.

@JsonSerializable()
class PunchMediaFileResponse {
  PunchMediaFileResponse(
      this.data,
      this.succeeded, this.message, this.errors
      );

  factory PunchMediaFileResponse.fromJson(Map<String, dynamic> json) =>
      _$PunchMediaFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PunchMediaFileResponseToJson(this);

  PunchMediaFileData? data;
  bool? succeeded;
  String? message;
  String? errors;
}
