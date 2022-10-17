import 'package:json_annotation/json_annotation.dart';
import 'customer_data_items_response.dart';

part 'customer_data_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type data response class which is used to get customer
/// type data response.

@JsonSerializable()
class CustomerDataResponse {
  CustomerDataResponse(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory CustomerDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerDataResponseToJson(this);

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
  List<CustomerDataItemsResponse>? items;
}
