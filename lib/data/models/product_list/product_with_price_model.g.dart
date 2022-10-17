// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_with_price_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductWithPriceModel _$ProductWithPriceModelFromJson(
        Map<String, dynamic> json) =>
    ProductWithPriceModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      product_code: json['product_code'] as String?,
      group_id: json['group_id'] as int?,
      sub_group_id: json['sub_group_id'] as int?,
      category_id: json['category_id'] as int?,
      sub_category_id: json['sub_category_id'] as int?,
      scheme_id: json['scheme_id'] as int?,
      hsn: json['hsn'] as String?,
      cgst: (json['cgst'] as num?)?.toDouble(),
      sgst: (json['sgst'] as num?)?.toDouble(),
      igst: (json['igst'] as num?)?.toDouble(),
      uom_1: json['uom_1'] as int?,
      uom_2: json['uom_2'] as int?,
      uom_3: json['uom_3'] as int?,
      uom_4: json['uom_4'] as int?,
      uom_2_value: json['uom_2_value'] as int?,
      uom_3_value: json['uom_3_value'] as int?,
      is_sellable_uom1: json['is_sellable_uom1'] as int?,
      is_sellable_uom2: json['is_sellable_uom2'] as int?,
      product_id: json['product_id'] as int?,
      pricing_type: json['pricing_type'] as int?,
      mrp: (json['mrp'] as num?)?.toDouble(),
      min_base_price: (json['min_base_price'] as num?)?.toDouble(),
      max_base_price: (json['max_base_price'] as num?)?.toDouble(),
      state_id: json['state_id'] as int?,
      distributor_id: json['distributor_id'] as int?,
      distributor_type: json['distributor_type'] as int?,
      customer_id: json['customer_id'] as int?,
      customer_type: json['customer_type'] as int?,
      customer_category: json['customer_category'] as int?,
      availableStock: (json['availableStock'] as num?)?.toDouble(),
      selected_scheme_id: json['selected_scheme_id'] as int?,
      scheme_name: json['scheme_name'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      discount: (json['discount'] as num?)?.toDouble(),
      entered_price: (json['entered_price'] as num?)?.toDouble(),
      selected_uom_id: json['selected_uom_id'] as int?,
      selected_uom: json['selected_uom'] as String?,
      free_product_name: json['free_product_name'] as String?,
      free_product_quantity: json['free_product_quantity'] as int?,
      free_product_uom: json['free_product_uom'] as int?,
      scheme_discount: (json['scheme_discount'] as num?)?.toDouble(),
      free_product_id: json['free_product_id'] as int?,
      free_product_hsn: json['free_product_hsn'] as String?,
      free_product_uom_name: json['free_product_uom_name'] as String?,
    )
      ..stockiest_base_price =
          (json['stockiest_base_price'] as num?)?.toDouble()
      ..distributor_base_price =
          (json['distributor_base_price'] as num?)?.toDouble()
      ..secondary_base_price =
          (json['secondary_base_price'] as num?)?.toDouble()
      ..retail_base_price = (json['retail_base_price'] as num?)?.toDouble()
      ..subscriber_id = json['subscriber_id'] as int?;

Map<String, dynamic> _$ProductWithPriceModelToJson(
        ProductWithPriceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'product_code': instance.product_code,
      'group_id': instance.group_id,
      'sub_group_id': instance.sub_group_id,
      'category_id': instance.category_id,
      'sub_category_id': instance.sub_category_id,
      'scheme_id': instance.scheme_id,
      'hsn': instance.hsn,
      'cgst': instance.cgst,
      'sgst': instance.sgst,
      'igst': instance.igst,
      'uom_1': instance.uom_1,
      'uom_2': instance.uom_2,
      'uom_3': instance.uom_3,
      'uom_4': instance.uom_4,
      'uom_2_value': instance.uom_2_value,
      'uom_3_value': instance.uom_3_value,
      'is_sellable_uom1': instance.is_sellable_uom1,
      'is_sellable_uom2': instance.is_sellable_uom2,
      'stockiest_base_price': instance.stockiest_base_price,
      'distributor_base_price': instance.distributor_base_price,
      'secondary_base_price': instance.secondary_base_price,
      'retail_base_price': instance.retail_base_price,
      'subscriber_id': instance.subscriber_id,
      'product_id': instance.product_id,
      'pricing_type': instance.pricing_type,
      'mrp': instance.mrp,
      'min_base_price': instance.min_base_price,
      'max_base_price': instance.max_base_price,
      'state_id': instance.state_id,
      'distributor_id': instance.distributor_id,
      'distributor_type': instance.distributor_type,
      'customer_id': instance.customer_id,
      'customer_type': instance.customer_type,
      'customer_category': instance.customer_category,
      'availableStock': instance.availableStock,
      'selected_scheme_id': instance.selected_scheme_id,
      'scheme_name': instance.scheme_name,
      'quantity': instance.quantity,
      'discount': instance.discount,
      'entered_price': instance.entered_price,
      'selected_uom_id': instance.selected_uom_id,
      'selected_uom': instance.selected_uom,
      'free_product_name': instance.free_product_name,
      'free_product_quantity': instance.free_product_quantity,
      'free_product_uom': instance.free_product_uom,
      'free_product_uom_name': instance.free_product_uom_name,
      'free_product_hsn': instance.free_product_hsn,
      'free_product_id': instance.free_product_id,
      'scheme_discount': instance.scheme_discount,
    };
