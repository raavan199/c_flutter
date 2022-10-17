import '../exports/resources.dart';

/// Created by Dev 2196 on 7/14/2021
/// Modified by Dev 2196 on 7/14/2021
/// Purpose : mixin contains validation methods

mixin ValidationMixin {
  static const String _emailPattern =
      "[a-zA-Z0-9\\+\\._%\\-\\+]{1,256}@[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}(\\.[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25})+";

  ///common validation for required field
  String requiredFieldValidation(String value) {
    if (value.isEmpty) {
      return AppStrings.emptyValidation;
    }
    return "";
  }
  String requiredQuantityFieldValidation(String value) {
    if (value.isEmpty) {
      return AppStrings.quantityValidation;
    }
    return "";
  }

  String requiredFieldWithPriceValidation(
      String value, double minPrice, double maxPrice) {
    if (value.isEmpty) {
      return AppStrings.priceRangeValidation;
    } else {
      var price = double.parse(value);
      if (price < minPrice || price > maxPrice) {
        return AppStrings.priceRangeValidation;
      }
    }
    return "";
  }

  String requiredFieldWithDiscountValidation(
      String value, double minPrice, double maxPrice) {
    if (value.isEmpty) {
      return "";
    } else {
      var price = double.parse(value);
      if ((maxPrice - minPrice) < price) {
        return AppStrings.discountValidation;
      }
    }
    return "";
  }

  String pinFieldValidation(String value) {
    if (value.isEmpty) {
      return AppStrings.pinEmptyValidation;
    } else if (value.length != 6) {
      return AppStrings.pinValidation;
    }
    return "";
  }

  String phoneFieldValidation(String value) {
    if (value.isEmpty) {
      return AppStrings.phoneEmptyValidation;
    } else if (value.length != 10) {
      return AppStrings.phoneValidation;
    }
    return "";
  }
  String? collectionAmountFieldValidation(String value,double pendingPaymentValue) {
    if (value.isEmpty) {
      return AppStrings.amountValidation;
    } else if (double.tryParse(value)! > pendingPaymentValue) {
      return AppStrings.amountValidation;
    }
    return null;
  }
  String gstFieldValidation(String value) {
    if (value.isEmpty) {
      return AppStrings.emptyValidation;
    } else if (value.length != 15) {
      return AppStrings.gstValidation;
    }
    return "";
  }

  /// Created by Dev 1051 on 7/19/2021
  /// Modified by Dev 1051 on 7/19/2021
  /// Purpose : Added to validate email id.
  String validateEmail(String value) {
    final regExp = RegExp(_emailPattern);
    if (value.isEmpty) {
      return AppStrings.emailRequired;
    } else if (!regExp.hasMatch(value)) {
      return AppStrings.invalidEmail;
    } else {
      return "";
    }
  }

  /// Created by Dev 1051 on 7/19/2021
  /// Modified by Dev 1051 on 7/19/2021
  /// Purpose : Added to validate email id.
  String? validateEmailAllowBlank(String value) {
    if(value.isEmpty){
      return null;
    }
    final regExp = RegExp(_emailPattern);
    if (!regExp.hasMatch(value)) {
      return AppStrings.invalidEmail;
    } else {
      return null;
    }
  }
}
