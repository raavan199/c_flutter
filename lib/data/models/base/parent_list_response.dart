import 'package:json_annotation/json_annotation.dart';

import '../product_trends/product_trends_item.dart';

part 'parent_list_response.g.dart';

@JsonSerializable()
class ParentListResponse {
  ParentListResponse({this.items});

  @JsonKey(name: "items")
  List<ProductTrendsItem>? items;

  factory ParentListResponse.fromJson(Map<String, dynamic> json) =>
      _$ParentListResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParentListResponseToJson(this);
}
