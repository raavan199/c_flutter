import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../constants/app_constants.dart';

part 'no_order_request.g.dart';

@JsonSerializable()
@Entity(tableName: 'NoOrder')
class NoOrderRequest {
  @primaryKey
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? created_by;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? created_on;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modified_by;

  @JsonKey(name: "modifiedOn")
  @ColumnInfo(name: "modified_on")
  String? modified_on;

  @JsonKey(name: "customerId")
  @ColumnInfo(name: "customer_id")
  int? customerId;

  @JsonKey(name: "noOrderTypeId")
  @ColumnInfo(name: "no_order_type_id")
  int? noOrderTypeId;

  @JsonKey(name: "remarks")
  @ColumnInfo(name: "remarks")
  String? remarks;

  @JsonKey(name: "isActive")
  @ColumnInfo(name: "is_active")
  bool? isActive;

  @JsonKey(name: "visitId")
  @ColumnInfo(name: "visitId")
  int? visitId;

  @ColumnInfo(name: "isSync")
  @JsonKey(ignore: true)
  int isSync;


  NoOrderRequest(
      {this.id,
        this.created_by,
        this.created_on,
        this.modified_by,
        this.modified_on,
        this.customerId,
        this.noOrderTypeId,
        this.remarks,
        this.isActive,
        this.visitId,
        this.isSync = SyncStatus.sync});


  factory NoOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$NoOrderRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.created_by;
    data['createdOn'] = this.created_on;
    data['modifiedBy'] = this.modified_by;
    data['modifiedOn'] = this.modified_on;
    data['customerId'] = this.customerId;
    data['visitId'] = this.visitId;
    data['noOrderTypeId'] = this.noOrderTypeId;
    data['remarks'] = this.remarks;
    data['isActive'] = this.isActive;
    print('visitPunch API request Json: ${jsonEncode(data)}');
    return data;
  }
}