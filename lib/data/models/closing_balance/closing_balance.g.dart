// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'closing_balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClosingBalance _$ClosingBalanceFromJson(Map<String, dynamic> json) =>
    ClosingBalance(
      id: json['id'] as int?,
      customerId: json['customerId'] as int?,
      fyId: json['fyId'] as int?,
      obAmount: (json['obAmount'] as num?)?.toDouble(),
      cbAmount: (json['cbAmount'] as num?)?.toDouble(),
      created_by: json['createdBy'] as int?,
      created_on: json['createdOn'] as String?,
      modified_by: json['modifiedBy'] as int?,
      modified_on: json['modifiedOn'] as String?,
    );

Map<String, dynamic> _$ClosingBalanceToJson(ClosingBalance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'fyId': instance.fyId,
      'obAmount': instance.obAmount,
      'cbAmount': instance.cbAmount,
      'createdBy': instance.created_by,
      'createdOn': instance.created_on,
      'modifiedBy': instance.modified_by,
      'modifiedOn': instance.modified_on,
    };
