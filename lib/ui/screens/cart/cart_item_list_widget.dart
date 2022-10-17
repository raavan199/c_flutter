import 'package:cygneto/ui/screens/add_new_order/product_price_calculation.dart';
import 'package:cygneto/ui/widgets/dash_line_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../blocs/cart/cart_bloc.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../mixins/utility_mixin.dart';
import '../../widgets/custom_dialog.dart';
import '../add_new_order/add_new_order.dart';

class CartItemListWidget extends StatefulWidget {
  CartItemListWidget({
    required this.orderList,
    this.fromCart,
    this.bloc,
    this.tapOnCell,
    this.warehouseId,
    this.isNavigateFromProductScreen,
    this.outletInfo,
    Key? key,
  }) : super(key: key);

  final List<ProductWithPriceModel> orderList;
  bool? fromCart;
  final VoidCallback? tapOnCell;
  int? warehouseId;
  bool? isNavigateFromProductScreen = false;
  final CustomerDataItemsResponse? outletInfo;
  CartBloc? bloc;

  @override
  State<StatefulWidget> createState() => _CartItemListWidgetState();
}

class _CartItemListWidgetState extends State<CartItemListWidget>
    with UtilityMixin {
  @override
  Widget build(BuildContext context) => ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: widget.orderList.length,
        itemBuilder: (context, index) => _listViewItem(index),
      );

  Widget _listViewItem(int index) => InkWell(
        onTap: () {
          if (widget.isNavigateFromProductScreen ?? false) {
            navigationPushReplacement(
                context,
                AddNewOrderScreen(
                  productDataFromIntent: widget.orderList[index],
                  warehouseId: widget.warehouseId,
                  outletInfo: widget.outletInfo,
                  cameFromCart: true,
                ));
          } else {
            Navigator.of(context).pop(widget.orderList[index]);
          }
        },
        child: Container(
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
                      widget.orderList[index].name ?? "",
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
                            '${widget.orderList[index].quantity?.toStringAsFixed(2)}',
                            style: CustomTextStyle.imageDetailsTextStyle,
                          ),
                        ),
                        Text(
                          ' ${widget.orderList[index].selected_uom}',
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
                            'INR ${widget.orderList[index].entered_price?.toStringAsFixed(2)} | '),
                        _TextField(AppStrings.gst,
                            '${widget.orderList[index].igst?.toStringAsFixed(2)}%'),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    _TextField(AppStrings.lblScheme,
                        widget.orderList[index].scheme_name ?? "-"),
                    const SizedBox(
                      height: 4,
                    ),
                    _TextField(AppStrings.lblAdditionalDiscount,
                        getAdditionalDiscountValue(widget.orderList[index])),
                    const SizedBox(
                      height: 4,
                    ),
                    _TextField(AppStrings.lblAmount,
                        "INR ${ProductPriceCalculation.calculateTotalPrice(widget.orderList[index]).toStringAsFixed(2)}"),
                    const SizedBox(
                      height: 4,
                    ),
                    _TextField(AppStrings.lblPayable,
                        "INR ${ProductPriceCalculation.calculatePayableAmount(ProductPriceCalculation.calculateTotalPrice(widget.orderList[index]), ProductPriceCalculation.calculateTotalDiscount(widget.orderList[index]), ProductPriceCalculation.calculateTotalTax(widget.orderList[index])).toStringAsFixed(2)}"),
                    const SizedBox(
                      height: 4,
                    ),
                    Visibility(
                      visible: widget.orderList[index].free_product_id != null,
                      child: Container(
                        margin: EdgeInsets.only(top: Get.width * .015),
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          boxShadow: const [Shadows.blueShadow],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _textWidget(AppStrings.lblFreeProduct,
                                CustomTextStyle.screenHeaderTextStyle),
                            Text(
                              widget.orderList[index].free_product_name ?? "",
                              style: CustomTextStyle.transactionTitleTextStyle,
                            ),
                            Row(
                              children: [
                                _TextField('${AppStrings.lblQty} ', null,
                                    CustomTextStyle.transactionTitleTextStyle),
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.border),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5)),
                                  ),
                                  child: Text(
                                    '${widget.orderList[index].free_product_quantity ?? ""}',
                                    style: CustomTextStyle.receiptTextStyle,
                                  ),
                                ),
                                Text(
                                  "  ${widget.orderList[index].free_product_uom_name}",
                                  style: CustomTextStyle.receiptTextStyle,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              if (widget.fromCart ?? false)
                InkWell(
                  onTap: () {
                    showDeleteConfirmationDialog(index);
                  },
                  child: Icon(
                    Icons.delete,
                    color: AppColors.colorError,
                  ),
                ),
            ],
          ),
        ),
      );

  _onDeleteItemYesClick(index) {
    widget.bloc?.add(DeleteProductFromCart(
        id: widget.orderList[index].id ?? 0, index: index));
  }

  showDeleteConfirmationDialog(index) {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              content: AppStrings.msgAreYouSure,
              title: AppStrings.lblDelete,
              yes: AppStrings.lblYes,
              no: AppStrings.lblNo,
              yesOnPressed: () {
                _onDeleteItemYesClick(index);
              },
              noOnPressed: () {
                Navigator.of(context).pop(false);
                print('alert dialog no clicked');
              },
            ));
  }

  String getAdditionalDiscountValue(ProductWithPriceModel model) {
    var discount = ProductPriceCalculation.calculateAdditionalDiscount(model);
    if (discount == 0) {
      return " - ";
    } else {
      return "${model.discount?.toStringAsFixed(2)}% (INR ${discount.toStringAsFixed(2)})";
    }
  }

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

  Widget _textWidget(String text, TextStyle? style) => Text(
        text,
        style: style ?? CustomTextStyle.smallTextStyle,
        maxLines: 2,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
      );

  deleteOrderFromList(int id) {}
}
