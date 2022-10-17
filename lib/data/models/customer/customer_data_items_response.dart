
import 'dart:convert';
import 'package:cygneto/constants/app_constants.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'customer_address_response.dart';

part 'customer_data_items_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type data response class which is used to get customer
/// type data response.

@JsonSerializable()
@Entity(tableName: "customer")
class CustomerDataItemsResponse {
  CustomerDataItemsResponse({
    this.id,
    this.isSync = SyncStatus.sync,
    this.contactPersonName,
    this.businessName,
    this.mobileNumber,
    this.emailAddress,
    this.pincode,
    this.gstin,
    this.routeId,
    this.routeName,
    this.customerType,
    this.customerTypeName,
    this.isActive,
    this.distributorId_1,
    this.distributorId_2,
    this.distributorId_3,
    this.customerCategory,
    this.customerCategoryName,
    this.createdBy,
    this.createdOn,
    this.isSystemGenerated,
    this.modifiedBy,
    this.modifiedOn,
    this.customerAddress,
    this.listOfDistributionId,
  });

  factory CustomerDataItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataItemsResponseFromJson(json);

  //Map<String, dynamic> toJson() => _$CustomerDataItemsResponseToJson(this);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contactPersonName'] = this.contactPersonName;
    data['businessName'] = this.businessName;
    data['mobileNumber'] = this.mobileNumber;
    data['emailAddress'] = this.emailAddress;
    data['gstin'] = this.gstin;
    data['routeId'] = this.routeId;
    data['routeName'] = this.routeName;
    data['customerType'] = this.customerType;
    data['customerTypeName'] = this.customerTypeName;
    data['isActive'] = this.isActive;
    data['distributorId_1'] = this.distributorId_1;
    data['distributorId_2'] = this.distributorId_2;
    data['distributorId_3'] = this.distributorId_3;
    data['customerCategory'] = this.customerCategory;
    data['customerCategoryName'] = this.customerCategoryName;
    data['createdBy'] = this.createdBy;
    data['createdOn'] = this.createdOn;
    data['isSystemGenerated'] = this.isSystemGenerated;
    data['modifiedBy'] = this.modifiedBy;
    data['modifiedOn'] = this.modifiedOn;
    if (this.customerAddress != null) {
      data['customerAddress'] =
          this.customerAddress?.map((v) => v.toJson()).toList();
    }
    print('Place add outlet API request Json: ${jsonEncode(data)}');
    return data;
}


@JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(ignore: true)
  @ColumnInfo(name: "isSync")
  int? isSync;

  @JsonKey(name: "contactPersonName")
  @ColumnInfo(name: "contact_person_name")
  String? contactPersonName;

  @JsonKey(name: "businessName")
  @ColumnInfo(name: "business_name")
  String? businessName;

  @JsonKey(name: "mobileNumber")
  @ColumnInfo(name: "mobile_number")
  String? mobileNumber;

  @JsonKey(name: "emailAddress")
  @ColumnInfo(name: "email_address")
  String? emailAddress;

  @JsonKey(name: "pincode")
  @ColumnInfo(name: "pin_code")
  int? pincode;

  @JsonKey(name: "gstin")
  @ColumnInfo(name: "gst_in")
  String? gstin;

  @JsonKey(name: "routeId")
  @ColumnInfo(name: "route_id")
  int? routeId;

  @JsonKey(name: "routeName")
  @ColumnInfo(name: "route_name")
  String? routeName;

  @JsonKey(name: "customerType")
  @ColumnInfo(name: "customer_type")
  int? customerType;

  @JsonKey(name: "customerTypeName")
  @ColumnInfo(name: "customer_type_name")
  String? customerTypeName;

  @JsonKey(name: "isActive")
  @ColumnInfo(name: "is_active")
  bool? isActive;

  @JsonKey(name: "distributorId_1")
  @ColumnInfo(name: "distributorId_1")
  int? distributorId_1;

  @JsonKey(name: "distributorId_2")
  @ColumnInfo(name: "distributorId_2")
  int? distributorId_2;

  @JsonKey(name: "distributorId_3")
  @ColumnInfo(name: "distributorId_3")
  int? distributorId_3;

  @JsonKey(name: "customerCategory")
  @ColumnInfo(name: "customer_category")
  int? customerCategory;

  @JsonKey(name: "customerCategoryName")
  @ColumnInfo(name: "customer_category_name")
  String? customerCategoryName;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? createdBy;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? createdOn;

  @JsonKey(name: "isSystemGenerated")
  @ColumnInfo(name: "is_system_generated")
  bool? isSystemGenerated;

  @JsonKey(name: "modifiedOn")
  @ColumnInfo(name: "modified_on")
  String? modifiedOn;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modifiedBy;

  @ignore
  @JsonKey(name: "customerAddress")
  List<CustomerAddressResponse>? customerAddress;

  @ignore
  @JsonKey(ignore: true)
  List<int>? listOfDistributionId;
}
