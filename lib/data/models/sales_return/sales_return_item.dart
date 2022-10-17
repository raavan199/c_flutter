import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../constants/app_constants.dart';

part 'sales_return_item.g.dart';

@JsonSerializable()
@Entity(tableName: "SalesReturn")
class SalesReturnItem {
  SalesReturnItem(
      {this.created_by,
      this.created_on,
      this.modified_by,
      this.modified_on,
      this.id,
      this.returnDate,
      this.warehouseId,
      this.customerId,
      this.productId,
      this.secondaryInvoiceId,
      this.rate,
      this.storageId,
      this.sellableQuantity,
      this.damagedQuantity,
      this.uoM,
      this.reasonId,
      this.fyId,
      this.jcId,
      this.remark,
      this.grnId,
      this.rId,
      this.subscriberId,
      this.distributorId,
      this.batchNumber,
      this.cgst,
      this.sgst,
      this.igst,
      this.isApprove,
      this.isCancel,
      this.isSync,
      this.productName,
      this.uomName,
      this.visitId});

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

  @primaryKey
  @JsonKey(name: "id")
  int? id;

  String? returnDate;
  int? warehouseId;
  int? customerId;
  int? productId;
  int? secondaryInvoiceId;
  double? rate;
  int? storageId;
  double? sellableQuantity;
  double? damagedQuantity;
  int? uoM;
  int? reasonId;
  int? fyId;
  int? jcId;
  String? remark;
  int? grnId;
  int? rId;
  int? subscriberId;
  int? distributorId;
  String? batchNumber;
  double? cgst;
  double? sgst;
  double? igst;
  bool? isApprove;
  bool? isCancel;
  @ignore
  String? productName;
  @ignore
  String? uomName;
  int? isSync = SyncStatus.sync;
  int? visitId;

  factory SalesReturnItem.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnItemFromJson(json);

  Map<String, dynamic> toJson() => _$SalesReturnItemToJson(this);

  factory SalesReturnItem.fromJsonForRowQuery(Map<String, dynamic> json) =>
      SalesReturnItem(
        created_by: json['createdBy'] as int?,
        created_on: json['createdOn'] as String?,
        modified_by: json['modifiedBy'] as int?,
        modified_on: json['modifiedOn'] as String?,
        id: json['id'] as int?,
        returnDate: json['returnDate'] as String?,
        warehouseId: json['warehouseId'] as int?,
        customerId: json['customerId'] as int?,
        productId: json['productId'] as int?,
        secondaryInvoiceId: json['secondaryInvoiceId'] as int?,
        rate: (json['rate'] as num?)?.toDouble(),
        storageId: json['storageId'] as int?,
        sellableQuantity: (json['sellableQuantity'] as num?)?.toDouble(),
        damagedQuantity: (json['damagedQuantity'] as num?)?.toDouble(),
        uoM: json['uoM'] as int?,
        reasonId: json['reasonId'] as int?,
        fyId: json['fyId'] as int?,
        jcId: json['jcId'] as int?,
        remark: json['remark'] as String?,
        grnId: json['grnId'] as int?,
        rId: json['rId'] as int?,
        subscriberId: json['subscriberId'] as int?,
        distributorId: json['distributorId'] as int?,
        batchNumber: json['batchNumber'] as String?,
        cgst: (json['cgst'] as num?)?.toDouble(),
        sgst: (json['sgst'] as num?)?.toDouble(),
        igst: (json['igst'] as num?)?.toDouble(),
        isApprove: (json['isApprove'] as int?) == 1,
        isCancel: (json['isCancel'] as int?) == 1,
        isSync: json['isSync'] as int?,
        productName: json['productName'] as String?,
        uomName: json['uomName'] as String?,
        visitId: json['visitId'] as int?,
      );
}
