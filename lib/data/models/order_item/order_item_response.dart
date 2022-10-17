import 'package:json_annotation/json_annotation.dart';

import 'order_item_data_response.dart';

part 'order_item_response.g.dart';

/// Created by Dev 2183 on 01/24/2022
/// Modified by Dev 2183 on 01/24/2022
/// Purpose : This is a Order record response class which is used in
/// Order record API call

@JsonSerializable()
class OrderItemResponse {
  OrderItemResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemResponseToJson(this);

  List<OrderItemDataResponse>? data;
  bool? succeeded;
  String? message;
  String? errors;
}
