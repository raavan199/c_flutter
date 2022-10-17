import 'package:json_annotation/json_annotation.dart';
import 'customer_type_data_response.dart';

part 'customer_type_response.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type parent response class which is used to get customer
/// type response.

@JsonSerializable()
class CustomerTypeResponse {
  CustomerTypeResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory CustomerTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerTypeResponseToJson(this);

  @JsonKey(name: "data")
  List<CustomerTypeDataResponse>? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;
  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
