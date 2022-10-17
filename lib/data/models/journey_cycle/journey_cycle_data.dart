import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'journey_cycle_data.g.dart';

@JsonSerializable()
@Entity(tableName: "JourneyCycle")
class JourneyCycleData {
  JourneyCycleData(
      this.financialYearId,
      this.name,
      this.startDate,
      this.endDate,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.id
      );

  factory JourneyCycleData.fromJson(Map<String, dynamic> json) =>
      _$JourneyCycleDataFromJson(json);

  Map<String, dynamic> toJson() => _$JourneyCycleDataToJson(this);

  @ColumnInfo(name: "financialYearId")
  int? financialYearId;

  @ColumnInfo(name: "name")
  String? name;

  @ColumnInfo(name: "startDate")
  String? startDate;

  @ColumnInfo(name: "endDate")
  String? endDate;

  @ColumnInfo(name: "created_by")
  int? createdBy;

  @ColumnInfo(name: "created_on")
  String? createdOn;

  @ColumnInfo(name: "modified_by")
  int? modifiedBy;

  @ColumnInfo(name: "modified_on")
  String? modifiedOn;

  @primaryKey
  @ColumnInfo(name: "id")
  int? id;
}
