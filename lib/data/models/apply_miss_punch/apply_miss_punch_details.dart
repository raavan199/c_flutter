import 'package:json_annotation/json_annotation.dart';

part 'apply_miss_punch_details.g.dart';

@JsonSerializable()
class ApplyMissedPunchDetails {
  int? id;
  int? missedPunchId;
  String? punchInTime;
  String? punchOutTime;
  int? status;

  ApplyMissedPunchDetails(
      {this.id,
        this.missedPunchId,
        this.punchInTime,
        this.punchOutTime,
        this.status});

  factory ApplyMissedPunchDetails.fromJson(Map<String, dynamic> json) =>
      _$ApplyMissedPunchDetailsFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['missedPunchId'] = this.missedPunchId;
    data['punchInTime'] = this.punchInTime;
    data['punchOutTime'] = this.punchOutTime;
    data['status'] = this.status;
    return data;
  }
}