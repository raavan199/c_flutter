import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'invoice_item.dart';
import 'invoice_statement_item.dart';

part 'order_invoice_mapping.g.dart';

@JsonSerializable()
@Entity(tableName: 'OrderInvoiceMapping')
class OrderInvoiceMapping {
  OrderInvoiceMapping(
      {required this.id,
      required this.orderId,
      required this.date,
      required this.secondaryInvoiceSerialNumber,
      required this.distributorId,
      required this.fyId,
      required this.jcId,
      required this.customerId,
      required this.deliveryStatus,
      required this.subscriberId,
      this.secondaryInvoiceItems,
      this.vehicleId,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.invoiceStatementItems,
      this.isPaid,
      this.totalAmountOfInvoice,
      this.totalPaidAmountOfInvoice,
      });

  @primaryKey
  @JsonKey(name: "id")
  @ColumnInfo(name: "id")
  int id;

  int orderId;
  String date;
  String secondaryInvoiceSerialNumber;
  int distributorId;
  int fyId;
  int jcId;
  int customerId;
  int? vehicleId;
  int deliveryStatus;
  int subscriberId;
  @ignore
  List<InvoiceItem>? secondaryInvoiceItems;
  @ignore
  List<InvoiceStatementItem>? invoiceStatementItems;
  @ignore
  bool? isPaid;
  @ignore
  double? totalAmountOfInvoice;
  @ignore
  double? totalPaidAmountOfInvoice;

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

  factory OrderInvoiceMapping.fromJson(Map<String, dynamic> json) =>
      _$OrderInvoiceMappingFromJson(json);

  Map<String, dynamic> toJson() => _$OrderInvoiceMappingToJson(this);
}
