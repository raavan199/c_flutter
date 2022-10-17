import 'package:json_annotation/json_annotation.dart';
import 'customer_data_items_response.dart';

part 'add_customer_response.g.dart';

@JsonSerializable()
class AddCustomerResponse {
  AddCustomerResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory AddCustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$AddCustomerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddCustomerResponseToJson(this);

  CustomerDataItemsResponse? data;
  bool? succeeded;
  String? message;
  String? errors;
}
