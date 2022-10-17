import 'package:json_annotation/json_annotation.dart';
import 'no_order_data.dart';

part 'no_order_response.g.dart';

@JsonSerializable()
class NoOrderResponse {
  NoOrderData? data;
  bool? succeeded;
  String? message;
  String? errors;
  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;

  NoOrderResponse({this.data, this.succeeded, this.message, this.errors, this.lastSyncTimeStamp});

  factory NoOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$NoOrderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NoOrderResponseToJson(this);

}