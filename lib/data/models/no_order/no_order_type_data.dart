import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'no_order_type_data.g.dart';

@JsonSerializable()
@Entity(tableName: 'NoOrderType')
class NoOrderTypeData {
  @JsonKey(name: 'typeName')
  @ColumnInfo(name: 'type_name')
  String? typeName;

  @JsonKey(name: 'isActive')
  @ColumnInfo(name: 'is_active')
  bool? isActive;

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
  @JsonKey(name: "id")
  int? id;

  NoOrderTypeData(
      {this.typeName,
        this.isActive,
        this.created_by,
        this.created_on,
        this.modified_by,
        this.modified_on,
        this.id});

  factory NoOrderTypeData.fromJsonForRowQuery(
      Map<String, dynamic> json) =>
      NoOrderTypeData(
        typeName: json['type_name'] as String?,
      );

  factory NoOrderTypeData.fromJson(Map<String, dynamic> json) =>
      _$NoOrderTypeDataFromJson(json);

  Map<String, dynamic> toJson() => _$NoOrderTypeDataToJson(this);

}