import 'package:cygneto/constants/app_constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'miss_punch_request.g.dart';

@JsonSerializable()
class MissPunchRequest {
  int? pageIndex;
  int? pageSize;
  int? missedPunchStatus;

  MissPunchRequest({this.pageIndex, this.pageSize = PageIndex.pageSize, this.missedPunchStatus});


  factory MissPunchRequest.fromJson(Map<String, dynamic> json) =>
      _$MissPunchRequestFromJson(json);

  Map<String, dynamic> toJson() => _$MissPunchRequestToJson(this);


}