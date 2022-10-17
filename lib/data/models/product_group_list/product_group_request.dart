import 'package:cygneto/exports/constants.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_group_request.g.dart';

/// Created by Dev 1051 on 1/5/2022
/// Purpose : This is a product group  request class which is used
/// in product group list api call.
@JsonSerializable()
class ProductGroupRequest {


  @JsonKey(name: "pageIndex")
  int? pageIndex;
  @JsonKey(name: "pageSize")
  int? pageSize;
  @JsonKey(name: "status")
  int? status;
  @JsonKey(name: "sortBy")
  String? sortBy;
  @JsonKey(name: "sortDesc")
  bool? sortDesc;
  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;



  factory ProductGroupRequest.fromJson(Map<String, dynamic> json) =>
      _$ProductGroupRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ProductGroupRequestToJson(this);

  ProductGroupRequest({this.pageIndex,
    this.pageSize=PageIndex.pageSize, this.status, this.sortBy,
      this.sortDesc, this.fromTimeStamp});
}
