import 'package:json_annotation/json_annotation.dart';

import 'closing_balance.dart';
part 'closing_balance_response.g.dart';
@JsonSerializable()
class ClosingBalanceResponse {
  ClosingBalanceResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory ClosingBalanceResponse.fromJson(Map<String, dynamic> json) =>
      _$ClosingBalanceResponseFromJson(json);

  Map<String,dynamic> toJson() => _$ClosingBalanceResponseToJson(this);

  @JsonKey(name: "data")
  List<ClosingBalance>? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;
}
