import 'package:json_annotation/json_annotation.dart';

part 'image_file_response.g.dart';

@JsonSerializable()
class ImageFileResponse {
  String? data;
  bool? succeeded;
  String? message;
  String? errors;

  ImageFileResponse({this.data, this.succeeded, this.message, this.errors});

  factory ImageFileResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageFileResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageFileResponseToJson(this);
}