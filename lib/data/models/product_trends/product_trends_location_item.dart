import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_trends_location_item.g.dart';

@JsonSerializable()
@Entity(tableName: "ProductTrendsLocation")
class ProductTrendsLocationItem {
  ProductTrendsLocationItem(
      {this.id, this.productTrendId, this.locationId, this.isActive});

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "productTrendId")
  @ColumnInfo(name: "product_trend_id")
  int? productTrendId;

  @JsonKey(name: "locationId")
  @ColumnInfo(name: "location_id")
  int? locationId;

  @JsonKey(name: "isActive")
  @ColumnInfo(name: "isActive")
  bool? isActive;

  factory ProductTrendsLocationItem.fromJson(Map<String, dynamic> json) =>
      _$ProductTrendsLocationItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTrendsLocationItemToJson(this);
}
