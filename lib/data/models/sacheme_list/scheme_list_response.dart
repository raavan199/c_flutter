import 'package:json_annotation/json_annotation.dart';

import 'scheme_list_data_response.dart';

part 'scheme_list_response.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a SchemeList response class which is used in
/// Scheme List api call.

@JsonSerializable()
class SchemeListResponse {
  SchemeListResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory SchemeListResponse.fromJson(Map<String, dynamic> json) =>
      _$SchemeListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchemeListResponseToJson(this);

  List<SchemeListDataResponse>? data;
  bool? succeeded;
  String? message;
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
