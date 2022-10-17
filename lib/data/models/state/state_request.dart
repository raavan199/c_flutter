import 'package:json_annotation/json_annotation.dart';

import '../../../constants/app_constants.dart';

part 'state_request.g.dart';

/// Created by Dev 1051 on 7/15/2021
/// Modified by Dev 1051 on 12/23/2021
/// Purpose : This is a login request class which is used in login api call.
@JsonSerializable()
class StateRequest {

  StateRequest({
    required this.pageIndex,
    this.pageSize = PageIndex.pageSize,
  });

  factory StateRequest.fromJson(Map<String, dynamic> json) =>
      _$StateRequestFromJson(json);
  Map<String, dynamic> toJson() => _$StateRequestToJson(this);
  
  @JsonKey(name: "pageIndex")
  int pageIndex;

  @JsonKey(name: "pageSize")
  int pageSize;
}
