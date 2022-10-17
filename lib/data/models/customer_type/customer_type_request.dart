import 'package:json_annotation/json_annotation.dart';

part 'customer_type_request.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type request class which is used in customer
/// type api call.

@JsonSerializable()
class CustomerTypeRequest {
  CustomerTypeRequest({
    required this.fromTimeStamp,
  });

  factory CustomerTypeRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomerTypeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerTypeRequestToJson(this);

  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;
}
