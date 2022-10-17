import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invoice_item.g.dart';

@JsonSerializable()
@Entity(tableName: "InvoiceItem")
class InvoiceItem {
  InvoiceItem({
    this.id,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.secondaryInvoiceId,
    this.productId,
    this.hsnCode,
    this.cgst,
    this.sgst,
    this.igst,
    this.billQuantity,
    this.schemeId,
    this.weight,
    this.basePrice,
    this.discount,
    this.deliveryStatus,
    this.batchNumber,
    this.expiryDate,
    this.uoM,
    this.grnId,
    this.receivedId,
    this.orderItemId,
    this.pickAndPackRegisterId,
    this.partnerId,
    this.name,
    this.uom_name,
    this.scheme_name,
    this.minTotalValue,
    this.maxTotalValue,
    this.minOrderQnty,
    this.maxOrderQnty,
    this.freeProductId,
    this.additionalDiscountPercent,
  });

  int? secondaryInvoiceId;
  int? productId;
  String? hsnCode;
  double? cgst;
  double? sgst;
  double? igst;
  int? billQuantity;
  int? schemeId;
  double? weight;
  double? basePrice;
  double? discount;
  int? deliveryStatus;
  String? batchNumber;
  String? expiryDate;
  int? uoM;
  int? grnId;
  int? receivedId;
  int? orderItemId;
  int? pickAndPackRegisterId;

  @ignore
  String? name;

  @ignore
  String? uom_name;

  @ignore
  String? scheme_name;

  @ignore
  double? minTotalValue;

  @ignore
  double? maxTotalValue;

  @ignore
  double? minOrderQnty;

  @ignore
  double? maxOrderQnty;

  @ignore
  int? freeProductId;

  @ignore
  double? additionalDiscountPercent;

  @primaryKey
  @JsonKey(name: "id")
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? createdBy;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? createdOn;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modifiedBy;

  @JsonKey(name: "modifiedOn")
  @ColumnInfo(name: "modified_on")
  String? modifiedOn;

  int? partnerId;

  factory InvoiceItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceItemFromJson(json);

  factory InvoiceItem.fromJsonForRowQuery(Map<String, dynamic> json) =>
      InvoiceItem(
        igst: (json['igst'] as num?)?.toDouble(),
        billQuantity: json['billQuantity'] as int?,
        basePrice: (json['basePrice'] as num?)?.toDouble(),
        discount: (json['discount'] as num?)?.toDouble(),
        createdOn: json['created_on'] as String?,
        partnerId: json['partner_id'] as int?,
      );

  Map<String, dynamic> toJson() => _$InvoiceItemToJson(this);
}
