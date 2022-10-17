import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'attendance_data.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a product category list data response class which is used
/// to get product category list data response.

@JsonSerializable()
class AttendanceData {
  AttendanceData(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory AttendanceData.fromJson(Map<String, dynamic> json) =>
      _$AttendanceDataFromJson(json);

  Map<String, dynamic> toJson() => _$AttendanceDataToJson(this);

  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  bool hasPreviousPage;
  bool hasNextPage;
  List<AttendanceItem>? items;
}
