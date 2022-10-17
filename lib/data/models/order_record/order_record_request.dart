import 'package:json_annotation/json_annotation.dart';

part 'order_record_request.g.dart';

/// Created by Dev 2183 on 01/24/2022
/// Modified by Dev 2183 on 01/24/2022
/// Purpose : This is a Order Record request call which used for
/// Order Record API call

@JsonSerializable()
class OrderRecordRequest {
  OrderRecordRequest({
    required this.fromTimeStamp,
  });

  factory OrderRecordRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderRecordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$OrderRecordRequestToJson(this);

  String? fromTimeStamp;
}
