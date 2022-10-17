import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'attendance_item.g.dart';

@JsonSerializable()
@Entity(tableName: 'Attendance')
class AttendanceItem {
  int? status;
  @ignore
  List<AttendanceDetails>? attendanceDetails;

  /// for apply attendance status is always pending = 1
  int? attendanceStatus = 1;
  String? approverRemark;

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
  int? id;

  @JsonKey(ignore: true)
  int? isSync;

  AttendanceItem(
      {this.status,
      this.attendanceDetails,
      this.attendanceStatus,
      this.created_by,
      this.created_on,
      this.modified_by,
      this.modified_on,
      this.id,
      this.approverRemark,
      this.isSync = 1});

  factory AttendanceItem.fromJson(Map<String, dynamic> json) =>
      _$AttendanceItemFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceItemToJson(this);
}
