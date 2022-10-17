import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../order_record/order_record_data_response.dart';

part 'order_item_data_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a visit partners data response class which is used in
/// visit partners data api call.

@JsonSerializable()
@Entity(tableName: "OrderItem")
class OrderItemDataResponse {
  OrderItemDataResponse({
    this.orderId,
    this.storageId,
    this.grnId,
    this.rId,
    this.productId,
    this.hsnCode,
    this.cgst,
    this.sgst,
    this.igst,
    this.vat,
    this.uoM,
    this.pickAndPackStatus = 0,
    this.availableQuantity = 1,
    this.basePrice,
    this.discount,
    this.orderQuantity,
    this.schemeId,
    this.created_by,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.id,
    this.isSync = 1
  });

  factory OrderItemDataResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDataResponseToJson(this);

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "orderId")
  @ColumnInfo(name: "order_id")
  int? orderId;

  @JsonKey(name: "storageId")
  @ColumnInfo(name: "storage_id")
  int? storageId;

  @JsonKey(name: "grnId")
  @ColumnInfo(name: "grn_id")
  int? grnId;

  @JsonKey(name: "rId")
  @ColumnInfo(name: "r_id")
  int? rId;

  @JsonKey(name: "productId")
  @ColumnInfo(name: "product_id")
  int? productId;

  @JsonKey(name: "hsnCode")
  @ColumnInfo(name: "hsn_code")
  String? hsnCode;

  @JsonKey(name: "cgst")
  @ColumnInfo(name: "cgst")
  double? cgst;

  @JsonKey(name: "sgst")
  @ColumnInfo(name: "sgst")
  double? sgst;

  @JsonKey(name: "igst")
  @ColumnInfo(name: "igst")
  double? igst;

  @JsonKey(name: "vat")
  @ColumnInfo(name: "vat")
  double? vat;

  @JsonKey(name: "uoM")
  @ColumnInfo(name: "uoM")
  int? uoM;

  @JsonKey(name: "pickAndPackStatus")
  @ColumnInfo(name: "pick_and_pack_status")
  int? pickAndPackStatus;

  @JsonKey(name: "availableQuantity")
  @ColumnInfo(name: "available_quantity")
  double? availableQuantity;

  @JsonKey(name: "basePrice")
  @ColumnInfo(name: "base_price")
  double? basePrice;

  @JsonKey(name: "discount")
  @ColumnInfo(name: "discount")
  double? discount;

  @JsonKey(name: "orderQuantity")
  @ColumnInfo(name: "order_quantity")
  double? orderQuantity;

  @JsonKey(name: "schemeId")
  @ColumnInfo(name: "scheme_id")
  int? schemeId;

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
  @ColumnInfo(name:"modified_on")
  String? modified_on;

  @ColumnInfo(name: "isSync")
  @JsonKey(ignore: true)
  int isSync;

}
