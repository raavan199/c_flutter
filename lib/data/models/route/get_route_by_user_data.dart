import 'package:cygneto/constants/app_constants.dart';
import 'package:cygneto/data/models/route/get_route_by_user_items.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_route_by_user_data.g.dart';

/// Created by Dev 1051 on 12/28/2021
/// Purpose : This is a GetRouteByUser response class which is
/// used in GetRouteByUser api call.


@JsonSerializable()
class RouteData{

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
  List<RouteItems>? items;



  RouteData({required this.pageIndex, required this.pageSize, required this.totalCount,
    required this.totalPages, required this.hasPreviousPage, this.hasNextPage,
    this.items});

  factory RouteData.fromJson(Map<String,dynamic> json)=>
      _$RouteDataFromJson(json);

  Map<String, dynamic> toJson() => _$RouteDataToJson(this);


}