import 'package:json_annotation/json_annotation.dart';

import '../../../exports/constants.dart';

part 'warehouse_request.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a warehouse request class which is used in warehouse
/// api call.

@JsonSerializable()
class WarehouseRequest {
  WarehouseRequest({
    required this.pageIndex,
    required this.fromTimeStamp,
    this.pageSize = PageIndex.pageSize,
  });

  factory WarehouseRequest.fromJson(Map<String, dynamic> json) =>
      _$WarehouseRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseRequestToJson(this);

  @JsonKey(name: "pageIndex")
  int? pageIndex;

  @JsonKey(name: "pageSize")
  int? pageSize;

  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;
}
