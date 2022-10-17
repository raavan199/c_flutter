import 'package:json_annotation/json_annotation.dart';

import '../../../exports/constants.dart';

part 'product_category_list_request.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a product category list request class which is used in
/// product category list api call.

@JsonSerializable()
class ProductCategoryListRequest {
  ProductCategoryListRequest({
    required this.pageIndex,
    required this.status,
    required this.sortBy,
    required this.sortDesc,
    required this.fromTimeStamp,
    this.pageSize = PageIndex.pageSize,
  });

  factory ProductCategoryListRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductCategoryListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ProductCategoryListRequestToJson(this);

  int? pageIndex;
  int? pageSize;
  int? status;
  String? sortBy;
  bool? sortDesc;
  String? fromTimeStamp;
}
