import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

import 'visit_data_items_response.dart';

part 'manage_visit_punch_request.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a visit request class which is used in visit
/// api call.

@JsonSerializable()
class ManageVisitPunchRequest {
  @JsonKey(name: 'data')
  List<VisitDataItemsResponse>? data;

  ManageVisitPunchRequest([this.data]);


/*  factory ManageVisitPunchRequest.fromJson(Map<String, dynamic> json) =>
      _$ManageVisitPunchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ManageVisitPunchRequestToJson(this);*/


  ManageVisitPunchRequest.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <VisitDataItemsResponse>[];
      json['data'].forEach((v) {
        data!.add(VisitDataItemsResponse.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    print('visitPunch API request Json: ${jsonEncode(data)}');
    return data;
  }
}