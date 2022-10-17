import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_data_items_response.g.dart';

///Created on 1/05/2022

@JsonSerializable()
@Entity(tableName: 'Location')
class LocationDataItems {
  LocationDataItems({
    this.id,
    this.code,
    this.name,
    this.countryId,
    this.stateId,
    this.districtId,
    this.created_by,
    this.created_on,
    this.modified_by,
    this.modified_on,
  });

  factory LocationDataItems.fromJson(Map<String, dynamic> json) =>
      _$LocationDataItemsFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDataItemsToJson(this);

  @primaryKey
  @ColumnInfo(name: "id")
  @JsonKey(name: "id")
  int? id;

  @ColumnInfo(name: "code")
  @JsonKey(name: "code")
  String? code;

  @ColumnInfo(name: "name")
  @JsonKey(name: "name")
  String? name;

  @ColumnInfo(name: "country_id")
  @JsonKey(name: "countryId")
  int? countryId;

  @ColumnInfo(name: "state_id")
  @JsonKey(name: "stateId")
  int? stateId;

  @ColumnInfo(name: "district_id")
  @JsonKey(name: "districtId")
  int? districtId;

  @ColumnInfo(name: "created_by")
  @JsonKey(name: "createdBy")
  int? created_by;

  @ColumnInfo(name: "created_on")
  @JsonKey(name: "createdOn")
  String? created_on;

  @ColumnInfo(name: "modified_by")
  @JsonKey(name: "modifiedBy")
  int? modified_by;

  @ColumnInfo(name: "modified_on")
  @JsonKey(name: "modifiedOn")
  String? modified_on;

}
