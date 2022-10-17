import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/order_item/order_item_bloc.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import '../../widgets/dash_line_divider.dart';
import '../accounts/accounts_screen.dart';
import '../add_new_order/product_price_calculation.dart';
import '../base/base_screen.dart';
import '../cart/cart_item_list_widget.dart';

class OrderItemScreen extends StatefulWidget {
  const OrderItemScreen(
      {required this.outletInfo,
      required this.orderId,
      required this.distributorId,
      Key? key})
      : super(key: key);

  final CustomerDataItemsResponse? outletInfo;
  final int orderId;
  final int distributorId;

  @override
  _OrderItemScreenState createState() => _OrderItemScreenState();
}

/// Created by Dev 2136 on 08/12/2021
/// Modified by Dev 2136 on 02/16/2022
/// Purpose : order item screen of the app
class _OrderItemScreenState extends State<OrderItemScreen> with UtilityMixin {
  List<ProductWithPriceModel> _orderList = [];
  late OrderItemBloc _bloc;
  DistributionData? distributionData;
  double totalBaseAmount = 0.0;
  double totalTax = 0.0;
  double totalPayable = 0.0;
  double totalDiscount = 0.0;
  double schemeDiscount = 0.0;
  SchemeListDataResponse? billScheme;

  @override
  Widget build(BuildContext context) => BaseScreen<OrderItemBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetOrderDataFromDB(orderId: widget.orderId));
      },
      builder: (context, bloc, child) => BlocListener<OrderItemBloc, BaseState>(
          listener: (context, state) {
            if (state is OrderDataSuccessState ||
                state is OrderDataFailedState) {
              _manageOrderDataState(state);
            } else if (state is DistributionObjectSuccessState ||
                state is DistributionObjectFailedState) {
              _manageDistributionObjectState(state);
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              hasBack: true,
              title: AppStrings.lblOrderItem,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        child: _buildOrderItemScreenView(),
                      ),
                    ),
                    _bottomButtonView(),
                  ],
                ),
              ),
            ),
          )));

  void _manageOrderDataState(state) {
    if (state is OrderDataSuccessState) {
      if (state.data != null) {
        state.data.forEach((v) {
          _orderList.add(ProductWithPriceModel.fromJsonForRowQuery(v));
        });
      }
      if (state.schemeData != null && state.schemeData.isNotEmpty) {
        billScheme = SchemeListDataResponse.fromJson(state.schemeData[0]);
      }
      _calculateTotalPayable();
      _bloc.add(GetDistributorName(distributorId: widget.distributorId));
    } else {
      _bloc.add(GetDistributorName(distributorId: widget.distributorId));
      Flushbar(
        title: AppStrings.lblFieldSales.toUpperCase(),
        message: state.msg ?? "",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  void _manageDistributionObjectState(state) {
    if (state is DistributionObjectSuccessState) {
      distributionData = state.data;
    } else {
      Flushbar(
        title: AppStrings.lblFieldSales.toUpperCase(),
        message: state.msg ?? "",
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  Widget _buildOrderItemScreenView() => Container(
        padding: const EdgeInsets.only(bottom: 10, top: 15),
        margin: const EdgeInsets.all(AppStyles.pageSideMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NameNumberWidget(
                retailerName: widget.outletInfo?.contactPersonName,
                number: widget.outletInfo?.mobileNumber),
            const SizedBox(
              height: 10,
            ),
            CartItemListWidget(
              orderList: _orderList,
              fromCart: false,
            ),
            _supplierView(distributionData?.businessName ?? ""),
            const SizedBox(
              height: 30,
            ),
            _finalAmountView(),
          ],
        ),
      );

  Widget _supplierView(String supplierName) => Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.border),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Text(
          supplierName,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: AppFonts.bold,
          ),
        ),
      );

  Widget _finalAmountView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              /*SvgPicture.asset(
                AppAssets.icTruck,
                color: AppColors.colorTruckImage,
                height: 43,
                width: 43,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                AppStrings.delivered,
                style: TextStyle(
                  color: AppColors.colorTruckImage,
                  fontWeight: AppFonts.extraBold,
                  fontSize: 11,
                ),
              ),*/
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Scheme Applied : ${billScheme?.name??"-"}',
                style: CustomTextStyle.blackNormal11,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${AppStrings.totalBaseAmount} : ${AppStrings.inr} ${totalBaseAmount?.toStringAsFixed(2)}',
                style: CustomTextStyle.blackNormal11,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Product Discount : ${AppStrings.inr} ${totalDiscount?.toStringAsFixed(2)}',
                style: CustomTextStyle.blackNormal11,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Bill Discount : ${AppStrings.inr} ${schemeDiscount.toStringAsFixed(2)}',
                style: CustomTextStyle.blackNormal11,
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                '${AppStrings.taxAmount} : ${AppStrings.inr} ${totalTax?.toStringAsFixed(2)}',
                style: CustomTextStyle.blackNormal11,
              ),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                width: Get.width * .5,
                child: const DashedDivider(
                  height: 1,
                  color: AppColors.lightGrayColor,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                '${AppStrings.payableAmount} : ${AppStrings.inr} ${totalPayable.toStringAsFixed(2)}',
                style: CustomTextStyle.primaryBold11,
              )
            ],
          ),
        ],
      );

  Widget _bottomButtonView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: appCommonFlatButton(
              btnTxt: AppStrings.lblHistory.toUpperCase(),
              isTopRightRounded: false,
              onPressed: _onHistoryTap,
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

  void _calculateTotalPayable() {
    var totalItems = 0.0;
    for (final element in _orderList) {
      totalItems = totalItems + (element.quantity ?? 0);
      totalBaseAmount = totalBaseAmount +
          ProductPriceCalculation.calculateTotalPrice(element);
      totalTax = totalTax + ProductPriceCalculation.calculateTotalTax(element);
      totalDiscount = totalDiscount +
          ProductPriceCalculation.calculateTotalDiscount(element);
    }
    if (billScheme != null && billScheme?.freeProductId == null) {
      schemeDiscount =
          (totalBaseAmount * (billScheme?.additionalDiscountPercent ?? 1)) /
              100;

    }

    totalPayable = ProductPriceCalculation.calculatePayableAmount(
        totalBaseAmount, totalDiscount+schemeDiscount, totalTax);
  }

  void _onHistoryTap() {
    Navigator.of(context).pop();
  }

  _onViewInvoice() async {
    await navigationWithAwaitPush(
        context,
        AccountsScreen(
          outletInfo: widget.outletInfo,
          orderId: widget.orderId,
        ));
    setState(() {});
  }
}
