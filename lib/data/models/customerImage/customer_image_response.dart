import 'package:cygneto/exports/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_image_response.g.dart';

/// Created by Dev 2183 on 02/01/2022
/// Modified by Dev 2183 on 02/01/2022
/// Purpose : This is a customer Image response class which is used
/// to get customer and Image Folder mapping response.

@JsonSerializable()
class CustomerImageResponse {
  CustomerImageResponse(this.data, this.succeeded, this.message, this.errors);

  factory CustomerImageResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerImageResponseToJson(this);

  CustomerImageDataResponse? data;
  bool? succeeded;
  String? message;
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
