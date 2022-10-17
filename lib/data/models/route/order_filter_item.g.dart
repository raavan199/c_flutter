// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_filter_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderFilterItem _$OrderFilterItemFromJson(Map<String, dynamic> json) =>
    OrderFilterItem(
      customerId: json['customerId'] as int,
      businessName: json['businessName'] as String?,
      routeId: json['routeId'] as int?,
      orderId: json['orderId'] as int?,
      noOrderId: json['noOrderId'] as int?,
      Month: json['Month'] as String?,
      orderDate: json['orderDate'] as int?,
      noOrderDate: json['noOrderDate'] as int?,
    );

Map<String, dynamic> _$OrderFilterItemToJson(OrderFilterItem instance) =>
    <String, dynamic>{
      'customerId': instance.customerId,
      'businessName': instance.businessName,
      'orderId': instance.orderId,
      'noOrderId': instance.noOrderId,
      'Month': instance.Month,
      'routeId': instance.routeId,
      'orderDate': instance.orderDate,
      'noOrderDate': instance.noOrderDate,
    };
