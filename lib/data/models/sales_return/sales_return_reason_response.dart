import 'package:json_annotation/json_annotation.dart';

import 'sales_return_reason.dart';

part 'sales_return_reason_response.g.dart';

@JsonSerializable()
class SalesReturnReasonResponse {
  SalesReturnReasonResponse(
      this.succeeded, this.errors, this.message, this.data);

  @JsonKey(name: "succeeded")
  bool? succeeded;
  @JsonKey(name: "errors")
  String? errors;
  @JsonKey(name: "message")
  String? message;
  String? lastSyncTimeStamp;
  @JsonKey(name: "data")
  List<SalesReturnReason>? data;

  factory SalesReturnReasonResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnReasonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalesReturnReasonResponseToJson(this);
}
