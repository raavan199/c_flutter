import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'financial_year_data.g.dart';

@JsonSerializable()
@Entity(tableName: "FinancialYear")
class FinancialYearData {
  FinancialYearData(
      this.name,
      this.startDate,
      this.endDate,
      this.isCurrentYear,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.id);

  factory FinancialYearData.fromJson(Map<String, dynamic> json) =>
      _$FinancialYearDataFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialYearDataToJson(this);

  @ColumnInfo(name: "name")
  String? name;

  @ColumnInfo(name: "startDate")
  String? startDate;

  @ColumnInfo(name: "endDate")
  String? endDate;

  @ColumnInfo(name: "isCurrentYear")
  bool isCurrentYear;

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
