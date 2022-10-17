import 'package:json_annotation/json_annotation.dart';

import 'visit_partners_data_response.dart';

part 'visit_partners_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a visit partners response class which is used in visit
/// partners api call.

@JsonSerializable()
class VisitPartnersResponse {
  VisitPartnersResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory VisitPartnersResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitPartnersResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitPartnersResponseToJson(this);

  List<VisitPartnersDataResponse>? data;
  bool? succeeded;
  String? message;
  String? errors;
}
