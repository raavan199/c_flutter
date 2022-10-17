import 'package:darq/src/extensions/distinct.dart';
import 'package:darq/src/extensions/first_where_or_default.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/customer/customer_bloc.dart';
import '../../../blocs/route/route_bloc.dart';
import '../../../data/models/route/order_filter_item.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../themes/custom_text_style.dart';
import '../base/base_screen.dart';
import '../modify_outlet/modify_outlet_screen.dart';
import '../timeline_retailerinfo/timeline_retailinfo_screen.dart';

/// Created by Dev 2301 on 12/4/2021
/// Modified by Dev 2301 on 12/4/2021
/// Purpose : route info screen
/// user gets redirected to this screen on tapping route item in RoutesScreen
class RoutesInfoScreen extends StatefulWidget {
  const RoutesInfoScreen({
    required this.routeName,
    required this.routeId,
    Key? key,
  }) : super(key: key);

  final String routeName;
  final int routeId;

  @override
  _RoutesInfoScreenState createState() => _RoutesInfoScreenState();
}

class _RoutesInfoScreenState extends State<RoutesInfoScreen> with UtilityMixin {
  List<HorizontalBoxListModel> _horizontalList = [];
  List<CustomerDataItemsResponse> _storeList = [];
  List<CustomerDataItemsResponse> _storeDisplayList = [];

  //for filter
  List<OrderFilterItem> _totalOrderWithCustomerMappingList = [];
  var idleCustomersList = <OrderFilterItem>[];
  var regularCustomersList = <OrderFilterItem>[];
  var irregularCustomersList = <OrderFilterItem>[];

  late CustomerBloc _bloc;
  int? _totalRouteCount = 0;

  @override
  void initState() {
    super.initState();
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _storeList) {
      list.add(SearchModel(item.businessName ?? ""));
    }
    return list;
  }

  List<CustomerDataItemsResponse> _getResultData(List<SearchModel> result) {
    final list = <CustomerDataItemsResponse>[];
    for (final item in result) {
      for (final element in _storeList) {
        if (item.searchable == element.businessName) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<CustomerBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetOrdersMappingFromDB(routeId: widget.routeId));
      },
      builder: (context, bloc, child) => BlocListener<CustomerBloc, BaseState>(
            listener: (context, state) {
              if (state is GetCustomersSuccessState) {
                _storeList = state.data;
                _storeDisplayList = _storeList;
                _bloc.add(GetRoutesCountFromDB());
              } else if (state is GetCustomersFailedState) {
              } else if (state is GetRoutesCountSuccessState) {
                _totalRouteCount =
                    state.data.isEmpty ? 0 : (state.data as List).length;
              } else if (state is GetOrderListSuccessState) {
                _totalOrderWithCustomerMappingList = [];
                state.data.forEach((element) {
                  _totalOrderWithCustomerMappingList
                      .add(OrderFilterItem.fromJson(element));
                });
                prepareFilterData();
                _bloc.add(GetCustomersBasedOnRoutes(routeId: widget.routeId));
              } else if (state is GetOrderListFailedState) {}
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title:
                    '${AppStrings.lblRoute.toUpperCase()} - ${widget.routeName.toUpperCase()}',
              ),
              drawer: const AppDrawer(
                selectedIndex: 3,
              ),
              body: SafeArea(
                child: CommonContainer(
                  isSearchable: true,
                  searchData: _getSearchableData(),
                  searchHint: AppStrings.searchHintRouteInfo,
                  onSearchResult: (result) {
                    setState(() {
                      _storeDisplayList = _getResultData(result);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Column(
                      children: [
                        HorizontalBoxesView(
                          list: _horizontalList,
                          itemClick: _itemClick,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Expanded(
                          child: _storeDisplayList.isNotEmpty
                              ? _buildListView()
                              : const Center(
                                  child: Text(AppStrings.msgNoDataFound)),
                        ),
                        SizedBox(
                          width: Get.width,
                          child: appCommonFlatButton(
                              btnTxt: AppStrings.lblAddNew.toUpperCase(),
                              onPressed: () async {
                                /*navigationPush(
                                    context,
                                    ModifyOutletScreen(
                                      isFromRouteInfo: true,
                                    ));*/
                                await navigationWithAwaitPush(
                                    context,
                                    ModifyOutletScreen(
                                      isFromRouteInfo: true,
                                    ));
                                setState(() {
                                  _bloc.add(GetOrdersMappingFromDB(
                                      routeId: widget.routeId));
                                });
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));

  Widget _buildListView() => ListView.builder(
        itemCount: _storeDisplayList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          final item = _storeDisplayList[i];
          return _listItemView(item);
        },
      );

  Widget _listItemView(CustomerDataItemsResponse item) => Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
        child: InkWell(
          onTap: () => _onItemTap(item),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [Shadows.greyShadow],
              borderRadius: BorderRadius.circular(5),
            ),
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 15, left: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor:
                      false ? AppColors.primary : AppColors.accentOrange,
                  radius: 22,
                  child: Center(
                    child: Text(
                      "RT",
                      style: const TextStyle(color: AppColors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.businessName ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: AppFonts.medium),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _iconTextRow(
                        AppAssets.icPerson,
                        item.contactPersonName,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _iconTextRow(
                        AppAssets.icPhone,
                        item.mobileNumber ?? "",
                      ),
                    ],
                  ),
                ),
                if (orderPlacedOrNot(item) == true &&
                    noOrderPlacedOrNot(item) == true)
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: SvgPicture.asset(
                          AppAssets.icCartCheck,
                          width: 25,
                          height: 25,
                          color: AppColors.green,
                        ),
                      ),
                      SvgPicture.asset(
                        AppAssets.icCartXMark,
                        width: 25,
                        height: 25,
                        color: AppColors.red,
                      ),
                    ],
                  )
                else if (orderPlacedOrNot(item) == true)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      AppAssets.icCartCheck,
                      width: 25,
                      height: 25,
                      color: AppColors.green,
                    ),
                  )
                else if (noOrderPlacedOrNot(item) == true)
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SvgPicture.asset(
                      AppAssets.icCartXMark,
                      width: 25,
                      height: 25,
                      color: AppColors.red,
                    ),
                  ),
                const SizedBox(
                  width: 10,
                ),
                SvgPicture.asset(
                  AppAssets.icLocationDot,
                  width: 25,
                  height: 25,
                )
              ],
            ),
          ),
        ),
      );

  bool orderPlacedOrNot(CustomerDataItemsResponse item) {
    final data = _totalOrderWithCustomerMappingList.firstWhereOrNull(
        (element) => element.customerId == item.id && element.orderDate == 1);
    if (data == null) {
      return false;
    } else {
      return true;
    }
  }

  bool noOrderPlacedOrNot(CustomerDataItemsResponse item) {
    final data = _totalOrderWithCustomerMappingList.firstWhereOrNull(
        (element) => element.customerId == item.id && element.noOrderDate == 1);
    if (data == null) {
      return false;
    } else {
      return true;
    }
  }

  void _itemClick(int index) {
    setState(() {
      _storeDisplayList = [];
      List<CustomerDataItemsResponse> _tempFilterList = [];
      switch (index) {
        case 0:
          {
            _tempFilterList.addAll(_storeList);
          }
          break;
        case 1:
          {
            for (var element in _storeList) {
              for (var e in regularCustomersList) {
                if (element.id == e.customerId) {
                  _tempFilterList.add(element);
                }
              }
            }
          }
          break;
        case 2:
          {
            for (var element in _storeList) {
              for (var e in irregularCustomersList) {
                if (element.id == e.customerId) {
                  _tempFilterList.add(element);
                }
              }
            }
          }
          break;
        case 3:
          {
            for (var element in _storeList) {
              for (var e in idleCustomersList) {
                if (element.id == e.customerId) {
                  _tempFilterList.add(element);
                }
              }
            }
          }
          break;
      }
      _storeDisplayList.addAll(_tempFilterList.distinct((d) => d.id!));
    });
  }

  void _onItemTap(CustomerDataItemsResponse item) async {
    await navigationWithAwaitPush(
        context,
        TimelineRetailInfo(
          startVisit: true,
          customerId: item.id!,
        ));
    setState(() {
      _bloc.add(GetOrdersMappingFromDB(routeId: widget.routeId));
    });
  }

  Widget _iconTextRow(image, title) => Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: SvgPicture.asset(
                image,
                width: 15,
                height: 15,
                color: AppColors.accentGery,
              ),
            ),
          ),
          Text(
            title ?? 'N/A',
            style: CustomTextStyle.smallGreyTextStyle,
          ),
        ],
      );

  void prepareFilterData() {
    final operationalArrayOfOrder = <OrderFilterItem>[];
    idleCustomersList = <OrderFilterItem>[];
    regularCustomersList = <OrderFilterItem>[];
    irregularCustomersList = <OrderFilterItem>[];

    final pastOneMonthCustomersList = <OrderFilterItem>[];
    final pastTwoMonthCustomersList = <OrderFilterItem>[];
    final pastThreeMonthCustomersList = <OrderFilterItem>[];
    operationalArrayOfOrder.addAll(_totalOrderWithCustomerMappingList);
    //got the idle customers
    idleCustomersList.addAll(
        operationalArrayOfOrder.where((element) => element.orderId == null));

    ///remove the idle customers from main loop to reduce the operations.
    operationalArrayOfOrder.removeWhere((element) => element.orderId == null);

    ///get past 1month data
    ///
    var fi = returnMonth(0);
    var ti = returnMonth(1);
    var thi = returnMonth(2);
    for (var element in operationalArrayOfOrder) {
      if (element.Month == fi) {
        pastOneMonthCustomersList.add(element);
      } else if (element.Month == ti) {
        pastTwoMonthCustomersList.add(element);
      } else if (element.Month == thi) {
        pastThreeMonthCustomersList.add(element);
      }
    }

    final distinctOperationalArrayOfOrder =
        operationalArrayOfOrder.distinct((d) => d.customerId);

    distinctOperationalArrayOfOrder.forEach((element) {
      OrderFilterItem _containInFirstMonth = pastOneMonthCustomersList
          .firstWhereOrDefault((e) => element.customerId == e.customerId,
              defaultValue: OrderFilterItem(
                  customerId: -1, businessName: "temp", routeId: -1));

      OrderFilterItem _containInSecondMonth = pastTwoMonthCustomersList
          .firstWhereOrDefault((e) => element.customerId == e.customerId,
              defaultValue: OrderFilterItem(
                  customerId: -1, businessName: "temp", routeId: -1));
      OrderFilterItem _containInThirdMonth = pastThreeMonthCustomersList
          .firstWhereOrDefault((e) => element.customerId == e.customerId,
              defaultValue: OrderFilterItem(
                  customerId: -1, businessName: "temp", routeId: -1));

      if (_containInFirstMonth.customerId != -1 &&
          _containInSecondMonth.customerId != -1 &&
          _containInThirdMonth.customerId != -1) {
        regularCustomersList.add(element);
      } else if (_containInFirstMonth.customerId != -1 ||
          _containInSecondMonth.customerId != -1 ||
          _containInThirdMonth.customerId != -1) {
        irregularCustomersList.add(element);
      }
    });

    print(regularCustomersList.length);
    print(irregularCustomersList.length);

    setState(() {
      _horizontalList = [
        HorizontalBoxListModel(
            '${regularCustomersList.length + irregularCustomersList.length + idleCustomersList.length}',
            AppStrings.lblAll,
            informationIcon: true,
            informationTitle: AppStrings.lblAll,
            informationDetail: AppStrings.msgAllInformationOutlet),
        HorizontalBoxListModel(
            '${regularCustomersList.length}', AppStrings.lblRegular,
            informationIcon: true,
            informationTitle: AppStrings.lblRegular,
            informationDetail: AppStrings.msgRegularInformation),
        HorizontalBoxListModel(
            '${irregularCustomersList.length}', AppStrings.lblIrregular,
            informationIcon: true,
            informationTitle: AppStrings.lblIrregular,
            informationDetail: AppStrings.msgIrregularInformation),
        HorizontalBoxListModel(
            '${idleCustomersList.length}', AppStrings.lblIdle,
            informationIcon: true,
            informationTitle: AppStrings.lblIdle,
            informationDetail: AppStrings.msgIdleInformation),
      ];
    });
  }

  String returnMonth(int previousMonth) {
    final date = DateTime.now();
    final prevMonth = DateTime(date.year, date.month - previousMonth, date.day);
    final formatter = DateFormat('MM');
    return formatter.format(prevMonth);
  }
}
