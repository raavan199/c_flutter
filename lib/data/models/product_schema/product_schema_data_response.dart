
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_schema_data_response.g.dart';

/// Created by Dev 1051 on 1/7/2022

@JsonSerializable()
@Entity(tableName: "ProductScheme")
class ProductSchemaData{

  ProductSchemaData({
    this.product_id, this.scheme_id, this.is_active, this.created_by,
    this.created_on, this.modified_by, this.modified_on, this.id});
  @JsonKey(name: "productId")
  @ColumnInfo(name: "product_id")
  int? product_id;

  @JsonKey(name: "schemeId")
  @ColumnInfo(name: "scheme_id")
  int? scheme_id;

  @JsonKey(name: "isActive")
  @ColumnInfo(name: "is_active")
  bool? is_active;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? created_by;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? created_on;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modified_by;

  @ColumnInfo(name: "modified_on")
  @JsonKey(name: "modifiedOn")
  String? modified_on;

  @primaryKey
  @ColumnInfo(name: "id")
  @JsonKey(name: "id")
  int? id;

  factory ProductSchemaData.fromJson(Map<String,dynamic> json)=>
      _$ProductSchemaDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductSchemaDataToJson(this);

}