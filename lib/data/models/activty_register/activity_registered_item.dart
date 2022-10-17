import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../constants/app_constants.dart';

part 'activity_registered_item.g.dart';

@JsonSerializable()
@Entity(tableName: "ActivityRegistered")
class ActivityRegisteredItem {

  ActivityRegisteredItem(
      {this.date,
      this.details,
      this.startTime,
      this.endTime,
      this.activityTypeId,
      this.activityRegisterStatus,
      this.status,
      this.created_by,
      this.created_on,
      this.modified_by,
      this.modified_on,
      this.id,
      this.isSync = SyncStatus.sync,
      this.activityTypeName});

  factory ActivityRegisteredItem.fromJsonForRowQuery(
      Map<String, dynamic> json) =>
      ActivityRegisteredItem(
        id: json['id'] as int?,
        date: json['date'] as String?,
        created_by: json['createdBy'] as int?,
        created_on: json['createdOn'] as String?,
        modified_by: json['modifiedBy'] as int?,
        modified_on: json['modifiedOn'] as String?,
        activityTypeId: json['activityTypeId'] as int?,
        details: json['details'] as String?,
        startTime: json['startTime'] as String?,
        endTime: json['endTime'] as String?,
        activityRegisterStatus: json['activityRegisterStatus'] as int?,
        status: json['status'] as int?,
        isSync: json['isSync'] as int,
          activityTypeName: json['ActivityTypeName'] as String?,
      );
  factory ActivityRegisteredItem.fromJson(Map<String, dynamic> json) =>
      _$ActivityRegisteredItemFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRegisteredItemToJson(this);

  String? date;
  String? details;
  String? startTime;
  String? endTime;
  int? activityTypeId;
  int? activityRegisterStatus;
  int? status;
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
  int isSync;

  @JsonKey(ignore: true)
  @ignore
  String? activityTypeName;


}
