import 'package:cygneto/blocs/cart/cart_bloc.dart';
import 'package:cygneto/ui/screens/no_order/no_order_radio_selection_view.dart';
import 'package:cygneto/ui/widgets/common_dropdown_addneworder_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../widgets/dash_line_divider.dart';
import 'cart_item_list_widget.dart';

enum OrderType { onsite, remote }

class CartListView extends StatefulWidget with UtilityMixin {
  CartListView({
    required this.orderList,
    required this.bloc,
    required this.schemeList,
    required this.onSchemeSelected,
    required this.radioSelection,
    this.discountOnProduct,
    this.billDiscount,
    this.warehouseId,
    this.isNavigateFromProductScreen,
    this.outletInfo,
    this.totalBaseAmount,
    this.totalTax,
    this.totalPayable,
    this.freeProductDetails,
  });

  final List<ProductWithPriceModel> orderList;
  final List<RadioSelectionItemModel> _radioSelectionList = [
    RadioSelectionItemModel('OnSite Order', isSelected: true, id: 1),
    RadioSelectionItemModel('Remote Order', id: 2),
  ];
  int? warehouseId;
  bool? isNavigateFromProductScreen = false;
  final CustomerDataItemsResponse? outletInfo;
  CartBloc bloc;
  double? totalBaseAmount = 0.0;
  double? totalTax = 0.0;
  double? totalPayable = 0.0;
  double? discountOnProduct= 0.0;
  double? billDiscount= 0.0;

  List<SchemeListDataResponse> schemeList;
  Function onSchemeSelected;
  Function radioSelection;
  ProductWithPriceModel? freeProductDetails;

  @override
  State<CartListView> createState() => _CartListViewState();
}

class _CartListViewState extends State<CartListView> {
  OrderType? _value = OrderType.onsite;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5,
            left: AppStyles.pageSideMargin,
            right: AppStyles.pageSideMargin,
            bottom: 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CartItemListWidget(
                orderList: widget.orderList,
                warehouseId: widget.warehouseId,
                isNavigateFromProductScreen: widget.isNavigateFromProductScreen,
                outletInfo: widget.outletInfo,
                bloc: widget.bloc,
                fromCart: true,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomDropDownAddNewOrderInput(
                labelText: AppStrings.lblSelectProductScheme,
                initialValue: null,
                items: widget.schemeList,
                iconPath: AppAssets.icDropDownArrow,
                onItemSelected: (value) {
                  widget.onSchemeSelected(value);
                },
              ),
              Visibility(
                visible: widget.freeProductDetails != null,
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
                        widget.freeProductDetails?.free_product_name ?? "",
                        style: CustomTextStyle.transactionTitleTextStyle,
                      ),
                      Row(
                        children: [
                          _TextField('${AppStrings.lblQty} ', null,
                              CustomTextStyle.transactionTitleTextStyle),
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.border),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Text(
                              '${widget.freeProductDetails?.free_product_quantity ?? ""}',
                              style: CustomTextStyle.receiptTextStyle,
                            ),
                          ),
                          Text(
                            "  ${widget.freeProductDetails?.free_product_uom_name}",
                            style: CustomTextStyle.receiptTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          NoOrderRadioSelectionView(
                            list: widget._radioSelectionList,
                            hasSpaceBetween: true,
                            fontSize: 12,
                            fontWeight: AppFonts.medium,
                            onTap: (selectedData) {
                              widget.radioSelection(selectedData);
                            },
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: _ProductText(
                              'Total Base Amount : ',
                              'INR ${widget.totalBaseAmount?.toStringAsFixed(2)}',
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _ProductText(
                            'Product Discount : ',
                            'INR ${widget.discountOnProduct?.toStringAsFixed(2)}',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _ProductText(
                            'Bill Discount : ',
                            'INR ${widget.billDiscount?.toStringAsFixed(2)}',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _ProductText(
                            'Tax Amount : ',
                            'INR ${widget.totalTax?.toStringAsFixed(2)}',
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
                          _ProductText(
                            'Payable Amount : ',
                            'INR ${widget.totalPayable?.toStringAsFixed(2)}',
                            style: CustomTextStyle.primaryBold11,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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

  Widget _ProductText(title, data,{style}) => Text(
        '$title$data',
        style: style??CustomTextStyle.smallTextStyle,
      );
}
