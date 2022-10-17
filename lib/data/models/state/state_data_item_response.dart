import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'state_data_item_response.g.dart';

/// Created by Dev 1051 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a parent reset pin response which will be used to parse the
/// response of reset pin.
@JsonSerializable()
@Entity(tableName: "StateData")
class StateDataItemResponse {
  StateDataItemResponse(
    this.id,
    this.code,
    this.name,
    this.countryId,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
  );

  factory StateDataItemResponse.fromJson(Map<String, dynamic> json) =>
      _$StateDataItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$StateDataItemResponseToJson(this);

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "code")
  @ColumnInfo(name: "code")
  String? code;

  @JsonKey(name: "name")
  @ColumnInfo(name: "name")
  String? name;

  @JsonKey(name: "countryId")
  @ColumnInfo(name: "country_id")
  int? countryId;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? createdBy;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? createdOn;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modifiedBy;

  @JsonKey(name: "modifiedOn")
  @ColumnInfo(name: "modified_on")
  String? modifiedOn;
}
