import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_image_item_response.g.dart';

/// Created by Dev 2183 on 02/01/2022
/// Modified by Dev 2183 on 02/01/2022
/// Purpose : This is a customer Image Item response class which is used
/// to get customer and Image Folder Item mapping response.

@JsonSerializable()
@Entity(tableName: 'CustomerImage')
class CustomerImageItemResponse {
  CustomerImageItemResponse({this.fileName,
    this.folderId,
    this.mediaFileId,
    this.customerId,
    this.isCover,
    this.created_by,
    this.created_on,
    this.modified_by,
    this.modified_on,
    this.id});


  factory CustomerImageItemResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerImageItemResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerImageItemResponseToJson(this);

  @JsonKey(name: 'fileName')
  @ColumnInfo(name: 'file_name')
  String? fileName;

  @JsonKey(name: 'folderId')
  @ColumnInfo(name: 'folder_id')
  int? folderId;

  @JsonKey(name: 'mediaFileId')
  @ColumnInfo(name: 'media_file_id')
  int? mediaFileId;

  @JsonKey(name: 'customerId')
  @ColumnInfo(name: 'customer_id')
  int? customerId;

  @JsonKey(name: 'isCover')
  @ColumnInfo(name: 'is_cover')
  bool? isCover;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? created_by;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? created_on;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modified_by;

  @JsonKey(name: "modifiedOn")
  @ColumnInfo(name: "modified_on")
  String? modified_on;

  @primaryKey
  @JsonKey(name: "id")
  int? id;
}
