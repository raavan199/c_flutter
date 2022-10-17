import 'package:json_annotation/json_annotation.dart';


part 'base_response.g.dart';

@JsonSerializable(genericArgumentFactories: true, fieldRename: FieldRename.snake, nullable: true)
class BaseResponse<T> {
  BaseResponse({required this.data, this.succeeded, this.message, this.errors});

  @JsonKey(name: "data")
  T data;

  @JsonKey(name: "succeeded")
  bool? succeeded;

  @JsonKey(name: "message")
  String? message;

  @JsonKey(name: "errors")
  String? errors;

  @JsonKey(ignore: true)
  String? lastSyncTimeStamp;


  factory BaseResponse.fromJson(
      Map<String, dynamic> json,
      T Function(Object? json) fromJsonT,
      ) =>
      _$BaseResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$BaseResponseToJson(this, toJsonT);
}