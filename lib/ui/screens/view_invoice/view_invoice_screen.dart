import 'dart:ffi';

import 'package:cygneto/exports/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/view_invoice/view_invoice_bloc.dart';
import '../../../data/models/customer/customer_data_items_response.dart';
import '../../../data/models/invoice/invoice_item.dart';
import '../../../data/models/invoice/order_invoice_mapping.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../themes/custom_text_style.dart';
import '../../widgets/dash_line_divider.dart';
import '../add_new_order/product_price_calculation.dart';
import '../base/base_screen.dart';

/// Created by Dev 2136 on 09/12/2021
/// Modified by Dev 2136 on 02/14/2022
/// Purpose : order history screen of the app
class ViewInvoiceScreen extends StatefulWidget {
  ViewInvoiceScreen({required this.selectedInvoice, this.outletInfo, Key? key})
      : super(key: key);

  final CustomerDataItemsResponse? outletInfo;
  OrderInvoiceMapping? selectedInvoice;
  List<InvoiceItem> invoiceItems = [];

  DistributionData? distributorData;

  @override
  _ViewInvoiceScreenState createState() => _ViewInvoiceScreenState();
}

class _ViewInvoiceScreenState extends State<ViewInvoiceScreen>
    with UtilityMixin {
  late ViewInvoiceBloc _bloc;
  double totalBaseAmount = 0.0;
  double totalTax = 0.0;
  double totalPayable = 0.0;
  double totalDiscount = 0.0;
  double billDiscount = 0.0;

  SchemeListDataResponse? billScheme;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BaseScreen<ViewInvoiceBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetInvoiceDetails(id: widget.selectedInvoice!.id));
        _bloc
            .add(GetSupplierDetails(id: widget.selectedInvoice!.distributorId));
      },
      builder: (context, bloc, child) =>
          BlocListener<ViewInvoiceBloc, BaseState>(
              listener: (context, state) {
                if (state is GetInvoiceItemsSuccessState) {
                  widget.invoiceItems.addAll(state.data);
                  for (var value in widget.invoiceItems) {
                    totalBaseAmount = totalBaseAmount +
                        ProductPriceCalculation.calculatePriceOfProduct(
                            value.basePrice ?? 0.0,
                            (value.billQuantity ?? 0).toDouble());

                    totalTax = totalTax +
                        ProductPriceCalculation.calculateTotalTaxWithPrice(
                            value.basePrice!,
                            value.billQuantity!.toDouble(),
                            value.igst!,
                            calculateTotalDiscount(value));

                   // totalPayable = totalPayable + calculatePayblePrice(value);

                    totalDiscount =
                        totalDiscount + calculateTotalDiscount(value);
                  }
                  if (state.billScheme != null && state.billScheme.isNotEmpty) {
                    billScheme = SchemeListDataResponse.fromJson(state.billScheme[0]);
                    if (billScheme?.freeProductId == null) {
                      billDiscount =
                          ((totalBaseAmount-totalDiscount) * (billScheme?.additionalDiscountPercent ?? 1)) /
                              100;
                    }
                  }
                  totalPayable=ProductPriceCalculation.calculatePayableAmount(
                      totalBaseAmount, totalDiscount+billDiscount, totalTax);

                } else if (state is GetInvoiceItemFailedState) {
                } else if (state is GetSupplierDetailsSuccessState) {
                  setState(() {
                    widget.distributorData = state.data;
                  });
                }
              },
              child: Scaffold(
                appBar: CustomAppBar(
                  hasBack: true,
                  title:
                      "${AppStrings.lblViewInvoice} - ${widget.selectedInvoice!.secondaryInvoiceSerialNumber}",
                ),
                body: CommonContainer(
                  hasTimer: true,
                  topLayout: CommonDetailedHeader(
                      hasExtraPadding: true,
                      outletName: widget.outletInfo!.businessName,
                      retailerType: widget.outletInfo!.customerTypeName,
                      retailerLocation: widget.outletInfo!.routeName,
                      date: DateFormat('dd/MM/yyyy').format(
                          getDateTimeFromString(widget.selectedInvoice!.date)),
                      screenName: ''),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: _buildOrderHistoryScreenView(),
                        ),
                      ),
                    ],
                  ),
                ),
              )));

  Widget _buildOrderHistoryScreenView() => Padding(
        padding:
            const EdgeInsets.only(top: 20, bottom: 15, right: 15, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NameNumberWidget(
                retailerName: widget.outletInfo!.contactPersonName,
                number: widget.outletInfo!.mobileNumber),
            const SizedBox(height: 15),
            _supplierDetails(),
            const SizedBox(
              height: 10,
            ),
            const DashedDivider(
              height: 1,
              color: AppColors.lightGrayColor,
            ),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: widget.invoiceItems.length,
              itemBuilder: (context, index) => _listViewItem(index),
            ),
            const SizedBox(
              height: 15,
            ),
            _finalAmountView()
          ],
        ),
      );

  Widget _listViewItem(int index) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [Shadows.greyShadow],
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.invoiceItems[index].name ?? "",
                    style: CustomTextStyle.imageDetailsTextStyle,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      _TextField('${AppStrings.lblQty} ', null),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.border),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Text(
                          '${widget.invoiceItems[index].billQuantity}',
                          style: CustomTextStyle.imageDetailsTextStyle,
                        ),
                      ),
                      Text(
                        ' ${widget.invoiceItems[index].uom_name}',
                        style: CustomTextStyle.smallTextStyle,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      _TextField(AppStrings.price,
                          '${widget.invoiceItems[index].basePrice} | '),
                      _TextField(
                          AppStrings.gst, '${widget.invoiceItems[index].igst}'),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  _TextField(AppStrings.lblScheme,
                      widget.invoiceItems[index].scheme_name ?? "-"),
                  const SizedBox(
                    height: 4,
                  ),
                  _TextField(AppStrings.lblAdditionalDiscount,
                      getAdditionalDiscountValue(widget.invoiceItems[index])),
                  const SizedBox(
                    height: 4,
                  ),
                  _TextField(AppStrings.lblAmount,
                      '${ProductPriceCalculation.calculatePriceOfProduct(widget.invoiceItems[index].basePrice ?? 0.0, (widget.invoiceItems[index].billQuantity ?? 0).toDouble())}'),
                  const SizedBox(
                    height: 4,
                  ),
                  _TextField(AppStrings.lblPayable,
                      '${calculatePayblePrice(widget.invoiceItems[index])}'),
                  const SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  String getAdditionalDiscountValue(InvoiceItem model) {
    if (model.discount != null && model.discount != 0) {
      var dis = ProductPriceCalculation.calculateDiscountValue(model.basePrice!,
          (model.discount)!.toDouble(), (model.billQuantity ?? 0).toDouble());
      return "${model.discount?.toStringAsFixed(2)}% (INR ${dis.toStringAsFixed(2)})";
    } else {
      return "-";
    }
  }

  Widget _supplierDetails() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _textWidget(
              'Supplier Details',
              CustomTextStyle.imageDetailsTextStyle.copyWith(
                  decoration: TextDecoration.underline, fontSize: 14)),
          const SizedBox(
            height: 5,
          ),
          _TextField('Name', widget.distributorData?.businessName),
          _TextField('Address', widget.distributorData?.fullAddress),
          _TextField('GST', widget.distributorData?.gstNumber),
        ],
      );

  Widget _TextField(String textTitle, String? value,
          [TextStyle? titleTextStyle, TextStyle? valueTextStyle]) =>
      Row(
        children: [
          _textWidget(textTitle,
              titleTextStyle ?? CustomTextStyle.imageDetailsTextStyle),
          const Text(' :  '),
          Visibility(
              visible: value != null,
              child: _textWidget(value ?? "",
                  titleTextStyle ?? CustomTextStyle.smallTextStyle))
        ],
      );

  Widget _textWidget(String text, TextStyle? style) =>
      Text(text, style: style ?? CustomTextStyle.smallTextStyle);

  Widget _finalAmountView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                AppAssets.icTruck,
                color: AppColors.colorTruckImage,
                height: 43,
                width: 43,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                getDeliveryStatusName(
                    widget.selectedInvoice?.deliveryStatus ?? 0),
                style: const TextStyle(
                  color: AppColors.colorTruckImage,
                  fontWeight: AppFonts.extraBold,
                  fontSize: 11,
                ),
              ),
            ],
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Scheme Applied : ${billScheme?.name??"-"}',
                  style: CustomTextStyle.blackNormal11,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${AppStrings.totalBaseAmount} : ${AppStrings.inr} $totalBaseAmount',
                  style: CustomTextStyle.blackNormal11,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Product Discount : ${AppStrings.inr} $totalDiscount',
                  style: CustomTextStyle.blackNormal11,
                ), const SizedBox(
                  height: 8,
                ),
                Text(
                  'Bill Discount : ${AppStrings.inr} $billDiscount',
                  style: CustomTextStyle.blackNormal11,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  '${AppStrings.taxAmount} : ${AppStrings.inr} $totalTax',
                  style: CustomTextStyle.blackNormal11,
                ),

                const SizedBox(
                  height: 15,
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
                  '${AppStrings.payableAmount} : ${AppStrings.inr} $totalPayable',
                  style: CustomTextStyle.primaryBold11,
                )
              ],
            ),
          ),
        ],
      );

  double calculatePayblePrice(InvoiceItem data) {
    return ProductPriceCalculation.calculatePayableAmount(
        ProductPriceCalculation.calculatePriceOfProduct(
            data.basePrice ?? 0.0, (data.billQuantity ?? 0).toDouble()),
        calculateTotalDiscount(data),
        ProductPriceCalculation.calculateTotalTaxWithPrice(
            data.basePrice!,
            data.billQuantity!.toDouble(),
            data.igst!,
            calculateTotalDiscount(data)));
  }

  static double calculateTotalDiscount(InvoiceItem data) {
    var discount = 0.0;
    var priceBeforeSchemeDiscount =
        ProductPriceCalculation.calculatePriceOfProduct(
            data.basePrice ?? 0.0, (data.billQuantity ?? 0).toDouble());

    if (data.discount != null && data.discount != 0.0) {
      discount = ProductPriceCalculation.calculateDiscountValue(
          data.basePrice ?? 0.0,
          data.discount!,
          (data.billQuantity ?? 0).toDouble());
      priceBeforeSchemeDiscount = priceBeforeSchemeDiscount - discount;
    }
    if (data.schemeId != null &&
        data.additionalDiscountPercent != null &&
        data.additionalDiscountPercent != 0.0) {
      var schemeDiscount =
          (priceBeforeSchemeDiscount * data.additionalDiscountPercent!) / 100;

      discount = discount + schemeDiscount;
    }

    return discount;
  }

  void _calculateTotalPayable() {
    var totalItems = 0.0;
    for (final element in widget.invoiceItems) {
      totalItems = totalItems + (element.billQuantity ?? 0);
      totalBaseAmount = totalBaseAmount +
          ProductPriceCalculation.calculatePriceOfProduct(
              element.basePrice ?? 0.0,
              (element.billQuantity ?? 0).toDouble());
      totalTax = totalTax +   ProductPriceCalculation.calculateTotalTaxWithPrice(
          element.basePrice!,
          element.billQuantity!.toDouble(),
          element.igst!,
          calculateTotalDiscount(element));
      totalDiscount = totalDiscount +
          calculateTotalDiscount(element);
    }
    if (billScheme != null && billScheme?.freeProductId == null) {
      billDiscount =
          (totalBaseAmount * (billScheme?.additionalDiscountPercent ?? 1)) /
              100;
    }

    totalPayable = ProductPriceCalculation.calculatePayableAmount(
        totalBaseAmount, totalDiscount+billDiscount, totalTax);
  }

}
