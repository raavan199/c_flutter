import 'package:cygneto/exports/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'miss_punch_data.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a product category list data response class which is used
/// to get product category list data response.

@JsonSerializable()
class MissPunchData {
  MissPunchData(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory MissPunchData.fromJson(Map<String, dynamic> json) =>
      _$MissPunchDataFromJson(json);

  Map<String, dynamic> toJson() => _$MissPunchDataToJson(this);

  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  bool hasPreviousPage;
  bool hasNextPage;
  List<MissPunchItem>? items;
}
