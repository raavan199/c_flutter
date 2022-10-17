
import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'location_data_response.g.dart';

/// Created by Dev 1051 on 1/10/2022



@JsonSerializable()
class Locationdata{

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
  List<LocationDataItems>? items;



  Locationdata({required this.pageIndex, required this.pageSize, required this.totalCount,
    required this.totalPages, required this.hasPreviousPage, this.hasNextPage,
    this.items});

  factory Locationdata.fromJson(Map<String,dynamic> json)=>
      _$LocationdataFromJson(json);

  Map<String, dynamic> toJson() => _$LocationdataToJson(this);


}