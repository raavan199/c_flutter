import 'package:json_annotation/json_annotation.dart';

part 'punch_media_file_data.g.dart';

/// Created by Dev 2183 on 02/18/2022
/// Modified by Dev 2183 on 01/18/2022
/// Purpose : This is a visit data response class which is used
/// to get visit data response.

@JsonSerializable()
class PunchMediaFileData {
  int? module;
  String? filePath;
  String? fileName;
  int? createdBy;
  String? createdOn;
  int? modifiedBy;
  String? modifiedOn;
  int? id;

  PunchMediaFileData(
      {this.module,
        this.filePath,
        this.fileName,
        this.createdBy,
        this.createdOn,
        this.modifiedBy,
        this.modifiedOn,
        this.id});

  factory PunchMediaFileData.fromJson(Map<String, dynamic> json) =>
      _$PunchMediaFileDataFromJson(json);

  Map<String, dynamic> toJson() => _$PunchMediaFileDataToJson(this);

}