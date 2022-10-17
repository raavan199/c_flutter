import 'package:cygneto/exports/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'customer_image_data_resposne.g.dart';

/// Created by Dev 2183 on 02/01/2022
/// Modified by Dev 2183 on 02/01/2022
/// Purpose : This is a customer Image data response class which is used
/// to get customer and Image Folder data mapping response.

@JsonSerializable()
class CustomerImageDataResponse {
  int? pageIndex;
  int? pageSize;
  int? totalCount;
  int? totalPages;
  bool? hasPreviousPage;
  bool? hasNextPage;
  List<CustomerImageItemResponse>? items;

  factory CustomerImageDataResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerImageDataResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomerImageDataResponseToJson(this);

  CustomerImageDataResponse(
      {this.pageIndex,
        this.pageSize,
        this.totalCount,
        this.totalPages,
        this.hasPreviousPage,
        this.hasNextPage,
        this.items});

}