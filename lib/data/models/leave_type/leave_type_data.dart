import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'leave_type_data.g.dart';

@JsonSerializable()
class LeaveTypeData {
  LeaveTypeData({this.name,
    this.totalDays,
    this.status,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.id});

  @primaryKey
  int? id;

  String? name;

  int? totalDays;

  int? status;

  int? createdBy;

  String? createdOn;

  int? modifiedBy;

  String? modifiedOn;


  factory LeaveTypeData.fromJson(Map<String, dynamic> json) =>
      _$LeaveTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveTypeDataToJson(this);

}