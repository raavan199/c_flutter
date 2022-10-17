// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distribution_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DistributionData _$DistributionDataFromJson(Map<String, dynamic> json) =>
    DistributionData(
      businessName: json['businessName'] as String?,
      contactPersonName: json['contactPersonName'] as String?,
      mobileNumber: json['mobileNumber'] as String?,
      emailId: json['emailId'] as String?,
      gstNumber: json['gstNumber'] as String?,
      locationId: json['locationId'] as int?,
      stateId: json['stateId'] as int?,
      tenantId: json['tenantId'] as int?,
      type: json['type'] as int?,
      fullAddress: json['fullAddress'] as String?,
      pincode: json['pincode'] as String?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$DistributionDataToJson(DistributionData instance) =>
    <String, dynamic>{
      'businessName': instance.businessName,
      'contactPersonName': instance.contactPersonName,
      'mobileNumber': instance.mobileNumber,
      'emailId': instance.emailId,
      'gstNumber': instance.gstNumber,
      'locationId': instance.locationId,
      'stateId': instance.stateId,
      'tenantId': instance.tenantId,
      'type': instance.type,
      'fullAddress': instance.fullAddress,
      'pincode': instance.pincode,
      'createdBy': instance.createdBy,
      'createdOn': instance.createdOn,
      'modifiedBy': instance.modifiedBy,
      'modifiedOn': instance.modifiedOn,
      'id': instance.id,
    };
