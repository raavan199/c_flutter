import 'package:json_annotation/json_annotation.dart';
import 'state_data_item_response.dart';

part 'state_data_response.g.dart';

/// Created by Dev 1051 on 12/24/2021
/// Modified by Dev 2136 on 12/24/2021
/// Purpose : This is a parent reset pin response which will be used to parse the
/// response of reset pin.
@JsonSerializable()
class StateDataResponse {
  StateDataResponse(
      this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.totalPages,
      this.hasPreviousPage,
      this.hasNextPage,
      this.items
      );

  factory StateDataResponse.fromJson(Map<String, dynamic> json) =>
      _$StateDataResponseFromJson(json);
  Map<String, dynamic> toJson() => _$StateDataResponseToJson(this);

  int pageIndex;
  int pageSize;
  int totalCount;
  int totalPages;
  bool hasPreviousPage;
  bool hasNextPage;
  List<StateDataItemResponse>? items;
}
