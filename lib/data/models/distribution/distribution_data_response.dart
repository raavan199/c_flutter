import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'distribution_data_response.g.dart';

/// Created by Dev 1051 on 1/6/2022

@JsonSerializable()
@Entity(tableName: "Distribution")
class DistributionData {
  DistributionData(
      {this.businessName,
      this.contactPersonName,
      this.mobileNumber,
      this.emailId,
      this.gstNumber,
      this.locationId,
      this.stateId,
      this.tenantId,
      this.type,
      this.fullAddress,
      this.pincode,
      this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.id});

  factory DistributionData.fromJson(Map<String, dynamic> json) =>
      _$DistributionDataFromJson(json);

  factory DistributionData.fromJsonForRowQuery(Map<String, dynamic> json) =>
      DistributionData(
        businessName: json['business_name'] as String?,
        contactPersonName: json['contact_person_name'] as String?,
        mobileNumber: json['mobile_number'] as String?,
        emailId: json['email_id'] as String?,
        gstNumber: json['gst_number'] as String?,
        locationId: json['location_id'] as int?,
        stateId: json['state_id'] as int?,
        tenantId: json['tenant_id'] as int?,
        type: json['type'] as int?,
        fullAddress: json['full_address'] as String?,
        pincode: json['pin_code'] as String?,
        createdBy: json['created_by'] as int?,
        createdOn: json['created_on'] as String?,
        modifiedBy: json['modified_by'] as int?,
        modifiedOn: json['modified_on'] as String?,
        id: json['id'] as int?,
      );

  Map<String, dynamic> toJson() => _$DistributionDataToJson(this);

  @JsonKey(name: "businessName")
  @ColumnInfo(name: "business_name")
  String? businessName;

  @JsonKey(name: "contactPersonName")
  @ColumnInfo(name: "contact_person_name")
  String? contactPersonName;

  @JsonKey(name: "mobileNumber")
  @ColumnInfo(name: "mobile_number")
  String? mobileNumber;

  @JsonKey(name: "emailId")
  @ColumnInfo(name: "email_id")
  String? emailId;

  @JsonKey(name: "gstNumber")
  @ColumnInfo(name: "gst_number")
  String? gstNumber;

  @JsonKey(name: "locationId")
  @ColumnInfo(name: "location_id")
  int? locationId;

  @JsonKey(name: "stateId")
  @ColumnInfo(name: "state_id")
  int? stateId;

  @JsonKey(name: "tenantId")
  @ColumnInfo(name: "tenant_id")
  int? tenantId;

  @JsonKey(name: "type")
  @ColumnInfo(name: "type")
  int? type;

  @JsonKey(name: "fullAddress")
  @ColumnInfo(name: "full_address")
  String? fullAddress;

  @JsonKey(name: "pincode")
  @ColumnInfo(name: "pin_code")
  String? pincode;

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

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;
}
