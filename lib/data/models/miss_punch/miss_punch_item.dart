import 'package:cygneto/exports/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'miss_punch_item.g.dart';

@JsonSerializable()
class MissPunchItem {
  int? attendanceId;
  int? missedPunchStatus;
  int? status;
  String? applyReason;
  String? reApplyReason;
  String? approverRemark;
  List<MissedPunchDetails>? missedPunchDetails;
  int? createdBy;
  String? createdOn;
  int? modifiedBy;
  String? modifiedOn;
  String? hours;
  int? id;

  MissPunchItem(
      {this.attendanceId,
        this.missedPunchStatus,
        this.status,
        this.applyReason,
        this.reApplyReason,
        this.approverRemark,
        this.missedPunchDetails,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.hours,
        this.id});

  factory MissPunchItem.fromJson(Map<String, dynamic> json) =>
      _$MissPunchItemFromJson(json);

  Map<String, dynamic> toJson() => _$MissPunchItemToJson(this);

}
