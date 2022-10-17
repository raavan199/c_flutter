import 'package:json_annotation/json_annotation.dart';

import '../../../exports/constants.dart';

part 'scheme_list_request.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a Scheme List request class which is used in Scheme
/// List api call.

@JsonSerializable()
class SchemeListRequest {
  SchemeListRequest({
    required this.pageIndex,
    required this.fromTimeStamp,
    this.pageSize = PageIndex.pageSize,
  });

  factory SchemeListRequest.fromJson(Map<String, dynamic> json) =>
      _$SchemeListRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SchemeListRequestToJson(this);

  int pageIndex;
  int pageSize;
  String? fromTimeStamp;
}
