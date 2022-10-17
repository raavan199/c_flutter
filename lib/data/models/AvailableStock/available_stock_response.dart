import 'package:json_annotation/json_annotation.dart';

part 'available_stock_response.g.dart';

/// Created by Dev 1051 on 01/21/2022
@JsonSerializable()
class AvailableStockResponse {
  AvailableStockResponse(
    this.data,
    this.succeeded,
    this.message,
    this.error,
  );

  factory AvailableStockResponse.fromJson(Map<String, dynamic> json) =>
      _$AvailableStockResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableStockResponseToJson(this);

  double? data;
  bool succeeded;
  String? message;
  String? error;
}
