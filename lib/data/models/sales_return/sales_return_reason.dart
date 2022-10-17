import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sales_return_reason.g.dart';

@JsonSerializable()
@Entity(tableName: "SalesReturnReason")
class SalesReturnReason {
  SalesReturnReason(this.created_by,
      this.created_on,
      this.modified_by,
      this.modified_on,
      this.subscriberId,
      this.distributorId,
      this.name,
      this.id);

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

  int? subscriberId;
  int? distributorId;
  String name;

  factory SalesReturnReason.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnReasonFromJson(json);

  Map<String, dynamic> toJson() => _$SalesReturnReasonToJson(this);

}