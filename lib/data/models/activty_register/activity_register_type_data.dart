import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity_register_type_data.g.dart';

@JsonSerializable()
@Entity(tableName: "ActivityRegisterType")
class ActivityRegisterTypeData {
  String? name;
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

  ActivityRegisterTypeData(
      {this.name,
        this.status,
        this.created_by,
        this.created_on,
        this.modified_by,
        this.modified_on,
        this.id});


  factory ActivityRegisterTypeData.fromJson(Map<String, dynamic> json) =>
      _$ActivityRegisterTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRegisterTypeDataToJson(this);
}