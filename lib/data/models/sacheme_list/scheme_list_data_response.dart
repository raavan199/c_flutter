import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'scheme_list_data_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a Scheme List data response class which is used in
/// SchemeList data api call.

@JsonSerializable()
@Entity(tableName: "Scheme")
class SchemeListDataResponse {
  SchemeListDataResponse({
    this.subscriberId,
    this.name,
    this.schemeType,
    this.distributorId,
    this.distributorType,
    this.customerId,
    this.customerType,
    this.customerCategory,
    this.stateId,
    this.fyId,
    this.startDate,
    this.endDate,
    this.minTotalValue,
    this.maxTotalValue,
    this.minOrderQnty,
    this.maxOrderQnty,
    this.orderUOM,
    this.complementaryQntyPercent,
    this.complementaryUOM,
    this.freeProductId,
    this.additionalDiscountPercent,
    this.created_by,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.id
  });

  factory SchemeListDataResponse.fromJson(Map<String, dynamic> json) =>
      _$SchemeListDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SchemeListDataResponseToJson(this);


  int? subscriberId;

  String? name;

  int? schemeType;

  int? distributorId;

  int? distributorType;

  int? customerId;

  int? customerType;

  int? customerCategory;

  int? stateId;

  int? fyId;

  String? startDate;

  String? endDate;


  double? minTotalValue;


  double? maxTotalValue;


  double? minOrderQnty;


  double? maxOrderQnty;


  int? orderUOM;


  double? complementaryQntyPercent;


  int? complementaryUOM;


  int? freeProductId;


  double? additionalDiscountPercent;
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

  @primaryKey
  @JsonKey(name: "id")
  int? id;

}
