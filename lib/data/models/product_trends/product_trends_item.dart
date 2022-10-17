import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'product_trends_location_item.dart';

part 'product_trends_item.g.dart';

@JsonSerializable()
@Entity(tableName: "ProductTrends")
class ProductTrendsItem {
  ProductTrendsItem(
      {this.id,
      this.productId,
      this.isFocus,
      this.isNew,
      this.isMustSell,
      this.isOutletTrend,
      this.startDate,
      this.endDate,
      this.isActive,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.productTrendLocations});

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "productId")
  @ColumnInfo(name: "productId")
  int? productId;

  @JsonKey(name: "isFocus")
  @ColumnInfo(name: "isFocus")
  bool? isFocus;

  @JsonKey(name: "isNew")
  @ColumnInfo(name: "isNew")
  bool? isNew;

  @JsonKey(name: "isMustSell")
  @ColumnInfo(name: "isMustSell")
  bool? isMustSell;

  @JsonKey(name: "isOutletTrend")
  @ColumnInfo(name: "isOutletTrend")
  bool? isOutletTrend;

  @JsonKey(name: "startDate")
  @ColumnInfo(name: "startDate")
  String? startDate;

  @JsonKey(name: "endDate")
  @ColumnInfo(name: "endDate")
  String? endDate;

  @JsonKey(name: "isActive")
  @ColumnInfo(name: "isActive")
  bool? isActive;

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

  @JsonKey(name: "productTrendLocations")
  @ignore
  List<ProductTrendsLocationItem>? productTrendLocations;

  factory ProductTrendsItem.fromJson(Map<String, dynamic> json) =>
      _$ProductTrendsItemFromJson(json);

  factory ProductTrendsItem.fromJsonForRowQuery(Map<String, dynamic> json) =>
      ProductTrendsItem(
          id: json['id'] as int?,
          productId: json['productId'] as int?,
          isFocus: (json['isFocus'] as int?) == 1,
          isNew: (json['isNew'] as int?) == 1,
          isMustSell: (json['isMustSell'] as int?) == 1,
          isOutletTrend: (json['isOutletTrend'] as int?) == 1,
          startDate: json['startDate'] as String?,
          endDate: json['endDate'] as String?,
          isActive: (json['isActive'] as int?) == 1,
          createdBy: json['createdBy'] as int?,
          createdOn: json['createdOn'] as String?,
          modifiedBy: json['modifiedBy'] as int?,
          modifiedOn: json['modifiedOn'] as String?);

  Map<String, dynamic> toJson() => _$ProductTrendsItemToJson(this);
}
