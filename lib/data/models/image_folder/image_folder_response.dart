import 'package:json_annotation/json_annotation.dart';

import 'image_folder_data_response.dart';

part 'image_folder_response.g.dart';

/// Created by Dev 2183 on 01/10/2022
/// Modified by Dev 2183 on 01/10/2022
/// Purpose : This is a image folder response class which is used in image
/// folder api call.

@JsonSerializable()
class ImageFolderResponse {
  ImageFolderResponse({
    required this.data,
    required this.succeeded,
    required this.message,
    required this.errors,
  });

  factory ImageFolderResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageFolderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageFolderResponseToJson(this);

  List<ImageFolderDataResponse>? data;
  bool? succeeded;
  String? message;
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;
}
