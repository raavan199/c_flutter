

import 'package:json_annotation/json_annotation.dart';

import '../../../exports/models.dart';

part 'product_schema_response.g.dart';

@JsonSerializable()
class ProductSchemaResponse{

  @JsonKey(name: "data")
  List<ProductSchemaData>? data;

  @JsonKey(name:"succeeded")
  bool? succeeded;

  @JsonKey(name:"message")
  String? message;

  @JsonKey(name:"errors")
  String? errors;

  factory ProductSchemaResponse.fromJson(Map<String,dynamic> json)=>
      _$ProductSchemaResponseFromJson(json);
  Map<String,dynamic> toJson()=>_$ProductSchemaResponseToJson(this);


  ProductSchemaResponse(
      this.data, this.succeeded, this.message, this.errors);
}