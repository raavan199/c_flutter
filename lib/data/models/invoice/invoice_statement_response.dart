import 'package:json_annotation/json_annotation.dart';

import 'invoice_statement_pagination_item.dart';

part 'invoice_statement_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type parent response class which is used to get customer
/// type response.

@JsonSerializable()
class InvoiceStatementResponse {
  InvoiceStatementResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory InvoiceStatementResponse.fromJson(Map<String, dynamic> json) =>
      _$InvoiceStatementResponseFromJson(json);

  Map<String, dynamic> toJson() => _$InvoiceStatementResponseToJson(this);

  @JsonKey(name: "data")
  InvoiceStatementPaginationItem? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
