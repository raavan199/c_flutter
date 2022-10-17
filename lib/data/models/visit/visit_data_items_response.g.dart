// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visit_data_items_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitDataItemsResponse _$VisitDataItemsResponseFromJson(
        Map<String, dynamic> json) =>
    VisitDataItemsResponse(
      visitType: json['visitType'] as int?,
      partnerId: json['partnerId'] as int?,
      makeOwner: json['makeOwner'] as bool?,
      customerId: json['customerId'] as int?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      createdBy: json['createdBy'] as int?,
      createdOn: json['createdOn'] as String?,
      modifiedBy: json['modifiedBy'] as int?,
      modifiedOn: json['modifiedOn'] as String?,
      id: json['id'] as int?,
      totalAmount: (json['totalAmount'] as num?)?.toDouble(),
      orderId: json['orderId'] as int?,
      businessName: json['businessName'] as String?,
      customerType: json['customerType'] as int?,
      noOrderId: json['noOrderId'] as int?,
      scopeId: json['scopeId'] as int?,
    );

Map<String, dynamic> _$VisitDataItemsResponseToJson(
    VisitDataItemsResponse instance) {
  final val = <String, dynamic>{
    'visitType': instance.visitType,
    'partnerId': instance.partnerId,
    'makeOwner': instance.makeOwner,
    'customerId': instance.customerId,
    'startTime': instance.startTime,
    'endTime': instance.endTime,
    'createdBy': instance.createdBy,
    'createdOn': instance.createdOn,
    'modifiedBy': instance.modifiedBy,
    'modifiedOn': instance.modifiedOn,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  val['scopeId'] = instance.scopeId;
  val['totalAmount'] = instance.totalAmount;
  val['orderId'] = instance.orderId;
  val['businessName'] = instance.businessName;
  val['customerType'] = instance.customerType;
  val['noOrderId'] = instance.noOrderId;
  return val;
}
