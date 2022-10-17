import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
import '../sales_return/sales_return_screen.dart';
import '../sales_return_history/sales_retuen_history_screen.dart';

class SalesAdjustmentScreen extends StatefulWidget {
  CustomerDataItemsResponse outletInfo;

  SalesAdjustmentScreen({required this.outletInfo, Key? key}) : super(key: key);

  @override
  _SalesAdjustmentScreenState createState() => _SalesAdjustmentScreenState();
}

class _SalesAdjustmentScreenState extends State<SalesAdjustmentScreen>
    with UtilityMixin {
  int groupValue = -1;
  List<RouteStoreModel> _storeList = [];
  final List<SalesReturnItem> _salesReturnList = [];
  List<SalesReturnItem> _salesReturnDisplayList = [];
  late SalesReturnHistoryBloc _bloc;
  double totalPrice = 0;
  double totalTax = 0;
  double totalAmountWithTax = 0;
  DateTime startDate = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  DateTime endDate = DateTime.now();

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
          _bloc.add(GetSalesAdjustment(
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
                var data = SalesReturnItem.fromJsonForRowQuery(value);
                if (data.isApprove == true) {
                  _salesReturnList.add(data);
                }
              }
              _salesReturnDisplayList.addAll(_salesReturnList);
              calculatePrice();
            } else if (state is SalesReturnHistoryFailedState) {}
          },
          child: Scaffold(
            appBar: CustomAppBar(
              hasBack: true,
              title: AppStrings.lblSalesAdjustment,
            ),
            body: SafeArea(
              child: CommonContainer(
                hasTimer: true,
                topLayout: CommonDetailedHeader(
                    hasExtraPadding: true,
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
                child: _buildAccountsScreenView(),
              ),
            ),
          ),
        ),
      );

  Widget _buildAccountsScreenView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    NameNumberWidget(
                        retailerName: widget.outletInfo.contactPersonName,
                        number: widget.outletInfo.mobileNumber),
                    const SizedBox(height: 15),
                    _dateSelectorAndMailView(),
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
              btnText2: AppStrings.txtSalesReturnHistory,
              onPress1: () {
                navigationPushReplacement(
                    context,
                    SalesReturnScreen(
                      outletInfo: widget.outletInfo,
                    ));
              },
              onPrese2: () {
                navigationPushReplacement(
                    context,
                    SalesReturnHistoryScreen(
                      outletInfo: widget.outletInfo,
                    ));
              })
        ],
      );

  Widget _dateSelectorAndMailView() => Stack(
        alignment: Alignment.centerRight,
        children: [
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
                    _bloc.add(GetSalesAdjustment(
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
                  fontSize: 13,
                  fontWeight: AppFonts.extraBold,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SvgPicture.asset(
              AppAssets.icEmail,
              height: 25,
              width: 25,
              //color: Colors.bla,
            ),
          )
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
              Text(
                AppStrings.txtBaseAmount + " ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.normal,
                ),
              ),
              Text(
                "INR ${totalPrice.toString()}",
                style: TextStyle(
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
            height: 1,
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
                AppStrings.txtTaxAmount + " ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.normal,
                ),
              ),
              Text(
                "INR $totalTax",
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
            height: 1,
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
                AppStrings.txtTotalAmount + " ",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: AppFonts.bold,
                ),
              ),
              Text(
                "INR ${totalAmountWithTax.toString()}",
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
            ProductPriceCalculation.calculateTotalTaxWithPrice(
                value.rate!, value.sellableQuantity ?? 1, value.igst ?? 1, 0.0);

        if (value.damagedQuantity != null) {
          totalPrice = totalPrice +
              ProductPriceCalculation.calculatePriceOfProduct(
                  value.rate ?? 1, value.damagedQuantity ?? 1);
          totalTax = totalTax +
              ProductPriceCalculation.calculateTotalTaxWithPrice(value.rate!,
                  value.damagedQuantity ?? 1, value.igst ?? 1, 0.0);
        }
      }
    }
    totalAmountWithTax = totalPrice + totalTax;
  }
}
