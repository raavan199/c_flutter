import 'dart:convert';

import 'no_order_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manage_no_order_request.g.dart';
/// Created by Dev 2183 on 02/03/2022
/// Modified by Dev
/// Purpose : This is a NoOrder request class which is used in No order
/// api call.

@JsonSerializable()
class ManageNoOrderRequest {
  @JsonKey(name: 'data')
  List<NoOrderRequest>? data;

  ManageNoOrderRequest([this.data]);



  ManageNoOrderRequest.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NoOrderRequest>[];
      json['data'].forEach((v) {
        data!.add(NoOrderRequest.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    print('No Order API request Json: ${jsonEncode(data)}');
    return data;
  }
}
