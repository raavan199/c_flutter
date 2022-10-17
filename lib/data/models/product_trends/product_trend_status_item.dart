import 'package:json_annotation/json_annotation.dart';

import 'product_trend_pagination_item.dart';

part 'product_trend_status_item.g.dart';

@JsonSerializable()
class ProductTrendStatusItem {
  ProductTrendStatusItem(
      {required this.data, this.succeeded, this.message, this.errors});

  @JsonKey(name: "data")
  ProductTrendPaginationItem data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;

  factory ProductTrendStatusItem.fromJson(Map<String, dynamic> json) =>
      _$ProductTrendStatusItemFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTrendStatusItemToJson(this);
}
