import 'package:json_annotation/json_annotation.dart';

import 'order_invoice_mapping.dart';
part 'get_invoice_data_response.g.dart';
@JsonSerializable()
class GetInvoiceDataResponse{
  GetInvoiceDataResponse(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory GetInvoiceDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInvoiceDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetInvoiceDataResponseToJson(this);

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
  List<OrderInvoiceMapping>? items;


}