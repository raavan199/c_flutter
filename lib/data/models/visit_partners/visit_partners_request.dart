import 'package:json_annotation/json_annotation.dart';

import '../../../exports/constants.dart';

part 'visit_partners_request.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a visit partners request class which is used in visit
/// partners api call.

@JsonSerializable()
class VisitPartnersRequest {
  VisitPartnersRequest({
    required this.fromTimeStamp,
  });

  factory VisitPartnersRequest.fromJson(Map<String, dynamic> json) =>
      _$VisitPartnersRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VisitPartnersRequestToJson(this);

  String? fromTimeStamp;
}
