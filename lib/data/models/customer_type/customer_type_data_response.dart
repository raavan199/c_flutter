import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_type_data_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type data response class which is used to get customer
/// type data response.

@JsonSerializable()
@Entity(tableName: "CustomerType")
class CustomerTypeDataResponse {
  CustomerTypeDataResponse(this.id,
      this.subscriberId,
      this.typeName,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,);

  factory CustomerTypeDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerTypeDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerTypeDataResponseToJson(this);

  @primaryKey
  @ColumnInfo(name: "id")
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "subscriberId")
  @ColumnInfo(name: "subscriber_id")
  int? subscriberId;

  @JsonKey(name: "typeName")
  @ColumnInfo(name: "type_name")
  String? typeName;

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

}
