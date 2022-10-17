import 'package:json_annotation/json_annotation.dart';

import '../../../exports/constants.dart';

part 'product_list_request.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type request class which is used in customer
/// type api call.

@JsonSerializable()
class ProductListRequest {
  ProductListRequest({
    required this.pageIndex,
    this.pageSize = PageIndex.pageSize,
  });

  factory ProductListRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductListRequestToJson(this);

  @JsonKey(name: "pageIndex")
  int? pageIndex;

  @JsonKey(name: "pageSize")
  int? pageSize;
}
