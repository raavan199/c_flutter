import 'package:json_annotation/json_annotation.dart';
import 'package:floor/floor.dart';

part 'product_with_price_model.g.dart';

/// Created by Dev 2136 on 01/13/2022
/// Modified by Dev 2136 on 01/13/2022
/// Purpose : to store product with price here

@JsonSerializable()
@Entity(tableName: "cart")
class ProductWithPriceModel {
  ProductWithPriceModel(
      {this.id,
      this.name,
      this.product_code,
      this.group_id,
      this.sub_group_id,
      this.category_id,
      this.sub_category_id,
      this.scheme_id,
      this.hsn,
      this.cgst,
      this.sgst,
      this.igst,
      this.uom_1,
      this.uom_2,
      this.uom_3,
      this.uom_4,
      this.uom_2_value,
      this.uom_3_value,
      this.is_sellable_uom1,
      this.is_sellable_uom2,
      // product price
      this.product_id,
      this.pricing_type,
      this.mrp,
      this.min_base_price,
      this.max_base_price,
      this.state_id,
      this.distributor_id,
      this.distributor_type,
      this.customer_id,
      this.customer_type,
      this.customer_category,
      this.availableStock,
      this.selected_scheme_id,
      this.scheme_name,
      this.quantity,
      this.discount,
      this.entered_price,
      this.selected_uom_id,
      this.selected_uom,
      this.free_product_name,
      this.free_product_quantity,
      this.free_product_uom,
      this.scheme_discount,
      this.free_product_id,
      this.free_product_hsn,this.free_product_uom_name});

  factory ProductWithPriceModel.fromJsonForRowQuery(
      Map<String, dynamic> json) =>
      ProductWithPriceModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        quantity: json['order_quantity'] as double?,
        selected_uom: json['selected_uom'] as String?,
        entered_price: json['base_price'] as double?,
        max_base_price: json['base_price'] as double?,
        igst: json['igst'] as double?,
        scheme_name: json['scheme_name'] as String?,
        discount: json['discount'] as double?,
      );

  factory ProductWithPriceModel.fromJson(Map<String, dynamic> json) =>
      _$ProductWithPriceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductWithPriceModelToJson(this);

  @primaryKey
  @ColumnInfo(name: "id")
  int? id;

  @ColumnInfo(name: "name")
  String? name;

  @ColumnInfo(name: "product_code")
  String? product_code;

  @ColumnInfo(name: "group_id")
  int? group_id;

  @ColumnInfo(name: "sub_group_id")
  int? sub_group_id;

  @ColumnInfo(name: "category_id")
  int? category_id;

  @ColumnInfo(name: "sub_category_id")
  int? sub_category_id;

  @ColumnInfo(name: "scheme_id")
  int? scheme_id;

  @ColumnInfo(name: "hsn")
  String? hsn;

  @ColumnInfo(name: "cgst")
  double? cgst;

  @ColumnInfo(name: "sgst")
  double? sgst;

  @ColumnInfo(name: "igst")
  double? igst;

  @ColumnInfo(name: "uom_1")
  int? uom_1;

  @ColumnInfo(name: "uom_2")
  int? uom_2;

  @ColumnInfo(name: "uom_3")
  int? uom_3;

  @ColumnInfo(name: "uom_4")
  int? uom_4;

  @ColumnInfo(name: "uom_2_value")
  int? uom_2_value;

  @ColumnInfo(name: "uom_3_value")
  int? uom_3_value;

  @ColumnInfo(name: "is_sellable_uom1")
  int? is_sellable_uom1;

  @ColumnInfo(name: "is_sellable_uom2")
  int? is_sellable_uom2;

  @ColumnInfo(name: "stockiest_base_price")
  double? stockiest_base_price;

  @ColumnInfo(name: "distributor_base_price")
  double? distributor_base_price;

  @ColumnInfo(name: "secondary_base_price")
  double? secondary_base_price;

  @ColumnInfo(name: "retail_base_price")
  double? retail_base_price;

  @ColumnInfo(name: "subscriber_id")
  int? subscriber_id;

  //product price data

  @ColumnInfo(name: "product_id")
  int? product_id;

  @ColumnInfo(name: "pricing_type")
  int? pricing_type;

  @ColumnInfo(name: "mrp")
  double? mrp;

  @ColumnInfo(name: "min_base_price")
  double? min_base_price;

  @ColumnInfo(name: "max_base_price")
  double? max_base_price;

  @ColumnInfo(name: "state_id")
  int? state_id;

  @ColumnInfo(name: "distributor_id")
  int? distributor_id;

  @ColumnInfo(name: "distributor_type")
  int? distributor_type;

  @ColumnInfo(name: "customer_id")
  int? customer_id;

  @ColumnInfo(name: "customer_type")
  int? customer_type;

  @ColumnInfo(name: "customer_category")
  int? customer_category;

  double? availableStock;

  @ColumnInfo(name: "selected_scheme_id")
  int? selected_scheme_id;

  @ColumnInfo(name: "scheme_name")
  String? scheme_name;

  @ColumnInfo(name: "quantity")
  double? quantity;

  @ColumnInfo(name: "discount")
  double? discount;

  @ColumnInfo(name: "entered_price")
  double? entered_price;

  @ColumnInfo(name: "selected_uom_id")
  int? selected_uom_id;

  @ColumnInfo(name: "selected_uom")
  String? selected_uom;

  @ColumnInfo(name: "free_product_name")
  String? free_product_name;

  @ColumnInfo(name: "free_product_quantity")
  int? free_product_quantity;

  @ColumnInfo(name: "free_product_uom")
  int? free_product_uom;

  @ColumnInfo(name: "free_product_uom_name")
  String? free_product_uom_name;
  @ColumnInfo(name: "free_product_hsn")
  String? free_product_hsn;

  @ColumnInfo(name: "free_product_id")
  int? free_product_id;

  @ColumnInfo(name: "scheme_discount")
  double? scheme_discount;
}
