import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_group_item.g.dart';

/// Created by Dev 1051 on 1/5/2022
/// modified by Dev 2183 on 1/7/2022

@JsonSerializable()
@Entity(tableName: "ProductGroup")
class ProductGroupItems{

  ProductGroupItems({required this.name,this.groupId, required this.createdBy,
    required this.createdOn, required this.modifiedBy, this.modifiedOn,
    this.id,this.isSelected=false});

  factory ProductGroupItems.fromJson(Map<String,dynamic> json)=>
      _$ProductGroupItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductGroupItemsToJson(this);


  @ColumnInfo(name: "name")
  @JsonKey(name: "name")
  String? name;

  @ColumnInfo(name: "group_id")
  @JsonKey(name: "groupId")
  int? groupId;

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