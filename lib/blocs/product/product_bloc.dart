import 'package:equatable/equatable.dart';

import '../../data/models/AvailableStock/available_stock_request.dart';
import '../../data/models/customer/customer_data_items_response.dart';
import '../../data/models/product_list/product_list_data_items_response.dart';
import '../../data/models/product_list/product_with_price_model.dart';
import '../../data/models/product_pricing_list/product_pricing_items.dart';
import '../../database/db_module.dart';
import '../../resources/app_strings.dart';
import '../../ui/screens/add_new_order/product_price_calculation.dart';
import '../../utilities/logger.dart';
import '../base/base_bloc.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends BaseBloc<ProductEvent> {
  ProductBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;
  static String tag = "ProductBloc";

  void _onEvent() {
    on<GetProductList>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.productDao
          .getAllData()
          .then((productValue) async {
        await dbModule.dbInstance.productPricingDao
            .getAllData()
            .then((productPriceValue) {
          var finalList = createDataForProductPricing(
              productValue, productPriceValue, event.outletInfo);
          emit(ProductSuccessState(data: finalList));
          emit(const LoadingState(isLoading: false));
        });
      }).catchError((e) {
        emit(const ProductFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    }); /*
    on<GetProductList>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(getJointQueryToGetTheProductAndPriceList(
              getFilterQuery(event),
              '${event.outletInfo.id!}',
              '0',
              '${event.outletInfo.customerType!}',
              '${event.outletInfo.customerCategory!}'))
          .then((value) {
        emit(ProductSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const ProductFailedState(msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });*/

    ///on GetAvailableStock event
    on<GetAvailableStock>((event, emit) async {
      emit(const LoadingState());
      await apiService.client!
          .getAvailableStock(AvailableStockRequest(
        warehouseId: event.warehouseId,
        productId: event.productId,
        uoM: event.uoM,
      ))
          .then((value) {
        emit(StockSuccessState(data: value, productId: event.productId));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(StockFailedState(msg: apiService.getError(e)));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on GetAvailableStock event
    on<GetProductTrendList>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(queryToGetTheProductTrends(event.locationId))
          .then((value) {
        emit(ProductTrendsSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(const ProductTrendsFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    ///on GetAvailableStock event
    on<DeleteAllProductsFromCart>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.cartDao.deleteAllData()
          .then((value) {
        emit(DeleteCartItemsSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        Logger.e(tag, e);
        emit(const DeleteCartItemsFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    //For get number of product in cart so, we can show count on cart icon badge
    on<GetProductListFromCart>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.cartDao.getAllData().then((value) {
        emit(ProductListFromCartSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const ProductListFromCartFailedState(
            msg: AppStrings.msgDataNotAvailable));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String getJointQueryToGetTheProductAndPriceList(
      String filterQuery,
      String customerId,
      String stateId,
      String customerType,
      String customerCategory) {
    var query = 'SELECT * from productList as PL INNER JOIN( '
        'select * from (SELECT * from productPricing WHERE product_id in($filterQuery) AND customer_id = $customerId'
        ' UNION '
        'SELECT * from productPricing WHERE product_id in($filterQuery) AND state_id = $stateId'
        ' UNION '
        'SELECT * from productPricing WHERE product_id in($filterQuery) AND customer_type = $customerType'
        ' UNION '
        'SELECT * from productPricing WHERE product_id in($filterQuery) AND customer_category = $customerCategory'
        ' UNION '
        'SELECT * from productPricing WHERE product_id in($filterQuery) AND customer_id =0 AND state_id= 0 AND customer_type= 0 AND customer_category=0'
        ') a group by a.product_id '
        ')as PP ON PL.id=pp.product_id';
    return query;
  }

  String getFilterQuery(GetProductList event) {
    var basicQuery = "SELECT id FROM productList";
    Map<String, int?> result = event.result;
    var conditions = "";

    if (result.containsKey('groupId') && result['groupId'] != null) {
      conditions = '$conditions group_id = ${result['groupId']}';
    }
    if (result.containsKey('subGroupId') && result['subGroupId'] != null) {
      if (conditions.isNotEmpty) {
        conditions = '$conditions AND ';
      }
      conditions = '$conditions sub_group_id = ${result['subGroupId']}';
    }
    if (result.containsKey('catId') && result['catId'] != null) {
      if (conditions.isNotEmpty) {
        conditions = '$conditions AND ';
      }
      conditions = '$conditions category_id = ${result['catId']}';
    }
    if (result.containsKey('subCatId') && result['subCatId'] != null) {
      if (conditions.isNotEmpty) {
        conditions = '$conditions AND ';
      }
      conditions = '$conditions sub_category_id = ${result['subCatId']}';
    }
    if (conditions.isNotEmpty) {
      basicQuery = "$basicQuery WHERE $conditions";
    }
    return basicQuery;
  }

  String queryToGetTheProductTrends(int locationId) {
    return "SELECT pt.* FROM ProductTrends as pt "
        "LEFT JOIN ProductTrendsLocation as ptl "
        "on pt.id= ptl.product_trend_id "
        "WHERE (ptl.location_id = ${locationId} OR ptl.location_id ISNULL) "
        "AND ptl.isActive = 1 "
        "AND pt.isActive = 1 "
        "AND ((strftime('%Y-%m-%dT%H:%M:%S', pt.startDate)<strftime('%Y-%m-%dT%H:%M:%S', 'now') "
        "AND strftime('%Y-%m-%dT%H:%M:%S', pt.endDate)>strftime('%Y-%m-%dT%H:%M:%S', 'now')) "
        "OR ( pt.startDate is null AND  pt.endDate is null))";
  }

  List<ProductWithPriceModel> createDataForProductPricing(
      List<ProductListDataItemsResponse> productValue,
      List<ProductPricingItems> productPriceValue,
      CustomerDataItemsResponse outletInfo) {
    final productWithPriceList = <ProductWithPriceModel>[];
    final selectedAddress = outletInfo.customerAddress
        ?.firstWhere((element) => element.isDefaultAddress == true);
    for (final productItem in productValue) {
      var data = ProductPriceCalculation.calculateProductPrice(
          productItem.id!, productPriceValue, outletInfo, selectedAddress!,productItem.uoM1!);
      if (data != null) {
        productWithPriceList.add(ProductPriceCalculation.margeProductWithProductPriceModel(productItem, data));
      }
    }
    return productWithPriceList;
  }
}
