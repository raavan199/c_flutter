import 'package:json_annotation/json_annotation.dart';

part 'order_item_request.g.dart';

/// Created by Dev 2183 on 01/24/2022
/// Modified by Dev 2183 on 01/24/2022
/// Purpose : This is a Order Record request call which used for
/// Order Record API call

@JsonSerializable()
class OrderItemRequest {
  OrderItemRequest({
    required this.fromTimeStamp,
  });

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderItemRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemRequestToJson(this);

  String? fromTimeStamp;
}
