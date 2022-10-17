import 'package:cygneto/constants/app_constants.dart';
import 'package:cygneto/data/models/district/district_response.dart';
import 'package:cygneto/data/models/route/get_route_by_user_items.dart';
import 'package:json_annotation/json_annotation.dart';

import 'district_items_response.dart';

part 'district_data_response.g.dart';

/// Created by Dev 1051 on 1/5/2022



@JsonSerializable()
class DistrictData{

  @JsonKey(name: "pageIndex")
  int? pageIndex;
  @JsonKey(name: "pageSize")
  int? pageSize;
  @JsonKey(name: "totalCount")
  int? totalCount;
  @JsonKey(name: "totalPages")
  int? totalPages;
  @JsonKey(name: "hasPreviousPage")
  bool? hasPreviousPage;
  @JsonKey(name: "hasNextPage")
  bool? hasNextPage;
  @JsonKey(name: "items")
  List<DistrictItems>? items;



  DistrictData({required this.pageIndex, required this.pageSize, required this.totalCount,
    required this.totalPages, required this.hasPreviousPage, this.hasNextPage,
    this.items});

  factory DistrictData.fromJson(Map<String,dynamic> json)=>
      _$DistrictDataFromJson(json);

  Map<String, dynamic> toJson() => _$DistrictDataToJson(this);


}