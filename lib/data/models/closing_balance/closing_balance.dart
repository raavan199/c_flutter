import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'closing_balance.g.dart';

///this is country data response class which used for parse country api list

@JsonSerializable()
@Entity(tableName: "ClosingBalance")
class ClosingBalance {
  ClosingBalance({
    this.id,
    this.customerId,
    this.fyId,
    this.obAmount,
    this.cbAmount,
    this.created_by,
    this.created_on,
    this.modified_by,
    this.modified_on,
  });

  factory ClosingBalance.fromJson(Map<String, dynamic> json) =>
      _$ClosingBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$ClosingBalanceToJson(this);

  @primaryKey
  @ColumnInfo(name: "id")
  @JsonKey(name: "id")
  int? id;

  @ColumnInfo(name: "customerId")
  @JsonKey(name: "customerId")
  int? customerId;

  @ColumnInfo(name: "fyId")
  @JsonKey(name: "fyId")
  int? fyId;

  @ColumnInfo(name: "obAmount")
  @JsonKey(name: "obAmount")
  double? obAmount;

  @ColumnInfo(name: "cbAmount")
  @JsonKey(name: "cbAmount")
  double? cbAmount;

  @ColumnInfo(name: "created_by")
  @JsonKey(name: "createdBy")
  int? created_by;

  @ColumnInfo(name: "created_on")
  @JsonKey(name: "createdOn")
  String? created_on;

  @ColumnInfo(name: "modified_by")
  @JsonKey(name: "modifiedBy")
  int? modified_by;

  @ColumnInfo(name: "modified_on")
  @JsonKey(name: "modifiedOn")
  String? modified_on;
}
