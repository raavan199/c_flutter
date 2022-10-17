import 'package:json_annotation/json_annotation.dart';

part 'get_route_by_user_request.g.dart';

/// Created by Dev 1051 on 01/04/2022
/// Purpose : This is a route request class which is used in route api call.
@JsonSerializable()
class GetRouteByUserRequest {


  @JsonKey(name: "pageIndex")
  int? pageIndex;
  @JsonKey(name: "pageSize")
  int? pageSize;
  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;

  GetRouteByUserRequest({
    required this.pageIndex,
    this.pageSize = 10,
    required this.fromTimeStamp,
  });

  factory GetRouteByUserRequest.fromJson(Map<String, dynamic> json) =>
      _$GetRouteByUserRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GetRouteByUserRequestToJson(this);


}
