import 'package:json_annotation/json_annotation.dart';

part 'order_filter_item.g.dart';

@JsonSerializable()
class OrderFilterItem {
  OrderFilterItem({
    required this.customerId,
    required this.businessName,
    required this.routeId,
    this.orderId,
    this.noOrderId,
    this.Month,
    this.orderDate,
    this.noOrderDate,
  });

  int customerId;
  String? businessName;
  int? orderId;
  int? noOrderId;
  String? Month;
  int? routeId;
  int? orderDate;
  int? noOrderDate;

  factory OrderFilterItem.fromJson(Map<String, dynamic> json) =>
      _$OrderFilterItemFromJson(json);

  Map<String, dynamic> toJson() => _$OrderFilterItemToJson(this);
}
