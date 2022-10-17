// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_address_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerAddressResponse _$CustomerAddressResponseFromJson(
        Map<String, dynamic> json) =>
    CustomerAddressResponse(
      id: json['id'] as int?,
      customerId: json['customerId'] as int?,
      pincode: json['pincode'] as String?,
      contactPersonName: json['contactPersonName'] as String?,
      countryId: json['countryId'] as int?,
      countryName: json['countryName'] as String?,
      stateId: json['stateId'] as int?,
      stateName: json['stateName'] as String?,
      districtId: json['districtId'] as int?,
      districtName: json['districtName'] as String?,
      locationId: json['locationId'] as int?,
      locationName: json['locationName'] as String?,
      fullAddress: json['fullAddress'] as String?,
      isDefaultAddress: json['isDefaultAddress'] as bool?,
      latitude: json['latitude'] as String?,
      isActive: json['isActive'] as bool?,
      longitude: json['longitude'] as String?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$CustomerAddressResponseToJson(
        CustomerAddressResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'pincode': instance.pincode,
      'contactPersonName': instance.contactPersonName,
      'countryId': instance.countryId,
      'countryName': instance.countryName,
      'stateId': instance.stateId,
      'stateName': instance.stateName,
      'districtId': instance.districtId,
      'districtName': instance.districtName,
      'locationId': instance.locationId,
      'locationName': instance.locationName,
      'fullAddress': instance.fullAddress,
      'isDefaultAddress': instance.isDefaultAddress,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'isActive': instance.isActive,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
    };
