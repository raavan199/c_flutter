import 'package:json_annotation/json_annotation.dart';

import '../../../exports/constants.dart';

part 'visit_request.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a visit request class which is used in visit
/// api call.

@JsonSerializable()
class VisitRequest {
  VisitRequest({
    required this.pageIndex,
    required this.fromTimeStamp,
    this.pageSize = PageIndex.pageSize,
  });

  factory VisitRequest.fromJson(Map<String, dynamic> json) =>
      _$VisitRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VisitRequestToJson(this);

  int pageIndex;
  int pageSize;
  String? fromTimeStamp;
}
