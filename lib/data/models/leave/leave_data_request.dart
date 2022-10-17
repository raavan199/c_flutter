import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'leave_data_request.g.dart';

/// Created by Dev 1051 on 12/28/2021
/// Purpose : This is a GetRouteByUser response class which is
/// used in GetRouteByUser api call.


@JsonSerializable()
class LeaveDataRequest{

  List<LeaveBalance>? leaves;

  List<LeaveItem>? items;



  LeaveDataRequest({ this.leaves, this.items});

  factory LeaveDataRequest.fromJson(Map<String,dynamic> json)=>
      _$LeaveDataRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LeaveDataRequestToJson(this);


}