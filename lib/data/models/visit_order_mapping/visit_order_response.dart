import 'package:json_annotation/json_annotation.dart';

import 'visit_order_item.dart';

part 'visit_order_response.g.dart';

@JsonSerializable()
class VisitOrderResponse {
  VisitOrderResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory VisitOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitOrderResponseToJson(this);

  @JsonKey(name: "data")
  List<VisitOrderItem> data;
  @JsonKey(name: "succeeded")
  bool? succeeded;
  @JsonKey(name: "message")
  String? message;
  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
