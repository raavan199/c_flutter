import 'package:json_annotation/json_annotation.dart';

part 'available_stock_request.g.dart';

/// Created by Dev 2136 on 01/21/2022
@JsonSerializable()
class AvailableStockRequest {
  AvailableStockRequest({
    required this.warehouseId,
    required this.productId,
    required this.uoM,
  });

  factory AvailableStockRequest.fromJson(Map<String, dynamic> json) =>
      _$AvailableStockRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AvailableStockRequestToJson(this);

  int warehouseId;
  int productId;
  int uoM;
}
