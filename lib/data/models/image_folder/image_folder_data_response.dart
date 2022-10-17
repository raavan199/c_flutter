import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_folder_data_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a visit partners data response class which is used in
/// visit partners data api call.

@JsonSerializable()
@Entity(tableName: "ImageFolder")
class ImageFolderDataResponse {
  ImageFolderDataResponse({
    required this.id,
    required this.name,
    this.createdBy,
    this.createdOn,
    this.modifiedBy,
    this.modifiedOn
  });

  factory ImageFolderDataResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageFolderDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageFolderDataResponseToJson(this);

  @primaryKey
  @JsonKey(name: "id")
  @ColumnInfo(name: "id")
  int id;

  @JsonKey(name: "name")
  @ColumnInfo(name: "name")
  String name;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? createdBy;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? createdOn;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modifiedBy;

  @JsonKey(name: "modifiedOn")
  @ColumnInfo(name: "modified_on")
  String? modifiedOn;
}
