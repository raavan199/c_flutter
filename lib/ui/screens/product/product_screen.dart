import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/product/product_bloc.dart';
import '../../../data/models/AvailableStock/available_stock_response.dart';
import '../../../data/models/product_trends/product_trends_item.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../widgets/badge_icon.dart';
import '../../widgets/custom_dialog.dart';
import '../base/base_screen.dart';
import '../cart/cart_screen.dart';
import '../filter/advance_filter_screen.dart';
import 'product_list_view.dart';

/// Created by Dev 2183 on 12/8/2021
/// Modified by Dev 2183 on 12/8/2021
/// Purpose : Product List Screen

class ProductScreen extends StatefulWidget {
  const ProductScreen(
      {required this.distributorId,
      required this.warehouseId,
      required this.outletInfo,
      Key? key})
      : super(key: key);
  final int distributorId;
  final int warehouseId;
  final CustomerDataItemsResponse? outletInfo;

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> with UtilityMixin {
  List<ProductWithPriceModel> _productDataList = [];
  AvailableStockResponse? _stockData;
  List<ProductWithPriceModel> _productDataDisplayList = [];
  final List<ProductTrendsItem> _productTrendsList = [];
  late ProductBloc _bloc;
  final List<RadioSelectionItemModel> _radioSelectionList = [
    RadioSelectionItemModel(AppStrings.lblAll, isSelected: true),
    RadioSelectionItemModel(
      AppStrings.lblMustSell,
    ),
    RadioSelectionItemModel(
      AppStrings.lblFocused,
    ),
    RadioSelectionItemModel(
      AppStrings.lblNew,
    ),
    RadioSelectionItemModel(
      AppStrings.lblOutletTrend,
    ),
  ];
  late RadioSelectionItemModel selectedNormalFilterItem;
  Map<String, int?> result = HashMap();
  List<ProductWithPriceModel> _productInCartList = [];

  @override
  void initState() {
    super.initState();
    selectedNormalFilterItem = _radioSelectionList[0];
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _productDataList) {
      list.add(SearchModel(item.name!));
    }
    return list;
  }

  List<ProductWithPriceModel> _getResultData(List<SearchModel> result) {
    final list = <ProductWithPriceModel>[];
    for (final item in result) {
      for (final element in applyAllFilter()) {
        if (item.searchable == element.name) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<ProductBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
          _bloc.add(
              GetProductList(outletInfo: widget.outletInfo!, result: result));
          final firstWhereOrNull = widget.outletInfo?.customerAddress!
              .firstWhereOrNull((element) => element.isDefaultAddress!);
          if (firstWhereOrNull != null) {
            _bloc.add(
                GetProductTrendList(locationId: firstWhereOrNull.locationId!));
          }
        },
        builder: (context, bloc, child) => BlocListener<ProductBloc, BaseState>(
          listener: (context, state) {
            if (state is ProductSuccessState) {
              _productDataList = state.data;
              /*  state.data.forEach((element) {
                _productDataList.add(ProductWithPriceModel.fromJson(element));
              });*/
              _productDataDisplayList = _productDataList;
              ////For get number of product in cart so, we can show count on cart icon badge
              _bloc.add(const GetProductListFromCart());
            } else if (state is ProductFailedState) {
              ////For get number of product in cart so, we can show count on cart icon badge
              _bloc.add(const GetProductListFromCart());
              showCustomFlushBar(context, state.msg);
            } else if (state is StockSuccessState) {
              _stockData = state.data;
              _productDataList.forEach((element) {
                if (element.product_id == state.productId) {
                  element.availableStock = _stockData?.data;
                }
              });
            } else if (state is StockFailedState) {
              showCustomFlushBar(context, state.msg);
            } else if (state is ProductTrendsSuccessState ||
                state is ProductTrendsFailedState) {
              _manageProductTrendsState(state);
            } else if (state is DeleteCartItemsSuccessState ||
                state is DeleteCartItemsFailedState) {
              Navigator.of(context).pop();
            } else if (state is ProductListFromCartSuccessState ||
                state is ProductListFromCartFailedState) {
              manageProductListFromCart(state);
            }
          },
          child: WillPopScope(
            onWillPop: () async => (await _showConfirmationDialog()) ?? false,
            child: Scaffold(
              appBar: CustomAppBar(
                title: AppStrings.lblNewOrder,
                hasBack: true,
                backTap: () {
                  _showConfirmationDialog();
                },
              ),
              body: CommonContainer(
                hasTimer: true,
                topLayout: CommonDetailedHeader(
                    outletName: widget.outletInfo?.businessName,
                    retailerType: widget.outletInfo?.customerTypeName,
                    retailerLocation: widget.outletInfo?.routeName,
                    screenName: AppStrings.lblNewOrder),
                isSearchable: true,
                searchData: _getSearchableData(),
                searchHint: AppStrings.searchHintProduct,
                onSearchResult: (result) {
                  setState(() {
                    _productDataDisplayList = _getResultData(result);
                  });
                },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 35,
                          left: AppStyles.pageSideMargin,
                          right: AppStyles.pageSideMargin,
                          bottom: 5),
                      child: _filterIconView(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: AppStyles.pageSideMargin,
                        right: AppStyles.pageSideMargin,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [Shadows.greyShadow],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: _radioSelectionView(),
                      ),
                    ),
                    Expanded(
                        child: _productDataDisplayList.isNotEmpty
                            ? ProductListView(
                                productNameList: _productDataDisplayList,
                                outletInfo: widget.outletInfo,
                                bloc: _bloc,
                                availableStockResponse: _stockData,
                                warehouseId: widget.warehouseId,
                                distributorId: widget.distributorId,
                                updateState: () {
                                  setState(() {
                                    _bloc.add(const GetProductListFromCart());
                                  });
                                },
                              )
                            : const Center(
                                child: Text(AppStrings.msgNoDataFound),
                              ))
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  void manageProductListFromCart(state) {
    if (state is ProductListFromCartSuccessState) {
      _productInCartList.clear();
      setState(() {
        _productInCartList = state.data;
      });
    }
  }

  Widget _filterIconView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppStrings.lblFilter,
            style: CustomTextStyle.subHeaderTextStyle,
          ),

          ///side actions
          Row(
            children: [
              InkWell(
                onTap: () async {
                  result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdvanceFilterScreen(result),
                    ),
                  );
                  setState(() {
                    _productDataDisplayList = applyAllFilter();
                  });

                  print("result:$result");
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SvgPicture.asset(
                    AppAssets.icFilter,
                    width: 25,
                    height: 25,
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  navigationPush(
                      context,
                      CartScreen(
                        outletInfo: widget.outletInfo,
                        warehouseId: widget.warehouseId,
                        distributorId: widget.distributorId,
                        isNavigateFromProductScreen: true,
                      ));
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 7,
                  ),
                  child: BadgeIcon(
                    icon: AppAssets.icCart,
                    badgeCount: _productInCartList.length,
                  ),
                ),
              ),
            ],
          ),
        ],
      );

  Widget _radioSelectionView() => RadioSelectionView(
        list: _radioSelectionList,
        hasDecoration: false,
        hasSpaceBetween: false,
        fontSize: 12,
        fontWeight: AppFonts.medium,
        onItemChanged: (data) => _onRadioChanged(data),
      );

  void _onRadioChanged(RadioSelectionItemModel e) {
    selectedNormalFilterItem = e;
    setState(() {
      _productDataDisplayList = applyAllFilter();
    });
  }

  void _manageProductTrendsState(BaseState state) {
    if (state is ProductTrendsSuccessState) {
      state.data.forEach((element) {
        _productTrendsList.add(ProductTrendsItem.fromJsonForRowQuery(element));
      });
    }
  }

  List<ProductWithPriceModel> applyAllFilter() {
    final advancedFilterList =
        applyAdvanceFilterOnProductList(result, _productDataList);
    final normalFilterList = applyNormalFilterOnProductList(
        selectedNormalFilterItem, advancedFilterList);
    return normalFilterList;
  }

  List<ProductWithPriceModel> applyAdvanceFilterOnProductList(
      Map<String, int?> result, List<ProductWithPriceModel> _filterList) {
    int? groupId;
    int? subGroupId;
    int? categoryId;
    int? subCategoryId;
    if (result.containsKey('groupId') && result['groupId'] != null) {
      groupId = result['groupId'];
    }
    if (result.containsKey('subGroupId') && result['subGroupId'] != null) {
      subGroupId = result['subGroupId'];
    }
    if (result.containsKey('catId') && result['catId'] != null) {
      categoryId = result['catId'];
    }
    if (result.containsKey('subCatId') && result['subCatId'] != null) {
      subCategoryId = result['subCatId'];
    }
    final list = _filterList
        .where((element) => advanceFilterFunction(
            groupId, subGroupId, categoryId, subCategoryId, element))
        .toList();
    return list;
  }

  bool advanceFilterFunction(int? groupId, int? subGroupId, int? categoryId,
      int? subCategoryId, ProductWithPriceModel element) {
    if (groupId == null &&
        subGroupId == null &&
        categoryId == null &&
        subCategoryId == null) {
      return true;
    } else if (groupId == element.group_id ||
        subGroupId == element.sub_group_id ||
        categoryId == element.category_id ||
        subCategoryId == element.sub_category_id) {
      return true;
    } else {
      return false;
    }
  }

  List<ProductWithPriceModel> applyNormalFilterOnProductList(
      RadioSelectionItemModel e, List<ProductWithPriceModel> _filterlist) {
    var _list = <ProductWithPriceModel>[];
    switch (e.title) {
      case AppStrings.lblAll:
        {
          _list = _filterlist;
        }
        break;
      case AppStrings.lblMustSell:
        {
          final mustSellProducts =
              _productTrendsList.where((element) => element.isMustSell == true);
          for (final element in mustSellProducts) {
            final filteredData =
                _filterlist.where((e) => element.productId == e.id);
            if (filteredData.isNotEmpty) {
              _list.addAll(filteredData);
            }
          }
        }
        break;
      case AppStrings.lblFocused:
        {
          final mustSellProducts =
              _productTrendsList.where((element) => element.isFocus == true);
          for (final element in mustSellProducts) {
            final filteredData =
                _filterlist.where((e) => element.productId == e.id);
            if (filteredData.isNotEmpty) {
              _list.addAll(filteredData);
            }
          }
        }
        break;
      case AppStrings.lblNew:
        {
          final mustSellProducts =
              _productTrendsList.where((element) => element.isNew == true);
          for (final element in mustSellProducts) {
            final filteredData =
                _filterlist.where((e) => element.productId == e.id);
            if (filteredData.isNotEmpty) {
              _list.addAll(filteredData);
            }
          }
        }
        break;
      case AppStrings.lblOutletTrend:
        {
          final mustSellProducts = _productTrendsList
              .where((element) => element.isOutletTrend == true);
          for (final element in mustSellProducts) {
            final filteredData =
                _filterlist.where((e) => element.productId == e.id);
            if (filteredData.isNotEmpty) {
              _list.addAll(filteredData);
            }
          }
        }
        break;
    }
    return _list;
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
                _bloc.add(const DeleteAllProductsFromCart());
              },
              noOnPressed: () {
                Navigator.of(context).pop();
              },
            ));
  }
}
