import 'package:json_annotation/json_annotation.dart';

import 'miss_punch_data.dart';


part 'miss_punch_response.g.dart';

@JsonSerializable()
class MissPunchResponse {
  MissPunchData? data;
  bool? succeeded;
  String? message;
  String? errors;

  MissPunchResponse({this.data, this.succeeded, this.message, this.errors});

  factory MissPunchResponse.fromJson(Map<String, dynamic> json) =>
      _$MissPunchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MissPunchResponseToJson(this);

}