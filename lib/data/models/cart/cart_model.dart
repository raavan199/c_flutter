
import 'package:floor/floor.dart';

//@Entity(tableName: "cart")
class CartModel{
  CartModel({
    required this.product_id,
    required this.product_name,
    required this.price,
    required this.amount,
    required this.payable_amount,
    required this.discount,
    required this.qty,
    required this.scheme_id,
    required this.scheme_name,
    required this.uom_id,
    required this.uom_name,
});

  @primaryKey
  @ColumnInfo(name: "product_id")
  int? product_id;

  @ColumnInfo(name: "product_name")
  String? product_name;

  @ColumnInfo(name: "price")
  int? price;

  @ColumnInfo(name: "amount")
  int? amount;

  @ColumnInfo(name: "payable_amount")
  int? payable_amount;

  @ColumnInfo(name: "discount")
  int? discount;

  @ColumnInfo(name: "qty")
  int? qty;

  @ColumnInfo(name: "scheme_id")
  int? scheme_id;

  @ColumnInfo(name: "scheme_name")
  String? scheme_name;

  @ColumnInfo(name: "uom_id")
  int? uom_id;

  @ColumnInfo(name: "uom_name")
  String? uom_name;

}