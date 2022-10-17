import 'package:json_annotation/json_annotation.dart';

part 'leave_balance.g.dart';

@JsonSerializable()
class LeaveBalance {
  int? id;
  String? leaveTypeName;
  int? totalLeaves;
  double? availLeaves;

  LeaveBalance({this.id, this.leaveTypeName, this.totalLeaves, this.availLeaves});


  factory LeaveBalance.fromJson(Map<String,dynamic> json)=>
      _$LeaveBalanceFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveBalanceToJson(this);
}