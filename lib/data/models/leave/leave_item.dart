import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_item.g.dart';

@JsonSerializable()
@Entity(tableName: 'Leave')
class LeaveItem {
  @primaryKey
  int? id;
  String? fromDate;
  String? toDate;
  bool? isHalfDay;
  bool? isFirstHalf;
  int? leaveTypeId;
  String? remarks;
  String? approverRemark;
  int? leaveStatus;

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

  LeaveItem(
      {this.id,
        this.fromDate,
        this.toDate,
        this.isHalfDay,
        this.isFirstHalf,
        this.leaveTypeId,
        this.remarks,
        this.approverRemark,
        this.leaveStatus,
        this.created_by,
        this.created_on,
        this.modified_by,
        this.modified_on});


  factory LeaveItem.fromJson(Map<String, dynamic> json) =>
      _$LeaveItemFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveItemToJson(this);
}
