import 'package:json_annotation/json_annotation.dart';
import 'warehouse_data_items_response.dart';

part 'warehouse_data_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a warehouse data response class which is used to get warehouse
/// data response.

@JsonSerializable()
class WarehouseDataResponse {
  WarehouseDataResponse(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory WarehouseDataResponse.fromJson(Map<String, dynamic> json) =>
      _$WarehouseDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseDataResponseToJson(this);

  @JsonKey(name: "pageIndex")
  int? pageIndex;

  @JsonKey(name: "pageSize")
  int? pageSize;

  @JsonKey(name: "totalCount")
  int? totalCount;

  @JsonKey(name: "totalPages")
  int? totalPages;

  @JsonKey(name: "hasPreviousPage")
  bool hasPreviousPage;

  @JsonKey(name: "hasNextPage")
  bool hasNextPage;

  @JsonKey(name: "items")
  List<WarehouseDataItemsResponse>? items;
}
