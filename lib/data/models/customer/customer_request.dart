import 'package:cygneto/exports/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_request.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type request class which is used in customer
/// type api call.

@JsonSerializable()
class CustomerRequest {
  CustomerRequest({
    required this.pageIndex,
    this.pageSize = PageIndex.pageSize,
    this.routeId,
    required this.fromTimeStamp,
  });

  factory CustomerRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerRequestToJson(this);

  @JsonKey(name: "pageIndex")
  int? pageIndex;

  @JsonKey(name: "pageSize")
  int? pageSize;

  @JsonKey(name: "routeId")
  int? routeId;

  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;
}
