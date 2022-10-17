import 'package:json_annotation/json_annotation.dart';
import 'customer_data_response.dart';

part 'customer_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type parent response class which is used to get customer
/// type response.

@JsonSerializable()
class CustomerResponse {
  CustomerResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);

  @JsonKey(name: "data")
  CustomerDataResponse? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
