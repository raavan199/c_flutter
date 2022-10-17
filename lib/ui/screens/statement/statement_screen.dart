import 'package:cygneto/ui/widgets/dash_line_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../data/models/invoice/order_invoice_mapping.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../mixins/utility_mixin.dart';
import '../../../resources/app_styles.dart';
import '../add_new_order/product_price_calculation.dart';

/// Created by Dev 2136 on 14/12/2021
/// Modified by Dev 2136 on 14/12/2021
/// Purpose : statement screen of the app
class StatementScreen extends StatefulWidget {
  CustomerDataItemsResponse? outletInfo;
  OrderInvoiceMapping? orderInvoice;

  StatementScreen(
      {required this.outletInfo, required this.orderInvoice, Key? key})
      : super(key: key);

  @override
  _StatementScreenState createState() => _StatementScreenState();
}

class _StatementScreenState extends State<StatementScreen> with UtilityMixin {
  int groupValue = -1;

  List<RouteStoreModel> _storeList = [];

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
    for (final item in _storeList) {
      list.add(SearchModel(item.name));
    }
    return list;
  }

  List<RouteStoreModel> _getResultData(List<SearchModel> result) {
    final list = <RouteStoreModel>[];
    for (final item in result) {
      for (final element in _storeList) {
        if (item.searchable == element.name) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(
          hasBack: true,
          title:
              '${AppStrings.lblStatement} ${widget.orderInvoice!.secondaryInvoiceSerialNumber}',
        ),
        body: CommonContainer(
          hasTimer: true,
          topLayout: CommonDetailedHeader(
              hasExtraPadding: true,
              outletName: widget.outletInfo?.businessName,
              retailerType: widget.outletInfo?.customerTypeName,
              retailerLocation: widget.outletInfo?.routeName,
              screenName: ''),
          isSearchable: false,
          searchData: _getSearchableData(),
          onSearchResult: (result) {
            print(_getResultData(result));
          },
          child: SafeArea(
            child: _buildStatementScreenView(),
          ),
        ),
      );

  Widget _buildStatementScreenView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30),
                    NameNumberWidget(
                        retailerName: widget.outletInfo?.contactPersonName!,
                        number: widget.outletInfo?.mobileNumber!),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(
                            AppStyles.pageSideMargin,
                            20,
                            AppStyles.pageSideMargin,
                            20),
                        child: _totalAmountWidget()),
                    _transactionsListview(),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ),
          ),
          _bottomButtonView(),
        ],
      );

  Widget _invoiceValueAndMailIconView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            AppStrings.lblInvoiceValue,
            style: TextStyle(
              fontSize: 12,
              fontWeight: AppFonts.extraBold,
            ),
          ),
          const Text(
            '${AppStrings.inr} 25000',
            style: TextStyle(
              fontSize: 12,
              fontWeight: AppFonts.extraBold,
            ),
          ),
          Container(
            height: 30,
            width: 55,
            alignment: Alignment.centerLeft,
            child: SvgPicture.asset(
              AppAssets.icEmail,
              height: 25,
              width: 25,
            ),
          ),
        ],
      );

  Widget _devider() => Container(
        color: AppColors.border,
        height: 1,
      );

  Widget _transactionsListview() => ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.orderInvoice?.invoiceStatementItems != null
          ? widget.orderInvoice!.invoiceStatementItems!.length
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
                    margin: EdgeInsets.fromLTRB(AppStyles.pageSideMargin,
                        Get.width * .015, AppStyles.pageSideMargin, 0),
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
                              '${getDateAndMonthFromDateTime(widget.orderInvoice!.invoiceStatementItems![index].createdOn!)}',
                              style: CustomTextStyle.imageDetailsTextStyle,
                            ),
                            Text(
                              'INR ${widget.orderInvoice!.invoiceStatementItems![index].amount?.toStringAsFixed(2)}',
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
                          right: Get.width * .07, top: Get.width * .17),
                      child: appCommonRoundedButton(
                          btnTxt: AppStrings.lblReceipt, onPressed: () {}),
                    ),
                  )
                ],
              ),
            ],
          ));

  Widget _bottomButtonView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: appCommonFlatButton(
              btnTxt: AppStrings.lblAccounts.toUpperCase(),
              isTopRightRounded: false,
              onPressed: _onAccount,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Expanded(
              child: appCommonFlatButton(
            btnTxt: AppStrings.lblViewInvoice.toUpperCase(),
            isTopLeftRounded: false,
            onPressed: _onViewInvoice,
          )),
        ],
      );

  void _onAccount() {
    Navigator.of(context).pop();
  }

  void _onViewInvoice() {
    Navigator.of(context).pop();
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Invoice Value',
                  style: CustomTextStyle.transactionTitleTextStyle,
                ),
                Text(
                  'INR ${calculatePrice(widget.orderInvoice!)}',
                  style: CustomTextStyle.transactionTitleTextStyle,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(16, 5, 10, 5),
                  height: 30,
                  width: 55,
                  alignment: Alignment.centerRight,
                  child: SvgPicture.asset(
                    AppAssets.icEmail,
                    height: 25,
                    width: 25,
                    color: AppColors.white,
                  ),
                ),
              ],
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
                    'Total Payment',
                    style: CustomTextStyle.transactionTitleTextStyle,
                  ),
                  Text(
                    'INR ${getTotalPaidAmount(widget.orderInvoice!)}',
                    style: CustomTextStyle.transactionTitleTextStyle,
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                    decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: Center(
                      child: Text(
                        'Receipt',
                        style: CustomTextStyle.switchPrimaryTextStyle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  String calculatePrice(OrderInvoiceMapping orderInvoiceMapping) {
    var price = 0.0;
    var totalTax = 0.0;
    for (final element in orderInvoiceMapping.secondaryInvoiceItems!) {
      price = price +
          ProductPriceCalculation.calculatePriceOfProduct(
              element.basePrice ?? 1, element.billQuantity?.toDouble() ?? 1);
      totalTax = totalTax +
          ProductPriceCalculation.calculateTotalTaxWithPrice(
              element.basePrice ?? 1,
              element.billQuantity?.toDouble() ?? 1,
              element.igst ?? 1,
          0.0);
    }

    return (price + totalTax).toStringAsFixed(2);
  }

  String getTotalPaidAmount(OrderInvoiceMapping orderInvoiceMapping) {
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
}
