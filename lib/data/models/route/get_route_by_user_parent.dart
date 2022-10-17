

import 'package:json_annotation/json_annotation.dart';

import 'get_route_by_user_data.dart';

part 'get_route_by_user_parent.g.dart';

@JsonSerializable()
class GetRouteByUserParent{

  @JsonKey(name: "data")
  RouteData? routeData;

  @JsonKey(name:"succeeded")
  bool? succeeded;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;

  factory GetRouteByUserParent.fromJson(Map<String,dynamic> json)=>
      _$GetRouteByUserParentFromJson(json);
  Map<String,dynamic> toJson()=>_$GetRouteByUserParentToJson(this);


  GetRouteByUserParent(
      this.routeData, this.succeeded, this.message, this.errors);
}