import 'package:json_annotation/json_annotation.dart';

part 'product_schema_request.g.dart';

/// Created by Dev 1051 on 1/7/2022
/// Purpose : This is a product schema register request class which is used
/// in product schema register list api call.
@JsonSerializable()
class ProductSchemaRequset {


  @JsonKey(name: "fromTimeStamp")
  String? fromTimeStamp;




  factory ProductSchemaRequset.fromJson(Map<String, dynamic> json) =>
      _$ProductSchemaRequsetFromJson(json);
  Map<String, dynamic> toJson() => _$ProductSchemaRequsetToJson(this);

  ProductSchemaRequset({this.fromTimeStamp});
}
