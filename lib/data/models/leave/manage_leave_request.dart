import 'dart:convert';
import 'package:cygneto/data/models/leave/leave_item.dart';
import 'package:json_annotation/json_annotation.dart';

part 'manage_leave_request.g.dart';

/// Created by Dev 2183 on 02/08/2022
/// Modified by Dev 2183 on 02/08/2022
/// Purpose : This is a Leave request class which is used in apply leave
/// api call.

@JsonSerializable()
class ManageLeaveRequest {
  @JsonKey(name: 'data')
  List<LeaveItem>? data;

  ManageLeaveRequest([this.data]);


  ManageLeaveRequest.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LeaveItem>[];
      json['data'].forEach((v) {
        data!.add(LeaveItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    print('apply Leave API request Json: ${jsonEncode(data)}');
    return data;
  }
}