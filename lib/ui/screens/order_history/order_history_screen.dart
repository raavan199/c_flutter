import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/order_history/order_history_bloc.dart';
import '../../../data/models/order_item/order_item_data_response.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import '../../../utilities/shadow.dart';
import '../base/base_screen.dart';
import '../order_item/order_item_screen.dart';

/// Created by Dev 2136 on 09/12/2021
/// Modified by Dev 2136 on 02/14/2022
/// Purpose : order history screen of the app
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({this.outletInfo, Key? key}) : super(key: key);

  final CustomerDataItemsResponse? outletInfo;

  @override
  _OrderHistoryScreenState createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen>
    with UtilityMixin {
  List<HorizontalBoxListModel> _horizontalList = [];

  late OrderHistoryBloc _bloc;
  OrderRecordDataResponse? orderRecord;
  List<OrderRecordDataResponse> orderRecordList = [];
  List<OrderRecordDataResponse> orderRecordDisplayList = [];
  List<OrderItemDataResponse> orderItemList = [];
  bool datePicker = false;
  late String startDate;
  String endDate = DateTime.now().toIso8601String();

  @override
  void initState() {
    super.initState();
    _horizontalList = [
      HorizontalBoxListModel('10', AppStrings.order),
      HorizontalBoxListModel('20', AppStrings.delivered),
      HorizontalBoxListModel('05', AppStrings.pending),
      HorizontalBoxListModel('01', AppStrings.lblCancel),
    ];
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in orderRecordList) {
      list.add(SearchModel(item.orderSerialNumber.toString()));
    }
    return list;
  }

  List<OrderRecordDataResponse> _getResultData(List<SearchModel> result) {
    final list = <OrderRecordDataResponse>[];
    for (final item in result) {
      for (final element in orderRecordList) {
        if (item.searchable == element.orderSerialNumber.toString()) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<OrderHistoryBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        startDate = DateTime(DateTime.now().year, DateTime.now().month - 1,
                DateTime.now().day)
            .toIso8601String();
        _bloc.add(GetOrderRecordListFromDB(
            customerId: widget.outletInfo!.id ?? 0,
            startDate: startDate ?? "",
            endDate: endDate ?? ""));
      },
      builder: (context, bloc, child) =>
          BlocListener<OrderHistoryBloc, BaseState>(
              listener: (context, state) {
                if (state is GetOrderRecordListSuccessState ||
                    state is GetOrderRecordListFailState) {
                  _manageOrderRecordState(state);
                }
              },
              child: Scaffold(
                appBar: CustomAppBar(
                  hasBack: true,
                  title: AppStrings.lblOrderHistory,
                ),
                body: CommonContainer(
                  hasTimer: true,
                  topLayout: CommonDetailedHeader(
                      hasExtraPadding: true,
                      outletName: widget.outletInfo!.businessName,
                      retailerType: widget.outletInfo!.customerTypeName,
                      retailerLocation: widget.outletInfo!.routeName,
                      screenName: ''),
                  isSearchable: true,
                  searchData: _getSearchableData(),
                  searchHint: AppStrings.searchHintOrder,
                  onSearchResult: (result) {
                    setState(() {
                      orderRecordDisplayList = _getResultData(result);
                    });
                  },
                  child: SafeArea(
                    child: _buildOrderHistoryScreenView(),
                  ),
                ),
              )));

  void _manageOrderRecordState(state) {
    if (state is GetOrderRecordListSuccessState) {
      print('GetOrderRecord list success state call');
      orderRecordList = [];
      orderRecordDisplayList = [];
      if (state.data != null) {
        state.data.forEach((v) {
          orderRecordList.add(OrderRecordDataResponse.fromJsonF0rRowQuery(v));
        });
        orderRecordDisplayList.addAll(orderRecordList);
      }
    } else {
      print('GetOrder Record List FailState call');
      Flushbar(
        title: AppStrings.lblFieldSales.toUpperCase(),
        message: state.msg ?? "",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  Widget _buildOrderHistoryScreenView() => Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NameNumberWidget(
                retailerName: widget.outletInfo!.contactPersonName,
                number: widget.outletInfo!.mobileNumber),
            const SizedBox(height: 15),
            InkWell(
              onTap: () async {
                await showDateRangePicker(
                        context: context,
                        firstDate: DateTime(DateTime.now().day - 7),
                        lastDate: DateTime.now(),
                    initialEntryMode: DatePickerEntryMode.calendarOnly)
                    .then((value) {
                  setState(() {
                    startDate = value!.start.toIso8601String();
                    endDate = value!.end.toIso8601String();
                    _bloc.add(GetOrderRecordListFromDB(
                        customerId: widget.outletInfo!.id ?? 0,
                        startDate: startDate ?? "",
                        endDate: endDate ?? ""));
                  });
                });
              },
              child: Center(
                child: Text(
                  '${getDateFromDateTime(startDate)} - '
                  '${getDateFromDateTime(endDate)}',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    fontWeight: AppFonts.extraBold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            //HorizontalBoxesView(list: _horizontalList, itemClick: () {}),
            Expanded(
                child: orderRecordDisplayList.isNotEmpty
                    ? _orderDetailView()
                    : const Center(child: Text(AppStrings.msgNoDataFound))),
          ],
        ),
      );

  Widget _orderDetailView() => ListView.builder(
        itemCount: orderRecordDisplayList.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => InkWell(
          onTap: () async {
            await navigationWithAwaitPush(
                context,
                OrderItemScreen(
                  outletInfo: widget.outletInfo,
                  orderId: orderRecordDisplayList[index].id ?? 0,
                  distributorId:
                      orderRecordDisplayList[index].distributorId ?? 0,
                ));
            setState(() {});
          },
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: AppStyles.pageSideMargin,
              vertical: 10,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [Shadows.greyShadow],
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        '${AppStrings.order}: '
                        '${orderRecordDisplayList[index].orderSerialNumber ?? ""}, ',
                        style: CustomTextStyle.primaryBold11,
                      ),
                      Text(
                        '${AppStrings.lblDate} : '
                        '${getDateFromDateTime(
                          orderRecordDisplayList[index].orderDate ?? "",
                        )}',
                        style: CustomTextStyle.blackNormal11,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: orderRecordDisplayList[index].visitPartnerName != null
                      ? Text(
                          'Order by : ${orderRecordDisplayList[index].fullName ?? ""} & '
                          '${orderRecordDisplayList[index].visitPartnerName ?? ""}',
                          style: CustomTextStyle.blackNormal11,
                        )
                      : Text(
                          'Order by : ${orderRecordDisplayList[index].fullName ?? ""}',
                          style: CustomTextStyle.blackNormal11,
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    '#item : ${orderRecordDisplayList[index].TotalOrder ?? ""}',
                    style: CustomTextStyle.blackNormal11,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    'Invoice Amount : INR  ${orderRecordDisplayList[index].totalAmount?.toStringAsFixed(2)}',
                    style: CustomTextStyle.blackNormal11,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: Visibility(
                    visible: false,
                    child: Row(
                      children: [
                        Text(
                          'Status : ',
                          style: CustomTextStyle.blackNormal11,
                        ),
                        _statusDeropdownView(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget _statusDeropdownView() => Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 5),
        child: Text(
          'Delivered',
          style: CustomTextStyle.blackNormal11,
        ),
      );
}
