
import 'package:json_annotation/json_annotation.dart';


part 'base_pagination_response.g.dart';
@JsonSerializable(genericArgumentFactories: true, fieldRename: FieldRename.snake, nullable: true)
class BasePaginationResponse<T> {
  BasePaginationResponse(
      {this.pageIndex,
      this.pageSize,
      this.totalCount,
      this.hasPreviousPage,
      this.hasNextPage, this.totalPages,
      required this.items});
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
  T items;



  factory BasePaginationResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$BasePaginationResponseFromJson(json, fromJsonT);
  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BasePaginationResponseToJson(this, toJsonT);
}

