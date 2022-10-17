// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_data_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDataItemsResponse _$CustomerDataItemsResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerDataItemsResponse(
      id: json['id'] as int?,
      contactPersonName: json['contactPersonName'] as String?,
      businessName: json['businessName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      emailAddress: json['emailAddress'] as String?,
      pincode: json['pincode'] as int?,
      gstin: json['gstin'] as String?,
      routeId: json['routeId'] as int?,
      routeName: json['routeName'] as String?,
      customerType: json['customerType'] as int?,
      customerTypeName: json['customerTypeName'] as String?,
      isActive: json['isActive'] as bool?,
      distributorId_1: json['distributorId_1'] as int?,
      distributorId_2: json['distributorId_2'] as int?,
      distributorId_3: json['distributorId_3'] as int?,
      customerCategory: json['customerCategory'] as int?,
      customerCategoryName: json['customerCategoryName'] as String?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      isSystemGenerated: json['isSystemGenerated'] as bool?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      customerAddress: (json['customerAddress'] as List<dynamic>?)
          ?.map((e) =>
              CustomerAddressResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomerDataItemsResponseToJson(
        CustomerDataItemsResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'contactPersonName': instance.contactPersonName,
      'businessName': instance.businessName,
      'mobileNumber': instance.mobileNumber,
      'emailAddress': instance.emailAddress,
      'pincode': instance.pincode,
      'gstin': instance.gstin,
      'routeId': instance.routeId,
      'routeName': instance.routeName,
      'customerType': instance.customerType,
      'customerTypeName': instance.customerTypeName,
      'isActive': instance.isActive,
      'distributorId_1': instance.distributorId_1,
      'distributorId_2': instance.distributorId_2,
      'distributorId_3': instance.distributorId_3,
      'customerCategory': instance.customerCategory,
      'customerCategoryName': instance.customerCategoryName,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'isSystemGenerated': instance.isSystemGenerated,
      'modifiedOn': instance.modifiedOn,
      'modifiedBy': instance.modifiedBy,
      'customerAddress': instance.customerAddress,
    };
