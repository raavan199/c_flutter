import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_list_data_items_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type data response class which is used to get customer
/// type data response.

@JsonSerializable()
@Entity(tableName: "productList")
class ProductListDataItemsResponse {
  ProductListDataItemsResponse({
    this.id,
    this.name,
    this.productCode,
    this.groupId,
    this.subGroupId,
    this.categoryId,
    this.subCategoryId,
    this.uom,
    this.uoM1,
    this.uoM2,
    this.uoM3,
    this.uoM4,
    this.subscriberId,
    this.uoM2Value,
    this.uoM3Value,
    this.isSellableUoM1,
    this.isSellableUoM2,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.uom1Name,
    this.uom2Name,

  });

  factory ProductListDataItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductListDataItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListDataItemsResponseToJson(this);

  @primaryKey
  @JsonKey(name: "id")
  @ColumnInfo(name: "id")
  int? id;

  @ColumnInfo(name: "name")
  @JsonKey(name: "name")
  String? name;

  @ColumnInfo(name: "product_code")
  @JsonKey(name: "productCode")
  String? productCode;

  @ColumnInfo(name: "group_id")
  @JsonKey(name: "groupId")
  int? groupId;

  @ColumnInfo(name: "sub_group_id")
  @JsonKey(name: "subGroupId")
  int? subGroupId;

  @ColumnInfo(name: "category_id")
  @JsonKey(name: "categoryId")
  int? categoryId;

  @ColumnInfo(name: "sub_category_id")
  @JsonKey(name: "subCategoryId")
  int? subCategoryId;

  @ColumnInfo(name: "uom")
  @JsonKey(name: "uom")
  int? uom;

  @ColumnInfo(name: "uom_1")
  @JsonKey(name: "uoM1")
  int? uoM1;

  @ColumnInfo(name: "uom_2")
  @JsonKey(name: "uoM2")
  int? uoM2;

  @ColumnInfo(name: "uom_3")
  @JsonKey(name: "uoM3")
  int? uoM3;

  @ColumnInfo(name: "uom_4")
  @JsonKey(name: "uoM4")
  int? uoM4;

  @ColumnInfo(name: "subscriber_id")
  @JsonKey(name: "subscriberId")
  int? subscriberId;

  @ColumnInfo(name: "uom_2_value")
  int? uoM2Value;

  @ColumnInfo(name: "uom_3_value")
  int? uoM3Value;

  @ColumnInfo(name: "is_sellable_uom1")
  bool? isSellableUoM1;

  @ColumnInfo(name: "is_sellable_uom2")
  bool? isSellableUoM2;

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

  @ignore
  String? uom1Name;

  @ignore
  String? uom2Name;


  factory ProductListDataItemsResponse.fromJsonForRowQuery(Map<String, dynamic> json) =>
      ProductListDataItemsResponse(
        id: json['id'] as int?,
        name: json['name'] as String?,
        productCode: json['product_code'] as String?,
        groupId: json['group_id'] as int?,
        subGroupId: json['sub_group_id'] as int?,
        categoryId: json['category_id'] as int?,
        subCategoryId: json['sub_category_id'] as int?,
        uom: json['uom'] as int?,
        uoM1: json['uom_1'] as int?,
        uoM2: json['uom_2'] as int?,
        uoM3: json['uom_3'] as int?,
        uoM4: json['uom_4'] as int?,
        subscriberId: json['subscriber_id'] as int?,
        uoM2Value: json['uom_2_value'] as int?,
        uoM3Value: json['uom_3_value'] as int?,
        isSellableUoM1: (json['is_sellable_uom1'] as int?)==1,
        isSellableUoM2: (json['is_sellable_uom2'] as int?)==1,
        createdBy: json['created_by'] as int?,
        createdOn: json['created_on'] as String?,
        modifiedBy: json['modified_by'] as int?,
        modifiedOn: json['modified_on'] as String?,
        uom1Name: json['uom1Name'] as String?,
        uom2Name: json['uom2Name'] as String?,
      );
}