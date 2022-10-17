import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';

part 'visit_partners_data_response.g.dart';

/// Created by Dev 2136 on 01/06/2022
/// Modified by Dev 2136 on 01/06/2022
/// Purpose : This is a visit partners data response class which is used in
/// visit partners data api call.

@JsonSerializable()
@Entity(tableName: "VisitPartner")
class VisitPartnersDataResponse {
  VisitPartnersDataResponse({
    required this.id,
    required this.name,
    this.createdOn,
    this.modifiedOn
  });

  factory VisitPartnersDataResponse.fromJson(Map<String, dynamic> json) =>
      _$VisitPartnersDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VisitPartnersDataResponseToJson(this);

  @primaryKey
  @ColumnInfo(name: "id")
  int id;

  @ColumnInfo(name: "name")
  String name;

  @ColumnInfo(name: "created_on")
  String? createdOn;

  @ColumnInfo(name: "modified_on")
  String? modifiedOn;

  @override
  String toString() => '$id $name';
}
