import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'attendance_detail.g.dart';

@JsonSerializable()
@Entity(tableName: "AttendanceDetail", foreignKeys: [
  ForeignKey(
      childColumns: ["attendanceId"],
      parentColumns: ["id"],
      entity: AttendanceItem,
      onDelete: ForeignKeyAction.cascade)
])
class AttendanceDetails {
  int? attendanceId;
  String? punchInTime;
  String? punchOutTime;
  int? punchInMediaFileId;
  int? punchOutMediaFileId;
  int? status;
  String? punchInImagePath;
  String? punchOutImagePath;

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

  AttendanceDetails(
      {this.attendanceId,
      this.punchInTime,
      this.punchOutTime,
      this.punchInMediaFileId,
      this.punchOutMediaFileId,
      this.status,
      this.punchInImagePath,
      this.punchOutImagePath,
      this.created_by,
      this.created_on,
      this.modified_by,
      this.modified_on,
      this.isSync = 1,
      this.id});

  factory AttendanceDetails.fromJsonForRowQuery(Map<String, dynamic> json) =>
      AttendanceDetails(
        attendanceId: json['attendanceId'] as int?,
        punchInTime: json['punchInTime'] as String?,
        punchOutTime: json['punchOutTime'] as String?,
        punchInMediaFileId: json['punchInMediaFileId'] as int?,
        punchOutMediaFileId: json['punchOutMediaFileId'] as int?,
        status: json['status'] as int?,
        punchInImagePath: json['punchInImagePath'] as String?,
        punchOutImagePath: json['punchOutImagePath'] as String?,
        created_by: json['created_by'] as int?,
        created_on: json['created_on'] as String?,
        modified_by: json['modified_by'] as int?,
        modified_on: json['modified_on'] as String?,
        id: json['id'] as int?,
      );

  factory AttendanceDetails.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDetailsToJson(this);
}
