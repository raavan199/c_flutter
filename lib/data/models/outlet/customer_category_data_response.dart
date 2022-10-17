import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_category_data_response.g.dart';

@JsonSerializable()
@Entity(tableName: "CustomerCategory")
class CustomerCategoryDataResponse {
  CustomerCategoryDataResponse(
      {this.subscriberId,
      this.categoryName,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.id});

  factory CustomerCategoryDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerCategoryDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerCategoryDataResponseToJson(this);

  @primaryKey
  @ColumnInfo(name: "id")
  @JsonKey(name: "id")
  int? id;

  @ColumnInfo(name: "subscriber_id")
  @JsonKey(name: "subscriberId")
  int? subscriberId;

  @ColumnInfo(name: "category_name")
  @JsonKey(name: "categoryName")
  String? categoryName;

  @ColumnInfo(name: "created_by")
  @JsonKey(name: "createdBy")
  int? createdBy;

  @ColumnInfo(name: "created_on")
  @JsonKey(name: "createdOn")
  String? createdOn;

  @ColumnInfo(name: "modified_by")
  @JsonKey(name: "modifiedBy")
  int? modifiedBy;

  @ColumnInfo(name: "modified_on")
  @JsonKey(name: "modifiedOn")
  String? modifiedOn;

}
