import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../blocs/accounts/account_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import '../../../utilities/shadow.dart';
import '../add_new_order/product_price_calculation.dart';
import '../base/base_screen.dart';

/// Created by Dev 2136 on 13/12/2021
/// Modified by Dev 2136 on 13/12/2021
/// Purpose : transaction history info screen of the app
class TransactionHistoryScreen extends StatefulWidget {
  CustomerDataItemsResponse? outletInfo;

  TransactionHistoryScreen({required this.outletInfo, Key? key})
      : super(key: key);

  @override
  _TransactionHistoryScreenState createState() =>
      _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen>
    with UtilityMixin {
  int groupValue = -1;
  List<RouteStoreModel> _storeList = [];
  List<OrderInvoiceMapping> _OrderInvoiceMappingList = [];
  List<OrderInvoiceMapping> _orderInvoiceMappingDisplayList = [];
  DateTime startDate = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  DateTime endDate = DateTime.now();
  late AccountBloc _bloc;
  var openingBalance = 0.0;
  var newBilling = 0.0;
  var paymentAdjustmentBalance = 0.0;

  var totalPaidAmount = 0.0;
  var closingBalance = 0.0;

  @override
  void initState() {
    super.initState();
    _storeList = [
      RouteStoreModel(name: 'Daily Fresh', initials: 'RT', isPositive: true),
      RouteStoreModel(
        name: 'Q-Mart',
        initials: 'MT',
      ),
      RouteStoreModel(name: 'Pargya Store', initials: 'MT', isPositive: true),
    ];
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _OrderInvoiceMappingList) {
      list.add(SearchModel(item.secondaryInvoiceSerialNumber));
    }
    return list;
  }

  List<OrderInvoiceMapping> _getResultData(List<SearchModel> result) {
    final list = <OrderInvoiceMapping>[];
    for (final item in result) {
      for (final element in _OrderInvoiceMappingList) {
        if (item.searchable == element.secondaryInvoiceSerialNumber) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<AccountBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetInvoicesFromDB(
            customerId: widget.outletInfo!.id!,
            startDate: startDate.toString(),
            endDate: endDate.toString(),
        orderId: -1));
      },
      builder: (context, bloc, child) => BlocListener<AccountBloc, BaseState>(
          listener: (context, state) {
            if (state is GetInvoicesSuccessState) {
              _OrderInvoiceMappingList = state.data;
              _orderInvoiceMappingDisplayList = state.data;
              _bloc.add(GetDataForTopLayoutFromDB(
                  customerId: widget.outletInfo!.id!,
                  startDate: startDate.toString(),
                  endDate: endDate.toString()));
            } else if (state is GetInvoicesFailedState) {
            } else if (state is GetTopLayoutDataSuccessState) {
              setState(() {
                openingBalance = state.openingBalance;
                paymentAdjustmentBalance = state.paymentAdjustment;
                newBilling = state.newBilling;
              });
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.lblTransactionHistory,
              hasBack: true,
            ),
            body: SafeArea(
              child: CommonContainer(
                hasTimer: true,
                topLayout: CommonDetailedHeader(
                    hasExtraPadding: true,
                    outletName: widget.outletInfo?.businessName,
                    retailerType: widget.outletInfo?.customerTypeName,
                    retailerLocation: widget.outletInfo?.routeName,
                    screenName: ''),
                isSearchable: true,
                searchData: _getSearchableData(),
                searchHint: AppStrings.searchHintInvoice,
                onSearchResult: (result) {
                  setState(() {
                    _orderInvoiceMappingDisplayList = _getResultData(result);
                  });
                  print(_getResultData(result));
                },
                child: _buildTransactionHistoryView(),
              ),
            ),
          )));

  Widget _buildTransactionHistoryView() => Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(
                      left: AppStyles.pageSideMargin,
                      top: 40,
                      right: AppStyles.pageSideMargin,
                      bottom: 75),
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NameNumberWidget(
                          retailerName: widget.outletInfo?.contactPersonName!,
                          number: widget.outletInfo?.mobileNumber!),
                      const SizedBox(height: 20),
                      _dateSelectorAndMailView(),
                      const SizedBox(
                        height: 20,
                      ),
                      BalanceView(
                          openingBalance: openingBalance,
                          newBilling: newBilling,
                          adjustments: paymentAdjustmentBalance,
                          closingBalance: (openingBalance + newBilling) -
                              paymentAdjustmentBalance),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: AppStyles.SalesAdjustCardHeight,
                        margin: EdgeInsets.only(top: Get.width * .015),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          boxShadow: const [Shadows.blueShadow],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Gross Total',
                                  style:
                                      CustomTextStyle.transactionTitleTextStyle,
                                ),
                                Text(
                                  'INR ${calculateTotalPaidAmount()}',
                                  style:
                                      CustomTextStyle.transactionTitleTextStyle,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 10, 15, 10),
                                  decoration: const BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                    child: Text(
                                      'Receipt',
                                      style: CustomTextStyle
                                          .switchPrimaryTextStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      _transactionsListview(),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: 50,
              child: appCommonFlatButton(
                  btnTxt: AppStrings.lblAccounts.toUpperCase(),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          )
        ],
      );

  Widget _dateSelectorAndMailView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () async {
              await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(DateTime.now().year - 10,
                          DateTime.now().month, DateTime.now().day),
                      lastDate: DateTime.now(),
                  initialEntryMode: DatePickerEntryMode.calendarOnly)
                  .then((value) {
                setState(() {
                  startDate = value!.start;
                  endDate = value!.end;
                  _bloc.add(GetInvoicesFromDB(
                      customerId: widget.outletInfo!.id!,
                      startDate: startDate.toString(),
                      endDate: endDate.toString(),
                  orderId: -1));
                });
              });
            },
            child: Text(
              '${getDateFromDateTime(startDate.toIso8601String())} - ${getDateFromDateTime(endDate.toIso8601String())}',
              style: const TextStyle(
                fontSize: 13,
                fontWeight: AppFonts.extraBold,
              ),
            ),
          ),
          SvgPicture.asset(
            AppAssets.icEmail,
            height: 25,
            width: 25,
            //color: Colors.bla,
          ),
        ],
      );

  Widget _transactionsListview() => ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _orderInvoiceMappingDisplayList != null
          ? _orderInvoiceMappingDisplayList.length
          : 0,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
      itemBuilder: (context, index) => Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: AppStyles.SalesAdjustCardHeight,
                    margin: EdgeInsets.only(top: Get.width * .015),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [Shadows.greyShadow],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getDateAndMonthFromDateTime(
                                  _orderInvoiceMappingDisplayList[index].date),
                              style: CustomTextStyle.imageDetailsTextStyle,
                            ),
                            Text(
                              _orderInvoiceMappingDisplayList[index]
                                  .secondaryInvoiceSerialNumber,
                              style: CustomTextStyle.smallTextStyle,
                            ),
                            Text(
                              'INR ${calculateTotalPaidAmountForInvoice(_orderInvoiceMappingDisplayList[index])}',
                              style: CustomTextStyle.smallTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: Get.height * .04,
                      width: Get.width * .22,
                      margin: EdgeInsets.only(
                          right: Get.width * .010, top: Get.width * .17),
                      child: appCommonRoundedButton(
                          btnTxt: AppStrings.lblReceipt, onPressed: () {}),
                    ),
                  )
                ],
              ),
            ],
          ));

  String calculateTotalPaidAmount() {
    var totalPaidAmount = 0.0;
    for (final orderInvoiceMapping in _orderInvoiceMappingDisplayList) {
      if (orderInvoiceMapping.invoiceStatementItems == null ||
          orderInvoiceMapping.invoiceStatementItems?.isEmpty == true) {
        continue;
      }
      for (final element in orderInvoiceMapping.invoiceStatementItems!) {
        totalPaidAmount = totalPaidAmount + element.amount!;
      }
    }

    return totalPaidAmount.toStringAsFixed(2);
  }

  String calculateTotalPaidAmountForInvoice(
      OrderInvoiceMapping orderInvoiceMapping) {
    var totalPaidAmount = 0.0;
    if (orderInvoiceMapping.invoiceStatementItems == null ||
        orderInvoiceMapping.invoiceStatementItems?.isEmpty == true) {
      return totalPaidAmount.toStringAsFixed(2);
    }
    for (final element in orderInvoiceMapping.invoiceStatementItems!) {
      totalPaidAmount = totalPaidAmount + element.amount!;
    }

    return totalPaidAmount.toStringAsFixed(2);
  }

  double calculateTotalPrice() {
    var price = 0.0;
    var totalTax = 0.0;
    totalPaidAmount = 0.0;
    for (final orderInvoiceMapping in _orderInvoiceMappingDisplayList) {
      var orderInvoiceMappingPrice = 0.0;
      var orderInvoiceMappingTotalTax = 0.0;
      var orderInvoiceMappingTotalPaidAmount = 0.0;
      for (final element in orderInvoiceMapping.secondaryInvoiceItems!) {
        orderInvoiceMappingPrice = orderInvoiceMappingPrice +
            ProductPriceCalculation.calculatePriceOfProduct(
                element.basePrice ?? 1, element.billQuantity?.toDouble() ?? 1);
        orderInvoiceMappingTotalTax = orderInvoiceMappingTotalTax +
            ProductPriceCalculation.calculateTotalTaxWithPrice(
                element.basePrice ?? 1,
                element.billQuantity?.toDouble() ?? 1,
                element.igst ?? 1,
                0.0);
      }

      if (orderInvoiceMapping.invoiceStatementItems != null) {
        for (final element in orderInvoiceMapping.invoiceStatementItems!) {
          orderInvoiceMappingTotalPaidAmount =
              orderInvoiceMappingTotalPaidAmount + element.amount!;
        }
      }

      orderInvoiceMapping.isPaid = double.parse(
              ((orderInvoiceMappingPrice + orderInvoiceMappingTotalTax) -
                      orderInvoiceMappingTotalPaidAmount)
                  .toStringAsFixed(2)) ==
          0;
      price = price + orderInvoiceMappingPrice;
      totalTax = totalTax + orderInvoiceMappingTotalTax;
      totalPaidAmount = totalPaidAmount + orderInvoiceMappingTotalPaidAmount;
    }

    return double.parse(
        ((price + totalTax) - totalPaidAmount).toStringAsFixed(2));
  }
}
