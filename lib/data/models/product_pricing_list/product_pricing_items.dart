
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';


part 'product_pricing_items.g.dart';

/// Created by Dev 1051 on 1/7/2022


@JsonSerializable()
@Entity(tableName: "productPricing")
class ProductPricingItems{

  @ColumnInfo(name: "subscriber_id")
  @JsonKey(name: "subscriberId")
  int? subscriberId;

  @ColumnInfo(name: "product_id")
  @JsonKey(name: "productId")
  int? productId;

  @ColumnInfo(name: "pricing_type")
  @JsonKey(name: "pricingType")
  int? pricingType;

  @ColumnInfo(name: "hsn")
  @JsonKey(name: "hsn")
  String? hsn;

  @ColumnInfo(name: "cgst")
  @JsonKey(name: "cgst")
  double? cgst;

  @ColumnInfo(name: "sgst")
  @JsonKey(name: "sgst")
  double? sgst;

  @ColumnInfo(name: "igst")
  @JsonKey(name: "igst")
  double? igst;

  @JsonKey(name: "mrp")
  @ColumnInfo(name: "mrp")
  double? mrp;

  @JsonKey(name: "minBasePrice")
  @ColumnInfo(name: "min_base_price")
  double? minBasePrice;

  @JsonKey(name: "maxBasePrice")
  @ColumnInfo(name: "max_base_price")
  double? maxBasePrice;

  @JsonKey(name: "stateId")
  @ColumnInfo(name: "state_id")
  int? stateId;

  @JsonKey(name: "distributorId")
  @ColumnInfo(name: "distributor_id")
  int? distributorId;

  @JsonKey(name: "distributorType")
  @ColumnInfo(name: "distributor_type")
  int? distributorType;

  @JsonKey(name: "customerId")
  @ColumnInfo(name: "customer_id")
  int? customerId;

  @JsonKey(name: "customerType")
  @ColumnInfo(name: "customer_type")
  int? customerType;

  @ColumnInfo(name: "customer_category")
  @JsonKey(name: "customerCategory")
  int? customerCategory;

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


  @primaryKey
  @ColumnInfo(name: "id")
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "uoM")
  @ColumnInfo(name: "uoM")
  int? uoM;


  ProductPricingItems({
      this.subscriberId, this.productId, this.pricingType,
      this.hsn,this.sgst, this.igst, this.cgst, this.id,
      this.mrp, this.minBasePrice, this.maxBasePrice,
      this.stateId, this.distributorId, this.distributorType, this.customerId,
      this.customerType,this.customerCategory, this.createdBy, this.createdOn,
      this.modifiedBy, this.modifiedOn,this.uoM});

  factory ProductPricingItems.fromJson(Map<String,dynamic> json)=>
      _$ProductPricingItemsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductPricingItemsToJson(this);


}