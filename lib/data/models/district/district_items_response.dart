import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'district_items_response.g.dart';

///Created on 1/05/2022

@JsonSerializable()
@Entity(tableName: "district")
class DistrictItems {
  DistrictItems(
      {required this.name,
      required this.stateId,
      required this.createdBy,
      required this.createdOn,
      required this.modifiedBy,
      required this.modifiedOn,
      required this.id});

  @primaryKey
  @ColumnInfo(name: "id")
  @JsonKey(name: "id")
  int? id;

  @ColumnInfo(name: "name")
  @JsonKey(name: "name")
  String? name;

  @ColumnInfo(name: "state_id")
  @JsonKey(name: "stateId")
  int? stateId;

  @ColumnInfo(name: "created_by")
  @JsonKey(name: "createdBy")
  int? createdBy;

  @ColumnInfo(name: "created_on")
  @JsonKey(name: "createdOn")
  String? createdOn;

  @ColumnInfo(name: "modified_by")
  @JsonKey(name: "modifiedBy")
  int? modifiedBy;

  @ColumnInfo(name: "modified_on")
  @JsonKey(name: "modifiedOn")
  String? modifiedOn;

  factory DistrictItems.fromJson(Map<String, dynamic> json) =>
      _$DistrictItemsFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictItemsToJson(this);
}
