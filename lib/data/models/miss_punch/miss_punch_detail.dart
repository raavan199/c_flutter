import 'package:json_annotation/json_annotation.dart';

part 'miss_punch_detail.g.dart';

@JsonSerializable()
class MissedPunchDetails {
  int? missedPunchId;
  String? punchInTime;
  String? punchOutTime;
  int? punchInMediaFileId;
  int? punchOutMediaFileId;
  int? status;
  int? createdBy;
  String? createdOn;
  int? modifiedBy;
  String? modifiedOn;
  int? id;

  MissedPunchDetails(
      {this.missedPunchId,
        this.punchInTime,
        this.punchOutTime,
        this.punchInMediaFileId,
        this.punchOutMediaFileId,
        this.status,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.id});

  factory MissedPunchDetails.fromJson(Map<String, dynamic> json) =>
      _$MissedPunchDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MissedPunchDetailsToJson(this);

}