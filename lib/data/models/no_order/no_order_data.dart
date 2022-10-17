import 'package:json_annotation/json_annotation.dart';

import 'no_order_request.dart';

part 'no_order_data.g.dart';

@JsonSerializable()
class NoOrderData {
  NoOrderData(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory NoOrderData.fromJson(Map<String, dynamic> json) =>
      _$NoOrderDataFromJson(json);

  Map<String, dynamic> toJson() => _$NoOrderDataToJson(this);

  @JsonKey(name: "pageIndex")
  int? pageIndex;

  @JsonKey(name: "pageSize")
  int? pageSize;

  @JsonKey(name: "totalCount")
  int? totalCount;

  @JsonKey(name: "totalPages")
  int? totalPages;

  @JsonKey(name: "hasPreviousPage")
  bool? hasPreviousPage;

  @JsonKey(name: "hasNextPage")
  bool? hasNextPage;

  @JsonKey(name: "items")
  List<NoOrderRequest>? items;
}
