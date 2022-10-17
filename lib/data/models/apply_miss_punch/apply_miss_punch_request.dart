import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';
part 'apply_miss_punch_request.g.dart';

@JsonSerializable()
class ApplyMissPunchRequest {
  int? id;
  String? applyReason;
  String? reApplyReason;
  List<ApplyMissedPunchDetails>? missedPunchDetails;

  ApplyMissPunchRequest(
      {this.id, this.applyReason, this.reApplyReason, this.missedPunchDetails});

  factory ApplyMissPunchRequest.fromJson(Map<String, dynamic> json) =>
      _$ApplyMissPunchRequestFromJson(json);



  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['applyReason'] = this.applyReason;
    data['reApplyReason'] = this.reApplyReason;
    if (this.missedPunchDetails != null) {
      data['missedPunchDetails'] =
          this.missedPunchDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}