import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_category_list_data_items_response.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a product category list items data response class which is used
/// to get product category list data items response.

@JsonSerializable()
@Entity(tableName: "ProductCategory")
class ProductCategoryListDataItemsResponse {
  ProductCategoryListDataItemsResponse({
    this.name,
    this.categoryId,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.id,
    this.isSelected = false
  });

  factory ProductCategoryListDataItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryListDataItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryListDataItemsResponseToJson(this);

  @ColumnInfo(name: "name")
  String? name;

  @ColumnInfo(name: "category_id")
  int? categoryId;

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

  @ColumnInfo(name: "id")
  @primaryKey
  @JsonKey(name: "id")
  int? id;

  @JsonKey(ignore: true)
  @ignore
  bool isSelected;

}
