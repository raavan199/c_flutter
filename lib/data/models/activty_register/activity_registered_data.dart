import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'activity_registered_data.g.dart';

/// Created by Dev 2136 on 01/04/2022
/// Modified by Dev 2136 on 01/04/2022
/// Purpose : This is a customer type data response class which is used to get customer
/// type data response.

@JsonSerializable()
class ActivityRegisteredData {
  ActivityRegisteredData(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory ActivityRegisteredData.fromJson(Map<String, dynamic> json) =>
      _$ActivityRegisteredDataFromJson(json);

  Map<String, dynamic> toJson() => _$ActivityRegisteredDataToJson(this);

  int? pageIndex;

  int? pageSize;

  int? totalCount;

  int? totalPages;

  bool? hasPreviousPage;

  bool? hasNextPage;

  List<ActivityRegisteredItem>? items;
}
