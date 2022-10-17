import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'no_order_type_response.g.dart';

@JsonSerializable()
class NoOrderTypeResponse {
  List<NoOrderTypeData>? data;
  bool? succeeded;
  String? message;
  String? errors;

  NoOrderTypeResponse({this.data, this.succeeded, this.message, this.errors});

  factory NoOrderTypeResponse.fromJson(Map<String, dynamic> json) =>
      _$NoOrderTypeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NoOrderTypeResponseToJson(this);

}