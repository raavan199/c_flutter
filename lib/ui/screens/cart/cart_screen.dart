import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/cart/cart_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../data/models/order_item/order_item_data_response.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../../../services/shared_preference_service.dart';
import '../../widgets/custom_dialog.dart';
import '../Cart/cart_list_view.dart';
import '../add_new_order/product_price_calculation.dart';
import '../base/base_screen.dart';
import '../outlet_info/outlet_info_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    required this.outletInfo,
    this.warehouseId,
    this.distributorId,
    this.isNavigateFromProductScreen,
    Key? key,
  }) : super(key: key);

  final CustomerDataItemsResponse? outletInfo;
  final int? warehouseId;
  final int? distributorId;

  final bool? isNavigateFromProductScreen;

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> with UtilityMixin {
  late CartBloc _bloc;
  int userId = 0;
  int visitId = 0;
  List<ProductWithPriceModel> _productList = [];
  List<OrderItemDataResponse> orderItemList = [];
  List<OrderRecordDataResponse> unSyncOrderList = [];
  List<SchemeListDataResponse> schemeList = [];
  String orderDate = '';
  String? lastSyncDate;

  double totalBaseAmount = 0.0;
  double schemeDiscount = 0.0;
  double totalTax = 0.0;
  double totalPayable = 0.0;
  double totalDiscount = 0.0;
  double totalProductDiscount = 0.0;
  SchemeListDataResponse? _selectedScheme;
  ProductWithPriceModel? freeProductDetails;

  int orderType = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BaseScreen<CartBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(const GetProductListCart());
      },
      builder: (context, bloc, child) => BlocListener<CartBloc, BaseState>(
            listener: (context, state) {
              if (state is GetProductFromCartSuccessState ||
                  state is GetProductFromCartFailedState) {
                _productManageState(state);
              } else if (state is GetProductFromCartFailedState) {
              } else if (state is InsertOrderRecordIntoDBSuccessState) {
                print("InsertOrderRecordIntoDBSuccessState");
                saveOrderItem(state.data, orderDate);
              } else if (state is InsertOrderRecordIntoDBFailedState) {
                print("InsertOrderRecordIntoDBFailedState");
              } else if (state is SaveOrderItemIntoDBSuccessState) {
                print("SaveOrderItemIntoDBSuccessState");
                _forDeleteAllItemFromCart(false);
                ApiService().checkInternet().then((internet) {
                  if (internet) {
                    _bloc.add(const GetUnSyncOrderFromDB());
                  } else {
                    _showAlertForSuccessfulOrder();
                  }
                });
              } else if (state is SaveOrderItemIntoDBFailedState) {
                print("SaveOrderItemIntoDBFailedState");
              } else if (state is GetUnSyncOrderSuccessState) {
                /*  unSyncOrderRecordList = state.data;
                _bloc.add(const GetUnSyncOrderItem());
                print("GetUnSyncOrderSuccessState");*/
              } else if (state is GetUnSyncOrderFailedState) {
                print("GetUnSyncOrderFailedState");
              } else if (state is GetUnSyncOrderItemSuccessState) {
                unSyncOrderList = state.data;
                callPlaceOrderAPI(0);
                print("GetUnSyncOrderItemSuccessState");
              } else if (state is GetUnSyncOrderItemFailedState) {
                print("GetUnSyncOrderItemFailedState");
              } else if (state is PlaceOrderAPICallSuccessState) {
                if (state.index + 1 < unSyncOrderList.length) {
                  callPlaceOrderAPI(state.index + 1);
                } else {
                  _bloc.add(const DeleteUnSyncOrder());
                }
                print("PlaceOrderAPICallSuccessState");
              } else if (state is PlaceOrderAPICallFailState) {
                navigationPushReplacement(
                    context,
                    OutletInfoScreen(
                      outletInfo: widget.outletInfo,
                    ));
                print("PlaceOrderAPICallFailState");
              } else if (state is DeleteUnSyncOrderSuccessState) {
                _bloc.add(const GetLastTimeStampFromDb());
                print("PlaceOrderAPICallSuccessState");
              } else if (state is DeleteUnSyncOrderFailState) {
                print("PlaceOrderAPICallFailState");
              } else if (state is GetLastSyncDateFromDBSuccessState) {
                lastSyncDate = state.data;
                print("GetLastSyncDateFromDBSuccessState");
                _bloc.add(CallOrderRecordApi(fromTimeStamp: state.data));
              } else if (state is GetLastSyncDateFromDBFailState) {
              } else if (state is OrderRecordSuccessState) {
                print("OrderRecordSuccessState");
                _bloc.add(CallOrderItemApi(fromTimeStamp: lastSyncDate));
              } else if (state is OrderRecordFailState) {
              } else if (state is OrderItemSuccessState) {
                print("OrderItemSuccessState");
                _bloc.add(GetVisitOrderMappingApi(fromTimeStamp: lastSyncDate));
              } else if (state is OrderItemFailState) {
              } else if (state is GetVisitOrderMappingSuccessState) {
                print("GetVisitOrderMappingSuccessState");
                _bloc
                    .add(CallVisitApi(pageIndex: 1, fromTimeStamp: state.data));
                /* */
              } else if (state is GetVisitOrderMappingFailState) {
              } else if (state is DeleteProductFromCartSuccessState ||
                  state is DeleteProductFromCartFailedState) {
                _deleteItemManageState(state);
              } else if (state is DeleteAllDataFromCartSuccessState ||
                  state is DeleteAllDataFromCartFailedState) {
                _deleteAllItemManageState(state);
              } else if (state is GetSchemeSuccessState ||
                  state is GetSchemeFailState) {
                _manageProductSchemeState(state);
              } else if (state is GetFreeProductDetailsSuccessState ||
                  state is GetFreeProductDetailsFailState) {
                _manageFreeProductDetailsState(state);
              } else if (state is VisitSuccessState ||
                  state is VisitFailedState) {
                _manageVisitDetailsState(state);
              }
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title: AppStrings.lblCart,
                hasBack: true,
              ),
              body: SafeArea(
                child: CommonContainer(
                  hasTimer: true,
                  topLayout: CommonDetailedHeader(
                      hasExtraPadding: true,
                      outletName: widget.outletInfo?.businessName,
                      retailerLocation: widget.outletInfo?.routeName,
                      retailerType: widget.outletInfo?.customerTypeName,
                      screenName: AppStrings.lblCart),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 30, bottom: 15),
                        child: NameNumberWidget(
                            retailerName: widget.outletInfo?.contactPersonName,
                            number: widget.outletInfo?.mobileNumber),
                      ),
                      Expanded(
                        child: _productList.isNotEmpty
                            ? CartListView(
                                orderList: _productList,
                                discountOnProduct: totalProductDiscount,
                                billDiscount: schemeDiscount,
                                warehouseId: widget.warehouseId,
                                isNavigateFromProductScreen:
                                    widget.isNavigateFromProductScreen,
                                outletInfo: widget.outletInfo,
                                bloc: _bloc,
                                totalBaseAmount: totalBaseAmount,
                                totalTax: totalTax,
                                totalPayable: totalPayable,
                                schemeList: schemeList,
                                onSchemeSelected: (value) {
                                  setState(() {
                                    totalBaseAmount = 0.0;
                                    totalTax = 0.0;
                                    totalPayable = 0.0;
                                    totalDiscount = 0.0;
                                    freeProductDetails = null;
                                    _selectedScheme = value;
                                    _calculateTotalPayable();
                                    applySchemeOnProduct(_selectedScheme!);
                                  });
                                },
                                radioSelection: (selectedData) {
                                  orderType = selectedData;
                                },
                                freeProductDetails: freeProductDetails,
                              )
                            : const Center(
                                child: Text(AppStrings.msgYourCartIsEmpty),
                              ),
                      ),
                      _bottomButtonView()
                    ],
                  ),
                ),
              ),
            ),
          ));

  Widget _bottomButtonView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: appCommonFlatButton(
              btnTxt: AppStrings.lblAddMore,
              isTopRightRounded: false,
              onPressed: _onMore,
            ),
          ),
          Container(
            width: 0.5,
            color: Colors.white,
          ),
          Expanded(
              child: appCommonFlatButton(
            btnTxt: AppStrings.lblPlaceOrder,
            isTopLeftRounded: false,
            isTopRightRounded: false,
            onPressed: () {
              _onSave();
            },
          )),
          Container(
            width: 0.5,
            color: Colors.white,
          ),
          Expanded(
              child: appCommonFlatButton(
            btnTxt: AppStrings.lblCancel,
            isTopLeftRounded: false,
            onPressed: _onDelete,
          )),
        ],
      );

  void _productManageState(state) {
    if (state is GetProductFromCartSuccessState) {
      print(state.data);
      _productList = state.data;

      _bloc.add(GetSchemeDataFromDB(
          totalAmount: totalBaseAmount,
          totalQuantity: _calculateTotalPayable()));
    } else {}
  }

  void _deleteItemManageState(state) {
    if (state is DeleteProductFromCartSuccessState) {
      print(state.data);
      setState(() {
        _productList.removeAt(state.index);
        _bloc.add(GetSchemeDataFromDB(
            totalAmount: totalBaseAmount,
            totalQuantity: _calculateTotalPayable()));
        if (_productList.isEmpty) {
          Navigator.pop(context);
        }
      });
    } else {}
  }

  void _deleteAllItemManageState(state) {
    if (state is DeleteAllDataFromCartSuccessState) {
      if (state.data == true) {
        navigationPushReplacement(
        context,
        OutletInfoScreen(
          outletInfo: widget.outletInfo,
        ));
      }
    } else {}
  }

  _forDeleteAllItemFromCart(bool needScreenRedirection) {
    _bloc.add(
        DeleteAllDataFromCart(needScreenRedirection: needScreenRedirection));
  }

  double _calculateTotalPayable() {
    totalBaseAmount = 0.0;
    totalTax = 0.0;
    totalPayable = 0.0;
    totalDiscount = 0.0;
    totalProductDiscount = 0.0;
    double totalItems = 0;
    for (final element in _productList) {
      totalItems = totalItems + (element.quantity ?? 0);
      totalBaseAmount = totalBaseAmount +
          ProductPriceCalculation.calculateTotalPrice(element);
      totalTax = totalTax + ProductPriceCalculation.calculateTotalTax(element);
      totalDiscount = totalDiscount +
          ProductPriceCalculation.calculateTotalDiscount(element);
    }
    totalPayable = ProductPriceCalculation.calculatePayableAmount(
        totalBaseAmount, totalDiscount, totalTax);
    totalProductDiscount = totalDiscount;
    return totalItems;
    /* */
  }

  void _onDelete() {
    _showConfirmationDialog();
  }

  void _onSave() async {
    orderDate = '${DateTime.now().toIso8601String()}+05:30';
    userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    visitId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.visitId);
    if (visitId == null || visitId == 0) {
      visitId = await SharedPreferenceService()
          .getIntValuesSF(SharedPrefsConstants.scopeId);
    }
    final selectedAddress = widget.outletInfo!.customerAddress
        ?.firstWhere((element) => element.isDefaultAddress == true);
    _bloc.add(InsertOrderIntoOrderRecord(
        orderRecord: OrderRecordDataResponse(
      totalAmount: totalPayable,
      subscriberId: 1,
      shippingAddress: selectedAddress!.id!,
      billingAddress: selectedAddress.id!,
      schemeId: _selectedScheme?.id,
      addedDiscount: 0,
      //as per discussion with Jigar on date 23/03 we have to removed this discount from order record.
      orderDate: orderDate,
      warehouseId: widget.warehouseId ?? 0,
      distributorId: widget.distributorId ?? 0,
      customerId: widget.outletInfo!.id ?? 0,
      orderType: OrderTypeStatus.FieldSales,
      fsmOrderType: orderType,
      visitId: visitId,
      created_by: userId,
      created_on: orderDate,
      isSync: SyncStatus.unSync,
      id: generateRandomNumber(),
    )));
/*
    */
  }

  void saveOrderItem(int orderId, String orderDate) {
    for (var i = 0; i < _productList.length; i++) {
      orderItemList.add(OrderItemDataResponse(
          id: generateRandomNumber(),
          orderId: orderId,
          productId: _productList[i].id,
          hsnCode: _productList[i].hsn,
          cgst: _productList[i].cgst,
          sgst: _productList[i].sgst,
          igst: _productList[i].igst,
          vat: 0,
          uoM: _productList[i].selected_uom_id ?? 0,
          basePrice: _productList[i].entered_price ?? 0.toDouble(),
          discount: (_productList[i].discount ?? 0).toDouble(),
          orderQuantity: (_productList[i].quantity ?? 0).toDouble(),
          schemeId: _productList[i].selected_scheme_id,
          created_by: userId,
          created_on: orderDate,
          isSync: SyncStatus.unSync));

      if (_productList[i].selected_scheme_id != null &&
          _productList[i].free_product_id != null &&
          _productList[i].free_product_id != 0) {
        orderItemList.add(OrderItemDataResponse(
            id: generateRandomNumber(),
            orderId: orderId,
            productId: _productList[i].free_product_id,
            hsnCode: "",
            cgst: 0,
            sgst: 0,
            igst: 0,
            vat: 0,
            uoM: _productList[i].free_product_uom,
            basePrice: 0.0,
            discount: 0.0,
            orderQuantity:
                (_productList[i].free_product_quantity ?? 0).toDouble(),
            schemeId: null,
            created_by: userId,
            created_on: orderDate,
            isSync: SyncStatus.unSync));
      }
    }
    if (freeProductDetails != null) {
      orderItemList.add(OrderItemDataResponse(
          id: generateRandomNumber(),
          orderId: orderId,
          productId: freeProductDetails?.free_product_id,
          hsnCode: "",
          cgst: 0,
          sgst: 0,
          igst: 0,
          vat: 0,
          uoM: freeProductDetails?.free_product_uom ?? 0,
          basePrice: 0.0,
          discount: 0.0,
          orderQuantity:
              (freeProductDetails?.free_product_quantity ?? 0).toDouble(),
          schemeId: null,
          created_by: userId,
          created_on: orderDate,
          isSync: SyncStatus.unSync));
    }
    _bloc.add(InsertOrderItemIntoDB(orderItemList: orderItemList));
  }

  void _onMore() {
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void callPlaceOrderAPI(int index) {
    _bloc.add(PlaceOrderAPICall(
        placeOrderItem: unSyncOrderList[index], index: index));
  }

  _manageProductSchemeState(state) {
    if (state is GetSchemeSuccessState) {
      schemeList = [];
      state.data.forEach((element) {
        schemeList.add(SchemeListDataResponse.fromJson(element));
      });
    } else {
      showSnackBar(context, state.msg ?? "");
    }
  }

  void applySchemeOnProduct(SchemeListDataResponse value) {
    if (value.freeProductId != null &&
        value.minTotalValue != null &&
        value.maxTotalValue != null &&
        value.minTotalValue != 0 &&
        value.maxTotalValue != 0) {
      final freeProduct = ProductWithPriceModel();
      final freeProductQuantity =
          (totalBaseAmount / value.complementaryQntyPercent!).round();
      freeProduct.free_product_quantity = freeProductQuantity;
      freeProduct.free_product_id = value.freeProductId!;
      freeProduct.free_product_uom = value.complementaryUOM;
      _bloc.add(GetFreeProduct(freeProduct: freeProduct));
    } else {
      schemeDiscount =
          (totalBaseAmount * (value.additionalDiscountPercent ?? 1)) / 100;
      setState(() {
        totalPayable = ProductPriceCalculation.calculatePayableAmount(
            totalBaseAmount, totalDiscount+schemeDiscount, totalTax);
      });
    }
  }

  void _manageFreeProductDetailsState(BaseState state) {
    if (state is GetFreeProductDetailsSuccessState) {
      setState(() {
        freeProductDetails = state.freeProduct;
      });
    }
  }

  void _manageVisitDetailsState(BaseState state) {
    if (state is VisitSuccessState) {
      VisitResponse visitDetails = state.data;
      if (visitDetails.data.hasNextPage) {
        _bloc.add(CallVisitApi(
            pageIndex: (visitDetails.data.pageIndex! + 1),
            fromTimeStamp: visitDetails.lastSyncTimeStamp));
      } else {
        _showAlertForSuccessfulOrder();
      }
    } else if (state is VisitFailedState) {
      _showAlertForSuccessfulOrder();
    }
  }

  _showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              content: AppStrings.msgAreYouSure,
              title: AppStrings.lblCancelOrder,
              yes: AppStrings.lblYes,
              no: AppStrings.lblNo,
              yesOnPressed: () {
                _bloc.add(_forDeleteAllItemFromCart(true));
              },
              noOnPressed: () {
                Navigator.of(context).pop(true);
              },
            ));
  }

  void _showAlertForSuccessfulOrder() {
    navigationPushReplacement(
        context,
        OutletInfoScreen(
          outletInfo: widget.outletInfo,
        ));
    showCustomDialog(context, AppStrings.msgOrderPlacedSuccessfully,
        AppStrings.lblCongratulations, AppStrings.ok, yesOnPressed: () {
      //_navigateToOutletHome3(context);
    });
  }
}
