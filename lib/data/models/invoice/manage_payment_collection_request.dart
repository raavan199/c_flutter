import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import 'invoice_item.dart';
import 'invoice_statement_item.dart';

part 'manage_payment_collection_request.g.dart';

@JsonSerializable()
class ManagePaymentCollectionRequest {
  ManagePaymentCollectionRequest(
      this.data,
      );


  @JsonKey(name: "data")
  List<InvoiceStatementItem>? data;

  factory ManagePaymentCollectionRequest.fromJson(Map<String, dynamic> json) =>
      _$ManagePaymentCollectionRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    print('payment Collection Json: ${jsonEncode(data)}');
    return data;
  }
}
