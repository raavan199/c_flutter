import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../blocs/accounts/account_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../data/models/invoice/order_invoice_mapping.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../widgets/dash_line_divider.dart';
import '../../widgets/radio_selection_view.dart';
import '../add_new_order/product_price_calculation.dart';
import '../base/base_screen.dart';
import '../payment_collection/payment_collection_screen.dart';
import '../statement/statement_screen.dart';
import '../transaction_history/transaction_history_screen.dart';
import '../view_invoice/view_invoice_screen.dart';
import 'account_row.dart';

/// Created by Dev 2136 on 13/12/2021
/// Modified by Dev 2136 on 13/12/2021
/// Purpose : accounts screen of the app
class AccountsScreen extends StatefulWidget {
  CustomerDataItemsResponse? outletInfo;
  int? orderId;

  AccountsScreen({required this.outletInfo, this.orderId, Key? key})
      : super(key: key);

  @override
  _AccountsScreenState createState() => _AccountsScreenState();
}

class _AccountsScreenState extends State<AccountsScreen> with UtilityMixin {
  int groupValue = -1;
  List<OrderInvoiceMapping> _OrderInvoiceMappingList = [];
  List<OrderInvoiceMapping> _orderInvoiceMappingDisplayList = [];
  DateTime startDate = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  DateTime endDate = DateTime.now();
  late AccountBloc _bloc;
  late String selectedFilter;

  var openingBalance = 0.0;
  var newBilling = 0.0;
  var paymentAdjustmentBalance = 0.0;

  final List<RadioSelectionItemModel> _radioSelectionList = [
    RadioSelectionItemModel(
      AppStrings.lblAll,
      isSelected: true,
    ),
    RadioSelectionItemModel(
      AppStrings.lblUnpaid,
    ),
    RadioSelectionItemModel(
      AppStrings.lblPaid,
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedFilter = AppStrings.lblAll;
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
      for (final element in applyFilter()) {
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
            orderId: widget.orderId != null ? widget.orderId! : -1));
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
                newBilling = state.newBilling;
                paymentAdjustmentBalance = state.paymentAdjustment;
              });
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              hasBack: true,
              title: AppStrings.lblAccounts,
            ),
            body: SafeArea(
              child: CommonContainer(
                hasTimer: true,
                topLayout: CommonDetailedHeader(
                    hasExtraPadding: true,
                    outletName: widget.outletInfo?.businessName!,
                    retailerType: widget.outletInfo?.customerTypeName!,
                    retailerLocation: widget.outletInfo?.routeName,
                    screenName: ''),
                isSearchable: true,
                searchData: _getSearchableData(),
                searchHint: AppStrings.searchHintInvoice,
                onSearchResult: (result) {
                  setState(() {
                    _orderInvoiceMappingDisplayList = _getResultData(result);
                  });
                },
                child: _buildAccountsScreenView(),
              ),
            ),
          )));

  Widget _buildAccountsScreenView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(
                  AppStyles.pageSideMargin, 40, AppStyles.pageSideMargin, 10),
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NameNumberWidget(
                      retailerName: widget.outletInfo?.contactPersonName!,
                      number: widget.outletInfo?.mobileNumber!),
                  const SizedBox(height: 20),
                  if (widget.orderId==null || widget.orderId == -1)
                    _dateSelectorAndMailView()
                  else
                    const SizedBox(),
                  const SizedBox(height: 20),
                  BalanceView(
                      openingBalance: openingBalance,
                      newBilling: newBilling,
                      adjustments: paymentAdjustmentBalance,
                      closingBalance: (openingBalance + newBilling) -
                          paymentAdjustmentBalance),
                  const SizedBox(
                    height: 20,
                  ),
                  _filterTextView(),
                  Row(
                    children: [
                      Expanded(
                        child: RadioSelectionView(
                          list: _radioSelectionList,
                          onItemChanged: (value) {
                            setState(() {
                              selectedFilter = value.title;
                              _orderInvoiceMappingDisplayList = applyFilter();
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _totalAmountWidget(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildListview(),
                ],
              ),
            ),
          ),
          appCommonFlatButton(
              btnTxt: AppStrings.lblTransactions.toUpperCase(),
              onPressed: () async {
                await navigationWithAwaitPush(
                    context,
                    TransactionHistoryScreen(
                      outletInfo: widget.outletInfo,
                    ));
                setState(() {});
              })
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
                      orderId: widget.orderId != null ? widget.orderId! : -1));
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
          ),
        ],
      );

  Widget _filterTextView() => const Text(
        AppStrings.filterInvoice,
        style: TextStyle(
          fontSize: 14,
          fontWeight: AppFonts.extraBold,
        ),
      );

  Widget _totalAmountWidget() => Container(
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Invoice',
                    style: CustomTextStyle.transactionTitleTextStyle,
                  ),
                  Text(
                    '${_orderInvoiceMappingDisplayList.length}',
                    style: CustomTextStyle.receiptTextStyle,
                  ),
                ],
              ),
            ),
            const DashedDivider(
              height: 1,
              color: AppColors.white,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Balance',
                    style: CustomTextStyle.transactionTitleTextStyle,
                  ),
                  Text(
                    'INR ${calculateTotalPrice().toStringAsFixed(2)}',
                    style: CustomTextStyle.receiptTextStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _buildListview() => ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _orderInvoiceMappingDisplayList.length,
      shrinkWrap: true,
      separatorBuilder: (context, index) => const SizedBox(
            height: 0,
          ),
      itemBuilder: (context, index) => InkWell(
            onTap: () {
              navigationPush(
                  context,
                  StatementScreen(
                      outletInfo: widget.outletInfo,
                      orderInvoice: _orderInvoiceMappingDisplayList[index]));
            },
            child: AccountRow(
                onViewTap: () async {
                  await navigationWithAwaitPush(
                      context,
                      ViewInvoiceScreen(
                        outletInfo: widget.outletInfo,
                        selectedInvoice: _orderInvoiceMappingDisplayList[index],
                      ));
                  setState(() {});
                },
                onPayTap: () async {
                  final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentCollectionScreen(
                          outletInfo: widget.outletInfo,
                          selectedInvoice:
                              _orderInvoiceMappingDisplayList[index],
                        ),
                      ));
                  setState(() {
                    if (result != null) {
                      openingBalance = 0.0;
                      newBilling = 0.0;
                      paymentAdjustmentBalance = 0.0;
                      _bloc.add(GetInvoicesFromDB(
                          customerId: widget.outletInfo!.id!,
                          startDate: startDate.toString(),
                          endDate: endDate.toString(),
                          orderId:
                              widget.orderId != null ? widget.orderId! : -1));
                    }
                  });
                },
                isPaid: _orderInvoiceMappingDisplayList[index].isPaid!,
                date: getDateAndMonthFromDateTime(
                    _orderInvoiceMappingDisplayList[index].date ?? ""),
                invoiceNumber: _orderInvoiceMappingDisplayList[index]
                    .secondaryInvoiceSerialNumber,
                price:
                    'INR ${calculatePrice(_orderInvoiceMappingDisplayList[index])?.toStringAsFixed(2)}'),
          ));

  double calculatePrice(OrderInvoiceMapping orderInvoiceMapping) {
    var price = 0.0;
    var totalTax = 0.0;
    var discount = 0.0;

    for (final element in orderInvoiceMapping.secondaryInvoiceItems!) {
      price = price +
          ProductPriceCalculation.calculatePriceOfProduct(
              element.basePrice ?? 0, element.billQuantity!.toDouble());

      var inDiscount = 0.0;
      if (element.discount != null && element.discount != 0.0) {
        inDiscount = ProductPriceCalculation.calculateDiscountValue(
            element.basePrice ?? 0,
            element.discount!,
            element.billQuantity!.toDouble());
        discount = discount + inDiscount;
      }
      totalTax = totalTax +
          ProductPriceCalculation.calculateTotalTaxWithPrice(
              element.basePrice ?? 0,
              element.billQuantity!.toDouble(),
              element.igst ?? 0,
              inDiscount);
    }

    return (price - discount) + totalTax;
  }

  double calculateTotalPrice() {
    var price = 0.0;
    var totalPaidAmount = 0.0;
    for (final orderInvoiceMapping in _orderInvoiceMappingDisplayList) {
      var orderInvoiceMappingTotalPaidAmount = 0.0;
      var currentInvoiceAmount = calculatePrice(orderInvoiceMapping);

      if (orderInvoiceMapping.invoiceStatementItems != null) {
        for (final element in orderInvoiceMapping.invoiceStatementItems!) {
          orderInvoiceMappingTotalPaidAmount =
              orderInvoiceMappingTotalPaidAmount + element!.amount!;
        }
      }

      orderInvoiceMapping.isPaid = double.parse(
              (currentInvoiceAmount - orderInvoiceMappingTotalPaidAmount)
                  .toStringAsFixed(2)) ==
          0;
      price = price + currentInvoiceAmount;
      totalPaidAmount = totalPaidAmount + orderInvoiceMappingTotalPaidAmount;
    }

    return double.parse((price - totalPaidAmount).toStringAsFixed(2));
  }

  List<OrderInvoiceMapping> applyFilter() {
    final filteredList = <OrderInvoiceMapping>[];
    if (selectedFilter == AppStrings.lblAll) {
      filteredList.addAll(_OrderInvoiceMappingList);
    } else if (selectedFilter == AppStrings.lblUnpaid) {
      filteredList.addAll(
          _OrderInvoiceMappingList.where((element) => element.isPaid == false));
    } else if (selectedFilter == AppStrings.lblPaid) {
      filteredList.addAll(
          _OrderInvoiceMappingList.where((element) => element.isPaid == true));
    }
    return filteredList;
  }
}
