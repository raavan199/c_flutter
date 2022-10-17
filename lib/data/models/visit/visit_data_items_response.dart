import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit_data_items_response.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a visit items data response class which is used
/// to get visit data items response.

@JsonSerializable()
@Entity(tableName: "VisitDetail")
class VisitDataItemsResponse {
  VisitDataItemsResponse({
    this.visitType,
    this.partnerId,
    this.makeOwner,
    this.customerId,
    this.startTime,
    this.endTime,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn,
    this.id,
    this.isSync = 1,
    this.totalAmount,
    this.orderId,
    this.businessName,
    this.customerType,
    this.noOrderId,
    this.scopeId,
  });

  @JsonKey(name: "visitType")
  @ColumnInfo(name: "visit_type")
  int? visitType;

  @JsonKey(name: "partnerId")
  @ColumnInfo(name: "partner_id")
  int? partnerId;

  @JsonKey(name: "makeOwner")
  @ColumnInfo(name: "make_owner")
  bool? makeOwner;

  @JsonKey(name: "customerId")
  @ColumnInfo(name: "customer_id")
  int? customerId;

  @JsonKey(name: "startTime")
  @ColumnInfo(name: "start_time")
  String? startTime;

  @JsonKey(name: "endTime")
  @ColumnInfo(name: "end_time")
  String? endTime;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? createdBy;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? createdOn;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modifiedBy;

  @ColumnInfo(name: "modified_on")
  @JsonKey(name: "modifiedOn")
  String? modifiedOn;

  @JsonKey(name: 'id', includeIfNull: false)
  @primaryKey
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: "isSync")
  @JsonKey(ignore: true)
  int? isSync;

  int? scopeId;

  @ignore
  double? totalAmount;

  @ignore
  int? orderId;

  @ignore
  String? businessName;

  @ignore
  int? customerType;

  @ignore
  int? noOrderId;

  factory VisitDataItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitDataItemsResponseFromJson(json);

  factory VisitDataItemsResponse.fromJsonForRowQuery(
          Map<String, dynamic> json) =>
      VisitDataItemsResponse(
        id: json['id'] as int?,
        partnerId: json['partner_id'] as int?,
        startTime: json['start_time'] as String?,
        endTime: json['end_time'] as String?,
        totalAmount: (json['total_amount'] as num?)?.toDouble(),
        orderId: json['Order_ID'] as int?,
        businessName: json['business_name'] as String?,
        customerType: json['customer_type'] as int?,
        customerId: json['customer_id'] as int?,
        noOrderId: json['no_order_id'] as int?,
      );

  Map<String, dynamic> toJson() => _$VisitDataItemsResponseToJson(this);
}
