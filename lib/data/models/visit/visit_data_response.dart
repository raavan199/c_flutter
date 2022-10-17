import 'package:json_annotation/json_annotation.dart';
import 'visit_data_items_response.dart';

part 'visit_data_response.g.dart';

/// Created by Dev 2136 on 01/07/2022
/// Modified by Dev 2136 on 01/07/2022
/// Purpose : This is a visit data response class which is used
/// to get visit data response.

@JsonSerializable()
class VisitDataResponse {
  VisitDataResponse(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items,
      );

  factory VisitDataResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitDataResponseToJson(this);

  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  bool hasPreviousPage;
  bool hasNextPage;
  List<VisitDataItemsResponse>? items;
}
