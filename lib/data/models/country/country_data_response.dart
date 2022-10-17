import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'country_data_response.g.dart';

///this is country data response class which used for parse country api list

@JsonSerializable()
@Entity(tableName: "Country")
class CountryData {
  CountryData({
    this.id,
    this.code,
    this.name,
    this.timeZone,
    this.currency,
    this.isDefault,
    this.isActive,
    this.created_by,
    this.created_on,
    this.modified_by,
    this.modified_on,
  });

  factory CountryData.fromJson(Map<String, dynamic> json) =>
      _$CountryDataFromJson(json);

  Map<String, dynamic> toJson() => _$CountryDataToJson(this);

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

  @ColumnInfo(name: "timezone")
  @JsonKey(name: "timeZone")
  String? timeZone;

  @ColumnInfo(name: "isDefault")
  bool? isDefault;

  @ColumnInfo(name: "isActive")
  bool? isActive;

  @ColumnInfo(name: "currency")
  @JsonKey(name: "currency")
  String? currency;

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
