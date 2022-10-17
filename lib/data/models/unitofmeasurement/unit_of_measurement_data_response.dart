import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unit_of_measurement_data_response.g.dart';

/// Created by Dev 1051 on 1/6/2021
/// Purpose : This is a unit of measurement data  response which will be used to parse the
/// response of unit of measurement data.
@JsonSerializable()
@Entity(tableName: "UnitOfMeasure")
class UOMDataResponse {
  UOMDataResponse({
    this.id,
    this.uoMName,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
  });

  factory UOMDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UOMDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UOMDataResponseToJson(this);

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "uoMName")
  @ColumnInfo(name: "uom_name")
  String? uoMName;

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
