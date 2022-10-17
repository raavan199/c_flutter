import 'package:darq/darq.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/route/route_bloc.dart';
import '../../../data/models/route/get_route_by_user_items.dart';
import '../../../data/models/route/order_filter_item.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';
import 'route_list_view.dart';

/// Created by Dev 2301 on 12/2/2021
/// Modified by Dev 2301 on 12/2/2021
/// Purpose : routes screen open from side menu on tapping 4th item "Routes"
class RouteScreen extends StatefulWidget {
  const RouteScreen({Key? key}) : super(key: key);

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> with UtilityMixin {
  List<HorizontalBoxListModel> _horizontalList = [];
  List<RouteItems> _routeNameList = [];
  List<RouteItems> _routeDisplayList = [];
  List<CustomerDataItemsResponse> _totalCustomerCount = [];
  List<OrderFilterItem> _totalOrderWithCustomerMappingList = [];
  var idleCustomersList = <OrderFilterItem>[];
  var regularCustomersList = <OrderFilterItem>[];
  var irregularCustomersList = <OrderFilterItem>[];
  late RouteBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _routeNameList) {
      list.add(SearchModel(item.name ?? ""));
    }
    return list;
  }

  List<RouteItems> _getResultData(List<SearchModel> result) {
    final list = <RouteItems>[];
    for (final item in result) {
      for (final element in _routeNameList) {
        if (item.searchable == element.name) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<RouteBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetRouteListFromDB());
        _bloc.add(GetOrdersFromDB());
      },
      builder: (context, bloc, child) => BlocListener<RouteBloc, BaseState>(
            listener: (context, state) {
              if (state is RouteSuccessState) {
                _routeNameList = [];
                state.data.forEach((element) {
                  _routeNameList.add(RouteItems.fromJson(element));
                });
                _routeDisplayList = _routeNameList;
                _bloc.add(GetTotalCustomerCountFromDB());
              } else if (state is RouteFailedState) {
              } else if (state is TotalCustomerCountSuccessState) {
                _totalCustomerCount = state.data;
              } else if (state is TotalCustomerCountFailedState) {
              } else if (state is GetOrderListSuccessState) {
                _totalOrderWithCustomerMappingList = [];
                state.data.forEach((element) {
                  _totalOrderWithCustomerMappingList
                      .add(OrderFilterItem.fromJson(element));
                });
                prepareFilterData();
              } else if (state is GetOrderListFailedState) {}
            },
            child: Scaffold(
              appBar: CustomAppBar(title: AppStrings.lblRoutes),
              drawer: const AppDrawer(
                selectedIndex: 3,
              ),
              body: SafeArea(
                child: CommonContainer(
                  topLayout: CommonRouteHeader(
                      routeCount: '${_routeNameList.length}',
                      outletCount: '${_totalCustomerCount.length}'),
                  isSearchable: true,
                  searchData: _getSearchableData(),
                  searchHint: AppStrings.searchHintRoute,
                  onSearchResult: (result) {
                    setState(() {
                      _routeDisplayList = _getResultData(result);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20, top: 30),
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
                            child: _routeDisplayList.isNotEmpty
                                ? RouteListView(
                                    routeNameList: _routeDisplayList,
                                  )
                                : const Center(
                                    child: Text(AppStrings.msgNoDataFound)))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ));

  void _itemClick(int index) {
    setState(() {
      _routeDisplayList = [];
      List<RouteItems> _tempFilterList = [];
      switch (index) {
        case 0:
          {
            _tempFilterList.addAll(_routeNameList);
          }
          break;
        case 1:
          {
            for (var element in _routeNameList) {
              for (var e in regularCustomersList) {
                if (element.id == e.routeId) {
                  _tempFilterList.add(element);
                }
              }
            }
          }
          break;
        case 2:
          {
            for (var element in _routeNameList) {
              for (var e in irregularCustomersList) {
                if (element.id == e.routeId) {
                  _tempFilterList.add(element);
                }
              }
            }
          }
          break;
        case 3:
          {
            for (var element in _routeNameList) {
              for (var e in idleCustomersList) {
                if (element.id == e.routeId) {
                  _tempFilterList.add(element);
                }
              }
            }
          }
          break;
      }
      _routeDisplayList.addAll(_tempFilterList.distinct((d) => d.id!));
    });
  }

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

    _horizontalList = [
      HorizontalBoxListModel(
          '${regularCustomersList.length + irregularCustomersList.length + idleCustomersList.length}',
          AppStrings.lblAll,
          informationIcon: true,
          informationTitle: AppStrings.lblAll,
          informationDetail: AppStrings.msgAllInformation),
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
      HorizontalBoxListModel('${idleCustomersList.length}', AppStrings.lblIdle,
          informationIcon: true,
          informationTitle: AppStrings.lblIdle,
          informationDetail: AppStrings.msgIdleInformation),
    ];
  }

  String returnMonth(int previousMonth) {
    final date = DateTime.now();
    final prevMonth = DateTime(date.year, date.month - previousMonth, date.day);
    final formatter = DateFormat('MM');
    return formatter.format(prevMonth);
  }
}
