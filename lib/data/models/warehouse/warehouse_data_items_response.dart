import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'warehouse_data_items_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a warehouse data items response class which is used to get
/// warehouse data items response.

@JsonSerializable()
@Entity(tableName: "Warehouse")
class WarehouseDataItemsResponse {
  WarehouseDataItemsResponse({
    required this.id,
    this.name,
    this.locationId,
    this.distributorId,
    this.subscriberId,
    this.lastDamageUpdatedOn,
    this.lastExpiryUpdatedOn,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
  });

  factory WarehouseDataItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseDataItemsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseDataItemsResponseToJson(this);

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int id;

  @JsonKey(name: "name")
  @ColumnInfo(name: "name")
  String? name;

  @JsonKey(name: "locationId")
  @ColumnInfo(name: "location_id")
  int? locationId;

  @JsonKey(name: "distributorId")
  @ColumnInfo(name: "distributor_id")
  int? distributorId;

  @JsonKey(name: "subscriberId")
  @ColumnInfo(name: "subscriber_id")
  int? subscriberId;

  @JsonKey(name: "lastDamageUpdatedOn")
  @ColumnInfo(name: "last_damage_updated_on")
  String? lastDamageUpdatedOn;

  @JsonKey(name: "lastExpiryUpdatedOn")
  @ColumnInfo(name: "last_expiry_updated_on")
  String? lastExpiryUpdatedOn;

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
