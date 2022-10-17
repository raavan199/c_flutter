import 'package:json_annotation/json_annotation.dart';

import 'country_data_response.dart';

part 'country_response.g.dart';

/// Created by Dev 2136 on 01/10/2022
/// Purpose : This is a country  parent response class which is used to get country
/// type response.

@JsonSerializable()
class CountryResponse {
  CountryResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory CountryResponse.fromJson(Map<String, dynamic> json) =>
      _$CountryResponseFromJson(json);

  Map<String,dynamic> toJson() => _$CountryResponseToJson(this);

  @JsonKey(name: "data")
  List<CountryData>? data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;
}
