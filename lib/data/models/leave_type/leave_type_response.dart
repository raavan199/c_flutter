import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'leave_type_response.g.dart';

@JsonSerializable()
class LeaveTypeResponse {
  List<LeaveTypeData>? data;
  bool? succeeded;
  String? message;
  String? errors;

  LeaveTypeResponse({this.data, this.succeeded, this.message, this.errors});

  factory LeaveTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeResponseToJson(this);

}