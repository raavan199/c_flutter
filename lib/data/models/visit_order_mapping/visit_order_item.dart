import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit_order_item.g.dart';

@JsonSerializable()
@Entity(tableName: "VisitOrderMapping")
class VisitOrderItem {
  VisitOrderItem({
    required this.orderId,
    required this.visitId,
    required this.isActive,
    required this.createdBy,
    required this.createdOn,
    required this.modifiedBy,
    required this.modifiedOn,
    required this.id,
    this.paymentCollectionId,
    this.salesReturnRegisterId,
  });

  factory VisitOrderItem.fromJson(Map<String, dynamic> json) =>
      _$VisitOrderItemFromJson(json);

  Map<String, dynamic> toJson() => _$VisitOrderItemToJson(this);

  @JsonKey(name: "orderId")
  @ColumnInfo(name: "order_id")
  int? orderId;

  @JsonKey(name: "visitId")
  @ColumnInfo(name: "visit_id")
  int? visitId;

  @JsonKey(name: "isActive")
  @ColumnInfo(name: "isActive")
  bool? isActive;

  int? paymentCollectionId;
  int? salesReturnRegisterId;

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

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;
}
