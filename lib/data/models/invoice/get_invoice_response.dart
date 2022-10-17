import 'package:cygneto/data/models/invoice/get_invoice_data_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'get_invoice_response.g.dart';
@JsonSerializable()
class GetInvoiceResponse{
  GetInvoiceResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory GetInvoiceResponse.fromJson(Map<String, dynamic> json) =>
      _$GetInvoiceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetInvoiceResponseToJson(this);

  @JsonKey(name: "data")
  GetInvoiceDataResponse? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}