import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/sales_return_history/sales_return_history_bloc.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../listview_rowitem/sales_adjustments_row.dart';
import '../../widgets/dash_line_divider.dart';
import '../add_new_order/product_price_calculation.dart';
import '../base/base_screen.dart';
import '../sales_adjustment/sales_adjustment_screen.dart';

class SalesReturnHistoryScreen extends StatefulWidget {
  CustomerDataItemsResponse outletInfo;

  SalesReturnHistoryScreen({required this.outletInfo, Key? key})
      : super(key: key);

  @override
  _SalesReturnHistoryScreenState createState() =>
      _SalesReturnHistoryScreenState();
}

class _SalesReturnHistoryScreenState extends State<SalesReturnHistoryScreen>
    with UtilityMixin {
  final List<SalesReturnItem> _salesReturnList = [];
  List<SalesReturnItem> _salesReturnDisplayList = [];
  late SalesReturnHistoryBloc _bloc;
  double totalPrice = 0;
  double totalTax = 0;
  double totalAmountWithTax = 0;
  DateTime startDate = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  DateTime endDate = DateTime.now();

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _salesReturnList) {
      list.add(SearchModel(item.productName ?? ""));
    }
    return list;
  }

  List<SalesReturnItem> _getResultData(List<SearchModel> result) {
    final list = <SalesReturnItem>[];
    for (final item in result) {
      for (final element in _salesReturnList) {
        if (item.searchable == element.productName) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<SalesReturnHistoryBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetSalesReturnHistory(
            customerId: widget.outletInfo.id!,
            startDate: startDate.toString(),
            endDate: endDate.toString()));
      },
      builder: (context, bloc, child) =>
          BlocListener<SalesReturnHistoryBloc, BaseState>(
              listener: (context, state) {
                if (state is SalesReturnHistorySuccessState) {
                  _salesReturnList.clear();
                  _salesReturnDisplayList.clear();
                  for (final value in state.data) {
                    _salesReturnList
                        .add(SalesReturnItem.fromJsonForRowQuery(value));
                  }
                  _salesReturnDisplayList.addAll(_salesReturnList);
                  calculatePrice();
                } else if (state is SalesReturnHistoryFailedState) {}
              },
              child: Scaffold(
                appBar: CustomAppBar(
                  hasBack: true,
                  title: AppStrings.lblSalesReturnHistory,
                ),
                body: CommonContainer(
                  hasTimer: true,
                  topLayout: CommonDetailedHeader(
                      outletName: widget.outletInfo.businessName,
                      retailerType: widget.outletInfo.customerTypeName,
                      retailerLocation: widget.outletInfo.routeName,
                      screenName: ''),
                  isSearchable: true,
                  searchData: _getSearchableData(),
                  searchHint: AppStrings.searchHintProduct,
                  onSearchResult: (result) {
                    setState(() {
                      _salesReturnDisplayList = _getResultData(result);
                    });
                  },
                  child: SafeArea(
                    child: _buildSalesReturnHistoryScreenView(),
                  ),
                ),
              )));

  Widget _buildSalesReturnHistoryScreenView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
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
                              _bloc.add(GetSalesReturnHistory(
                                  customerId: widget.outletInfo.id!,
                                  startDate: startDate.toString(),
                                  endDate: endDate.toString()));
                            });
                          });
                        },
                        child: Text(
                          '${getDateFromDateTime(startDate.toIso8601String())} - ${getDateFromDateTime(endDate.toIso8601String())}',
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
                    _buildListview(),
                    const SizedBox(
                      height: 20,
                    ),
                    if (_salesReturnDisplayList.isNotEmpty)
                      _billingDetailView()
                    else
                      const Center(
                        child: Text(AppStrings.msgNoDataFound),
                      ),
                  ],
                ),
              ),
            ),
          ),
          CommonBottomButton(
              btnText1: AppStrings.txtNewSalesReturn,
              btnText2: AppStrings.lblAdjustments.toUpperCase(),
              onPress1: () {
                Navigator.pop(context);
              },
              onPrese2: () async {
                await navigationWithAwaitPush(
                    context,
                    SalesAdjustmentScreen(
                      outletInfo: widget.outletInfo,
                    ));
                setState(() {});
              }),
        ],
      );

  Widget _buildListview() => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _salesReturnDisplayList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => SalesAdjustmentsRow(
            data: _salesReturnDisplayList[index],
            isLableDisplay: true,
          ));

  Widget _billingDetailView() => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _baseAmountWidget(),
          _taxAmountWidget(),
          _totalAmountWidget(),
        ],
      );

  Widget _baseAmountWidget() => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "${AppStrings.txtBaseAmount} ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.normal,
                ),
              ),
              Text(
                "INR ${totalPrice.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.normal,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const DashedDivider(
            color: AppColors.border,
          )
        ],
      );

  Widget _taxAmountWidget() => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "${AppStrings.txtTaxAmount} ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.normal,
                ),
              ),
              Text(
                "INR ${totalTax.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.normal,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const DashedDivider(
            color: AppColors.border,
          )
        ],
      );

  Widget _totalAmountWidget() => Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                "${AppStrings.txtTotalAmount} ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.bold,
                ),
              ),
              Text(
                "INR ${totalAmountWithTax.toStringAsFixed(2)}",
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.bold,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      );

  void calculatePrice() {
    totalPrice = 0.0;
    totalTax = 0.0;
    totalAmountWithTax = 0.0;
    for (final value in _salesReturnDisplayList) {
      if (value.rate != null) {
        totalPrice = totalPrice +
            ProductPriceCalculation.calculatePriceOfProduct(
                value.rate ?? 1, value.sellableQuantity ?? 1);
        totalTax = totalTax +
            ProductPriceCalculation.calculateTotalTaxWithPrice(value.rate!,
                (value.sellableQuantity ?? 1).toDouble(), value.igst ?? 1, 0.0);
        if (value.damagedQuantity != null) {
          totalPrice = totalPrice +
              ProductPriceCalculation.calculatePriceOfProduct(
                  value.rate ?? 1, value.damagedQuantity ?? 1);
          totalTax = totalTax +
              ProductPriceCalculation.calculateTotalTaxWithPrice(
                  value.rate!,
                  (value.damagedQuantity ?? 1).toDouble(),
                  value.igst ?? 1,
                  0.0);
        }
      }
    }
    totalAmountWithTax = totalPrice + totalTax;
  }
}
