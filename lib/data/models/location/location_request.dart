import 'package:cygneto/constants/app_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_request.g.dart';

/// Created by Dev 1051 on 1/10/2022
/// Purpose : This is a location request class which is used in location api call.
@JsonSerializable()
class LocationRequest {


  @JsonKey(name: "pageIndex")
  int? pageIndex;
  @JsonKey(name: "pageSize")
  int? pageSize;
  @JsonKey(name: "districtId")
  int? districtId;
  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;


  LocationRequest({
      this.pageIndex, this.pageSize=PageIndex.pageSize,
    this.districtId, this.fromTimeStamp});

  factory LocationRequest.fromJson(Map<String, dynamic> json) =>
      _$LocationRequestFromJson(json);
  Map<String,dynamic> toJson() => _$LocationRequestToJson(this);


}
