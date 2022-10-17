import 'package:json_annotation/json_annotation.dart';
import 'warehouse_data_response.dart';

part 'warehouse_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a warehouse parent response class which is used to get warehouse
/// response.

@JsonSerializable()
class WarehouseResponse {
  WarehouseResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory WarehouseResponse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseResponseToJson(this);

  @JsonKey(name: "data")
  WarehouseDataResponse? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
