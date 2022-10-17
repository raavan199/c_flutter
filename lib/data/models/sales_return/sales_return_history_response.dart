import 'package:json_annotation/json_annotation.dart';

import 'sales_return_item.dart';

part 'sales_return_history_response.g.dart';

@JsonSerializable()
class SalesReturnHistoryResponse {
  SalesReturnHistoryResponse(
      this.succeeded, this.errors, this.message, this.data);

  @JsonKey(name: "succeeded")
  bool? succeeded;
  @JsonKey(name: "errors")
  String? errors;
  @JsonKey(name: "message")
  String? message;
  String? lastSyncTimeStamp;
  @JsonKey(name: "data")
  List<SalesReturnItem>? data;

  factory SalesReturnHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SalesReturnHistoryResponseToJson(this);
}
