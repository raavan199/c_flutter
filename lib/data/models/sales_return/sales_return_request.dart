import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';
part 'sales_return_request.g.dart';
@JsonSerializable()
class SalesReturnRequest{

  SalesReturnRequest(this.data);

  @JsonKey(name: "data")
  List<SalesReturnItem>? data;

  factory SalesReturnRequest.fromJson(Map<String, dynamic> json) =>
      _$SalesReturnRequestFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    print('Sales Return: ${jsonEncode(data)}');
    return data;
  }
}