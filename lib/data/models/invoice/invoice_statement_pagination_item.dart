import 'package:json_annotation/json_annotation.dart';
import 'invoice_statement_item.dart';

part 'invoice_statement_pagination_item.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type data response class which is used to get customer
/// type data response.

@JsonSerializable()
class InvoiceStatementPaginationItem {
  InvoiceStatementPaginationItem(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory InvoiceStatementPaginationItem.fromJson(Map<String, dynamic> json) =>
      _$InvoiceStatementPaginationItemFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceStatementPaginationItemToJson(this);

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
  List<InvoiceStatementItem>? items;
}
