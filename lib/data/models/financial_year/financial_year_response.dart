import 'package:json_annotation/json_annotation.dart';

import 'financial_year_data.dart';

part 'financial_year_response.g.dart';

@JsonSerializable()
class FinancialYearResponse {
  FinancialYearResponse(this.succeeded, this.errors, this.message, this.data);

  factory FinancialYearResponse.fromJson(Map<String, dynamic> json) =>
      _$FinancialYearResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FinancialYearResponseToJson(this);

  bool? succeeded;
  String? errors;
  String? message;
  String? lastSyncTimeStamp;
  List<FinancialYearData>? data;
}
