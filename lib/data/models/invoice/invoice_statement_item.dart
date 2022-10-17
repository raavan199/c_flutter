import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../constants/app_constants.dart';

part 'invoice_statement_item.g.dart';

@JsonSerializable()
@Entity(tableName: "InvoiceStatement")
class InvoiceStatementItem {
  InvoiceStatementItem({
      required this.id,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      required this.customerId,
      required this.invoiceId,
      required this.paidBy,
      this.referenceNumber,
      this.amount,
      required this.distributorId,
      this.subscriberId,
      required this.fyId,
      required this.jcId,
      this.isSync,
  this.visitId});

  int customerId;
  int invoiceId;
  int paidBy;
  String? referenceNumber;
  double? amount;
  int distributorId;
  int? subscriberId;
  int fyId;
  int jcId;

  int? isSync = SyncStatus.sync;
  int? visitId;

  @primaryKey
  @JsonKey(name: "id")
  @ColumnInfo(name: "id")
  int id;

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

  factory InvoiceStatementItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceStatementItemFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceStatementItemToJson(this);
}
