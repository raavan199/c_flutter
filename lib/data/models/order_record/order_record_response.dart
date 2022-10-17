import 'package:json_annotation/json_annotation.dart';

import 'order_record_data_response.dart';

part 'order_record_response.g.dart';

/// Created by Dev 2183 on 01/24/2022
/// Modified by Dev 2183 on 01/24/2022
/// Purpose : This is a Order record response class which is used in
/// Order record API call

@JsonSerializable()
class OrderRecordResponse {
  OrderRecordResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory OrderRecordResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderRecordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRecordResponseToJson(this);

  List<OrderRecordDataResponse>? data;
  bool? succeeded;
  String? message;
  String? errors;
}
