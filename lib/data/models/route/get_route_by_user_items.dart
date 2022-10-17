import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'get_route_by_user_items.g.dart';

/// Created by Dev 1051 on 12/28/2021
/// Purpose : This is a GetRouteByUser response class which is
/// used in GetRouteByUser api call.

@JsonSerializable()
@Entity(tableName: "route")
class RouteItems {
  RouteItems(
      {required this.id,
      required this.name,
      required this.status,
      required this.subscriberId,
      required this.createdBy,
      this.createdOn,
      this.modifiedBy,
      this.modifiedOn,
      this.totalOutlets,
      this.visitsCount});

  factory RouteItems.fromJson(Map<String, dynamic> json) =>
      _$RouteItemsFromJson(json);

  Map<String, dynamic> toJson() => _$RouteItemsToJson(this);

  @JsonKey(name: "id")
  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @JsonKey(name: "name")
  @ColumnInfo(name: "name")
  String? name;

  @JsonKey(name: "status")
  @ColumnInfo(name: "status")
  int? status;

  @JsonKey(name: "subscriberId")
  @ColumnInfo(name: "subscriber_id")
  int? subscriberId;

  @JsonKey(name: "createdBy")
  @ColumnInfo(name: "created_by")
  int? createdBy;

  @JsonKey(name: "createdOn")
  @ColumnInfo(name: "created_on")
  String? createdOn;

  @JsonKey(name: "modifiedBy")
  @ColumnInfo(name: "modified_by")
  int? modifiedBy;

  @JsonKey(name: "modifiedOn")
  @ColumnInfo(name: "modified_on")
  String? modifiedOn;


  @ignore
  int? totalOutlets;

  @ignore
  int? visitsCount;
}
