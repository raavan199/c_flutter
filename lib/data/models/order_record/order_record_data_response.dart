import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../order_item/order_item_data_response.dart';

part 'order_record_data_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a visit partners data response class which is used in
/// visit partners data api call.

@JsonSerializable()
@Entity(tableName: "OrderRecord")
class OrderRecordDataResponse {
  OrderRecordDataResponse({
    this.orderDate,
    this.orderSerialNumber,
    this.warehouseId,
    this.distributorId,
    this.customerId,
    this.orderType,
    this.fsmOrderType,
    this.totalBalanceDue = 0,
    this.totalAmount,
    this.paymentMode = 6,
    this.paymentStatus = 2,
    this.receivedAmount = 0,
    this.pickAndPackStatus = 0,
    this.billStatus = 0,
    this.subscriberId,
    this.fyId,
    this.jcId,
    this.shippingAddress,
    this.billingAddress,
    this.schemeId,
    this.referenceNumber = '',
    this.addedDiscount,
    this.visitId,
    this.created_by,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.orderItem,
    this.isSync = 1,
    this.id,
    this.visitPartnerName,
    this.fullName,
    this.TotalOrder,
  });

  factory OrderRecordDataResponse.fromJsonF0rRowQuery(
          Map<String, dynamic> json) =>
      OrderRecordDataResponse(
        id: json['id'] as int?,
        fullName: json['full_name'] as String?,
        visitPartnerName: json['VisitPartner_Name'] as String?,
        orderDate: json['order_date'] as String?,
        customerId: json['customer_id'] as int?,
        totalAmount: (json['total_amount'] as num?)?.toDouble(),
        TotalOrder: json['TotalOrder'] as int?,
        distributorId: json['distributor_id'] as int?,
        orderSerialNumber: json['order_serial_number'] as String?,
      );

  factory OrderRecordDataResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderRecordDataResponseFromJson(json);

  // Map<String, dynamic> toJson() => _$OrderRecordDataResponseToJson(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.created_by;
    data['createdOn'] = this.created_on;
    data['modifiedBy'] = this.modified_by;
    data['modifiedOn'] = this.modified_on;
    data['orderDate'] = this.orderDate;
    data['orderSerialNumber'] = this.orderSerialNumber;
    data['warehouseId'] = this.warehouseId;
    data['distributorId'] = this.distributorId;
    data['customerId'] = this.customerId;
    data['orderType'] = this.orderType;
    data['fsmOrderType'] = this.fsmOrderType;
    data['totalBalanceDue'] = this.totalBalanceDue;
    data['totalAmount'] = this.totalAmount;
    data['paymentMode'] = this.paymentMode;
    data['paymentStatus'] = this.paymentStatus;
    data['receivedAmount'] = this.receivedAmount;
    data['pickAndPackStatus'] = this.pickAndPackStatus;
    data['billStatus'] = this.billStatus;
    data['subscriberId'] = this.subscriberId;
    data['fyId'] = this.fyId;
    data['jcId'] = this.jcId;
    data['shippingAddress'] = this.shippingAddress;
    data['billingAddress'] = this.billingAddress;
    data['schemeId'] = this.schemeId;
    data['referenceNumber'] = this.referenceNumber;
    if (this.orderItem != null) {
      data['orderItem'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    data['addedDiscount'] = this.addedDiscount;
    data['visitId'] = this.visitId;
    print('Place Order: ${jsonEncode(data)}');
    return data;
  }

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "orderDate")
  @ColumnInfo(name: "order_date")
  String? orderDate;

  @JsonKey(name: "orderSerialNumber")
  @ColumnInfo(name: "order_serial_number")
  String? orderSerialNumber;

  @JsonKey(name: "warehouseId")
  @ColumnInfo(name: "warehouse_id")
  int? warehouseId;

  @JsonKey(name: "distributorId")
  @ColumnInfo(name: "distributor_id")
  int? distributorId;

  @JsonKey(name: "customerId")
  @ColumnInfo(name: "customer_id")
  int? customerId;

  @JsonKey(name: "orderType")
  @ColumnInfo(name: "order_type")
  int? orderType;

  int? fsmOrderType;

  @JsonKey(name: "totalBalanceDue")
  @ColumnInfo(name: "total_balance_due")
  double? totalBalanceDue;

  @JsonKey(name: "totalAmount")
  @ColumnInfo(name: "total_amount")
  double? totalAmount;

  @JsonKey(name: "paymentMode")
  @ColumnInfo(name: "payment_mode")
  int? paymentMode;

  @JsonKey(name: "paymentStatus")
  @ColumnInfo(name: "payment_status")
  int? paymentStatus;

  @JsonKey(name: "receivedAmount")
  @ColumnInfo(name: "received_amount")
  double? receivedAmount;

  @JsonKey(name: "pickAndPackStatus")
  @ColumnInfo(name: "pick_adn_pack_status")
  int? pickAndPackStatus;

  @JsonKey(name: "billStatus")
  @ColumnInfo(name: "bill_status")
  int? billStatus;

  @JsonKey(name: "subscriberId")
  @ColumnInfo(name: "subscriber_id")
  int? subscriberId;

  @JsonKey(name: "fyId")
  @ColumnInfo(name: "fy_id")
  int? fyId;

  @JsonKey(name: "jcId")
  @ColumnInfo(name: "jc_id")
  int? jcId;

  @JsonKey(name: "shippingAddress")
  @ColumnInfo(name: "shipping_address")
  int? shippingAddress;

  @JsonKey(name: "billingAddress")
  @ColumnInfo(name: "billing_address")
  int? billingAddress;

  @JsonKey(name: "schemeId")
  @ColumnInfo(name: "scheme_id")
  int? schemeId;

  @JsonKey(name: "referenceNumber")
  @ColumnInfo(name: "reference_number")
  String? referenceNumber;

  @JsonKey(name: "addedDiscount")
  @ColumnInfo(name: "added_discount")
  double? addedDiscount;

  @JsonKey(name: "visitId")
  @ColumnInfo(name: "visit_id")
  int? visitId;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? created_by;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? created_on;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modified_by;

  @JsonKey(name: "modifiedOn")
  @ColumnInfo(name: "modified_on")
  String? modified_on;

  @ignore
  @JsonKey(name: "orderItem")
  List<OrderItemDataResponse>? orderItem;

  @ColumnInfo(name: "isSync")
  @JsonKey(ignore: true)
  int isSync;

  @ignore
  String? visitPartnerName;

  @ignore
  String? fullName;

  @ignore
  int? TotalOrder;
}
