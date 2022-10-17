import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'customer_data_items_response.dart';

part 'customer_address_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a customer data items customer address response class
/// which is used to get customer data items customer address response.

@JsonSerializable()
@Entity(tableName: "CustomerAddress",foreignKeys: [
  ForeignKey(
      childColumns: ["customerId"],
      parentColumns: ["id"],
      entity: CustomerDataItemsResponse,
      onDelete: ForeignKeyAction.cascade)
])
class CustomerAddressResponse {
  CustomerAddressResponse({
    this.id,
    this.customerId,
    this.pincode,
    this.contactPersonName,
    this.countryId,
    this.countryName,
    this.stateId,
    this.stateName,
    this.districtId,
    this.districtName,
    this.locationId,
    this.locationName,
    this.fullAddress,
    this.isDefaultAddress,
    this.latitude,
    this.isActive,
    this.longitude,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
  });
  factory CustomerAddressResponse.fromJsonForRowQuery(
      Map<String, dynamic> json) =>
      CustomerAddressResponse(
        id: json['id'] as int?,
        customerId: json['customerId'] as int?,
        pincode: json['pincode'] as String?,
        contactPersonName: json['contactPersonName'] as String?,
        countryId: json['countryId'] as int?,
        stateId: json['stateId'] as int?,
        districtId: json['districtId'] as int?,
        locationId: json['locationId'] as int?,
        fullAddress: json['fullAddress'] as String?,
        isDefaultAddress: (json['isDefaultAddress'] as int?)==1,
        latitude: json['latitude'] as String?,
        longitude: json['longitude'] as String?,
        isActive: (json['isActive'] as int?)==1,
        createdBy: json['created_by'] as int?,
        createdOn: json['created_on'] as String?,
        modifiedBy: json['modified_by'] as int?,
        modifiedOn: json['modified_on'] as String?,
        stateName: json['stateName'] as String?,
        locationName: json['locationName'] as String?,
        countryName: json['countryName'] as String?,
        districtName: json['districtName'] as String?,
      );
  factory CustomerAddressResponse.fromJson(
      Map<String, dynamic> json) =>
      _$CustomerAddressResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$CustomerAddressResponseToJson(this);

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "customerId")
  @ColumnInfo(name: "customerId")
  int? customerId;

  @JsonKey(name: "pincode")
  @ColumnInfo(name: "pincode")
  String? pincode;

  @JsonKey(name: "contactPersonName")
  @ColumnInfo(name: "contactPersonName")
  String? contactPersonName;

  @JsonKey(name: "countryId")
  @ColumnInfo(name: "countryId")
  int? countryId;

  @ignore
  String? countryName;

  @JsonKey(name: "stateId")
  @ColumnInfo(name: "stateId")
  int? stateId;

  @ignore
  String? stateName;

  @JsonKey(name: "districtId")
  @ColumnInfo(name: "districtId")
  int? districtId;

  @ignore
  String? districtName;

  @JsonKey(name: "locationId")
  @ColumnInfo(name: "locationId")
  int? locationId;

  @ignore
  String? locationName;

  @JsonKey(name: "fullAddress")
  @ColumnInfo(name: "fullAddress")
  String? fullAddress;

  @JsonKey(name: "isDefaultAddress")
  @ColumnInfo(name: "isDefaultAddress")
  bool? isDefaultAddress;

  @JsonKey(name: "latitude")
  @ColumnInfo(name: "latitude")
  String? latitude;

  @JsonKey(name: "longitude")
  @ColumnInfo(name: "longitude")
  String? longitude;

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
  @ColumnInfo(name: "modified_On")
  String? modifiedOn;

}
