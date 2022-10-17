import 'package:cygneto/constants/app_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'district_request.g.dart';

/// Created by Dev 1051 on 1/5/2022
/// Purpose : This is a district request class which is used in district api call.
@JsonSerializable()
class DistrictRequest {
  DistrictRequest({
    required this.pageIndex,
    this.pageSize = PageIndex.pageSize,
  });

  factory DistrictRequest.fromJson(Map<String, dynamic> json) =>
      _$DistrictRequestFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictRequestToJson(this);

  @JsonKey(name: "pageIndex")
  int? pageIndex;
  @JsonKey(name: "pageSize")
  int? pageSize;
}
