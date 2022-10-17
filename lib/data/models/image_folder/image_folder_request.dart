import 'package:json_annotation/json_annotation.dart';

part 'image_folder_request.g.dart';

/// Created by Dev 2183 on 01/10/2022
/// Modified by Dev 2136 on 01/10/2022
/// Purpose : This is a image album folder request class which is used in image
/// folder api call.

@JsonSerializable()
class ImageFolderRequest {
  ImageFolderRequest({
    required this.fromTimeStamp,
  });

  factory ImageFolderRequest.fromJson(Map<String, dynamic> json) =>
      _$ImageFolderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ImageFolderRequestToJson(this);

  String? fromTimeStamp;
}
