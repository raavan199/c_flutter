import 'package:json_annotation/json_annotation.dart';
import 'visit_data_items_response.dart';

part 'manage_punch_response.g.dart';

/// Created by Dev 2183 on 01/07/2022
/// Modified by Dev 2183 on 01/07/2022
/// Purpose : This is a visit data response class which is used
/// to get visit data response.

@JsonSerializable()
class ManagePunchResponse {
  ManagePunchResponse(
      this.succeeded, this.message, this.errors
      );

  factory ManagePunchResponse.fromJson(Map<String, dynamic> json) =>
      _$ManagePunchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ManagePunchResponseToJson(this);

  bool? succeeded;
  String? message;
  String? errors;
}
