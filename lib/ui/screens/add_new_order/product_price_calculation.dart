import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../exports/models.dart';

mixin ProductPriceCalculation {
  static ProductPricingItems? calculateProductPrice(
      int productItem,
      List<ProductPricingItems> productPriceValue,
      CustomerDataItemsResponse outletInfo,
      CustomerAddressResponse selectedAddress,
      int uomId) {
    //State + CId + CType + CCat + ProductId + UOM1
    final firstFilter = productPriceValue.firstWhereOrNull((element) =>
        element.stateId == selectedAddress.stateId &&
        element.customerId == outletInfo.id &&
        element.customerType == outletInfo.customerType &&
        element.customerCategory == outletInfo.customerCategory &&
        element.productId == productItem &&
        element.uoM == uomId);

    if (firstFilter != null) {
      return firstFilter;
    }

    //State + CType + CCat + ProductId + UOM1
    final secondFilter = productPriceValue.firstWhereOrNull((element) =>
        element.stateId == selectedAddress.stateId &&
        element.customerType == outletInfo.customerType &&
        element.customerCategory == outletInfo.customerCategory &&
        element.productId == productItem &&
        element.uoM == uomId);

    if (secondFilter != null) {
      return secondFilter;
    }

    // State + CCat + ProductId + UOM1
    final thirdFilter = productPriceValue.firstWhereOrNull((element) =>
        element.stateId == selectedAddress.stateId &&
        element.customerCategory == outletInfo.customerCategory &&
        element.productId == productItem &&
        element.uoM == uomId);

    if (thirdFilter != null) {
      return thirdFilter;
    }

    // State + CType + ProductId + UOM1
    final fourthFilter = productPriceValue.firstWhereOrNull((element) =>
        element.stateId == selectedAddress.stateId &&
        element.customerType == outletInfo.customerType &&
        element.productId == productItem &&
        element.uoM == uomId);
    if (fourthFilter != null) {
      return fourthFilter;
    }

//general for distributor and retailer
    //State + CId + ProductId + UOM1
    final fifthFilter = productPriceValue.firstWhereOrNull((element) =>
        element.stateId == selectedAddress.stateId &&
        element.customerId == outletInfo.id &&
        element.productId == productItem &&
        element.uoM == uomId);
    if (fifthFilter != null) {
      return fifthFilter;
    }

    //State + ProductId + UOM1
    final sixthFilter = productPriceValue.firstWhereOrNull((element) =>
        element.stateId == selectedAddress.stateId &&
        element.productId == productItem &&
        element.uoM == uomId);

    if (sixthFilter != null) {
      return sixthFilter;
    }
    //ProductId + UOM1
    final seventhFilter = productPriceValue.firstWhereOrNull(
        (element) => element.productId == productItem && element.uoM == uomId);

    if (seventhFilter != null) {
      return seventhFilter;
    }
  }

  static ProductWithPriceModel margeProductWithProductPriceModel(
      ProductListDataItemsResponse productItem,
      ProductPricingItems productPricingItems) {
    final item = ProductWithPriceModel(
        id: productItem.id,
        name: productItem.name,
        product_code: productItem.productCode,
        group_id: productItem.groupId,
        sub_group_id: productItem.subGroupId,
        category_id: productItem.categoryId,
        sub_category_id: productItem.subCategoryId,
        hsn: productPricingItems.hsn,
        cgst: productPricingItems.cgst,
        sgst: productPricingItems.sgst,
        igst: productPricingItems.igst,
        uom_1: productItem.uoM1,
        uom_2: productItem.uoM2,
        uom_3: productItem.uoM3,
        uom_4: productItem.uoM4,
        uom_2_value: productItem.uoM2Value,
        uom_3_value: productItem.uoM3Value,
        is_sellable_uom1: productItem.isSellableUoM1 == true ? 1 : 0,
        is_sellable_uom2: productItem.isSellableUoM2 == true ? 1 : 0,
        pricing_type: productPricingItems.pricingType,
        mrp: productPricingItems.mrp,
        min_base_price: productPricingItems.minBasePrice,
        max_base_price: productPricingItems.maxBasePrice,
        state_id: productPricingItems.stateId,
        distributor_id: productPricingItems.distributorId,
        distributor_type: productPricingItems.distributorType,
        customer_id: productPricingItems.customerId,
        product_id: productItem.id,
        customer_category: productPricingItems.customerCategory);
    return item;
  }

  static double calculateTotalPrice(ProductWithPriceModel priceModel) =>
      (priceModel.entered_price ?? 0) * (priceModel.quantity ?? 0);

  static double calculateTotalDiscount(ProductWithPriceModel priceModel) {
    var discount = 0.0;

    discount = calculateAdditionalDiscount(priceModel);
    if (priceModel.selected_scheme_id != null &&
        priceModel.scheme_discount != null) {
      var priceBeforeSchemeDiscount =
          calculateTotalPrice(priceModel) - discount;

      priceBeforeSchemeDiscount =
          (priceBeforeSchemeDiscount * priceModel.scheme_discount!) / 100;

      discount = discount + priceBeforeSchemeDiscount;
    }
    return discount;
  }

  static double calculateAdditionalDiscount(ProductWithPriceModel priceModel) {
    if (priceModel.discount != null && priceModel.discount != 0) {
      /*double discountInAmount = 0.0;
      discountInAmount =
          (priceModel.max_base_price! * (priceModel.discount)!.toDouble()) /
              100;
      discount = (priceModel.quantity ?? 0).toDouble() * discountInAmount;*/
      return calculateDiscountValue(
          priceModel.max_base_price!,
          (priceModel.discount)!.toDouble(),
          (priceModel.quantity ?? 0).toDouble());
    } else {
      return 0.0;
    }
  }

  static double calculateDiscountValue(
      double price, double discountInPer, double quantity) {
    var discountInAmount = 0.0;
    discountInAmount = (price * discountInPer) / 100;
    return quantity * discountInAmount;
  }

  static double calculateTotalTax(ProductWithPriceModel priceModel) =>
      calculateTotalTaxWithPrice(
          priceModel.entered_price ?? 0,
          priceModel.quantity ?? 0.0,
          priceModel.igst ?? 0,
          ProductPriceCalculation.calculateTotalDiscount(priceModel));

  static double calculateTotalTaxWithPrice(
      double price, double quantity, double gst, double discount) {
    if (gst == 0) {
      gst = 1.0;
    }
    var taxApplicableOnAmount = (price * quantity) - discount;
    return double.parse(
        ((taxApplicableOnAmount * gst) / 100).toStringAsFixed(2));
  }

  static double calculatePayableAmount(
          double totalAmount, double totalDiscount, double totalTax) =>
      totalAmount + totalTax - totalDiscount;

  static double calculatePriceOfProduct(double totalAmount, double quantity) {
    if (totalAmount == 0 || quantity == 0) {
      return 0.0;
    }
    return totalAmount * quantity;
  }
}
