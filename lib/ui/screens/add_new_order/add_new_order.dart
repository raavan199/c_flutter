import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';

import '../../../blocs/add_new_order/add_new_order_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../data/models/AvailableStock/available_stock_response.dart';
import '../../../data/models/entities/sku_model.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import '../../widgets/common_dropdown_addneworder_input.dart';
import '../../widgets/custom_dropdown_uomlist.dart';
import '../../widgets/custom_number_input.dart';
import '../base/base_screen.dart';
import '../cart/cart_screen.dart';
import 'product_details_widget.dart';
import 'product_price_calculation.dart';

class AddNewOrderScreen extends StatefulWidget {
  AddNewOrderScreen(
      {required this.productDataFromIntent,
      this.outletInfo,
      this.warehouseId,
      this.cameFromCart,
      Key? key})
      : super(key: key);

  ProductWithPriceModel productDataFromIntent;
  ProductWithPriceModel productWithPriceModel = ProductWithPriceModel();
  final CustomerDataItemsResponse? outletInfo;
  final int? warehouseId;
  bool? cameFromCart = false;

  @override
  State<StatefulWidget> createState() => _AddNewOrderScreenState();
}

class _AddNewOrderScreenState extends State<AddNewOrderScreen>
    with UtilityMixin, ValidationMixin {
  final List<SKUModel> skuModel = [];
  List<UOMModel> uomList = [];
  late AddNewOrderBloc _bloc;
  List<ProductGroupItems> _productGroupItems = [];
  List<ProductCategoryListDataItemsResponse> _productCategory = [];
  List<UOMDataResponse> _uomDataResponse = [];
  String _groupName = "";
  String _subGroupName = "";
  String _categoryName = "";
  String _subCategoryName = "";
  late List<SchemeListDataResponse> schemaList = [];
  TextEditingController _quantity = TextEditingController();
  TextEditingController _price = TextEditingController();
  TextEditingController _discount = TextEditingController();
  int? _schemeId;
  String? _schemeName;
  int? _uomId;
  String? _uomName;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var _totalPrice;
  DateTime now = DateTime.now();
  AvailableStockResponse? _stockData;
  bool? cameFromCart = true;
  double totalAmount = 0;
  double totalPayableAmount = 0;
  List<ProductPricingItems> productPriceList = [];

  @override
  void initState() {
    super.initState();
    _discount.text = '0';
    widget.productWithPriceModel = copy(widget.productDataFromIntent);
    if (cameFromCart ?? false) {
      _updateValueWhenComeFromCart();
    }
  }

  _updateValueWhenComeFromCart() {
    if (widget.productWithPriceModel.quantity != null &&
        widget.productWithPriceModel.entered_price != null &&
        widget.productWithPriceModel.discount != null) {
      _quantity.text = '${widget.productWithPriceModel.quantity}';
      _price.text = '${widget.productWithPriceModel.entered_price}';
      _discount.text =
          '${(widget.productWithPriceModel.discount)?.toStringAsFixed(3)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    _price.text = '${widget.productWithPriceModel.max_base_price}';
    return BaseScreen<AddNewOrderBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(const GetProductListCart());
      },
      builder: (context, bloc, child) =>
          BlocListener<AddNewOrderBloc, BaseState>(
        listener: (context, state) {
          if (state is GetProductSuccessState ||
              state is GetProductFailedState) {
            _manageProductState(state);
          }
          if (state is UomSuccessState || state is UomFailedState) {
            _manageUomState(state);
          } else if (state is ProductSchemaSuccessState ||
              state is ProductSchemaFailedState) {
            _manageProductSchemeState(state);
          } else if (state is GroupSuccessState || state is GroupFailedState) {
            _manageGroupState(state);
          } else if (state is CategorySuccessState ||
              state is CategoryFailedState) {
            _manageCategoryState(state);
          } else if (state is SuccessState || state is FailedState) {
            _manageAddInCartState(state);
          } else if (state is StockSuccessState || state is StockFailedState) {
            _manageStockState(state);
          } else if (state is GetProductPriceSuccessState) {
            productPriceList = state.data;
            updatedProductPrice();
          } else if (state is GetProductPriceFailedState) {
          } else if (state is GetFreeProductSuccessState) {
            if (state.data.isNotEmpty) {
              widget.productWithPriceModel.free_product_uom_name =
                  state.data[0]["uom_name"] as String;
              widget.productWithPriceModel.free_product_name =
                  state.data[0]["name"] as String;
            }
          } else if (state is GetFreeProductFailedState) {}
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: AppStrings.lblNewOrder,
            hasBack: true,
          ),
          drawer: const AppDrawer(
            selectedIndex: 3,
          ),
          body: SafeArea(
            child: CommonContainer(
              hasTimer: true,
              topLayout: CommonDetailedHeader(
                hasExtraPadding: true,
                screenName: 'New Order',
                outletName: widget.outletInfo?.businessName,
                retailerLocation: widget.outletInfo?.routeName,
                retailerType: widget.outletInfo?.customerTypeName,
                date: DateFormat('dd/MM/yyyy').format(now),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                InkWell(
                                  onTap: () async {
                                    var tempData = await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CartScreen(
                                          outletInfo: widget.outletInfo,
                                        ),
                                      ),
                                    );
                                    setState(() {
                                      _bloc.add(GetUomListFromDB());
                                      widget.productWithPriceModel = tempData;
                                      _updateValueWhenComeFromCart();
                                    });
                                  },
                                  child: const SvgImageView(
                                    path: AppAssets.icCart,
                                    height: 23,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            ProductDetailsWidget(
                              productName:
                                  '${widget.productWithPriceModel.name ?? ""}',
                              qty: "500mg",
                              price: '''
          ${AppStrings.inr} ${widget.productWithPriceModel.min_base_price} - ${widget.productWithPriceModel.max_base_price}''',
                              mrp: '${widget.productWithPriceModel.mrp}',
                              availableStock:
                                  widget.productWithPriceModel.availableStock,
                              productImage: AppAssets.imgPlaceHolder,
                              bloc: _bloc,
                              productDetail: widget.productWithPriceModel,
                              warehouseId: widget.warehouseId,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: AppColors.border,
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                            ),
                            _skuList(),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: AppColors.border,
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            _categoryView(_groupName, _subGroupName,
                                _categoryName, _subCategoryName),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              color: AppColors.border,
                              height: 1,
                              width: MediaQuery.of(context).size.width,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            _productForm(),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  _ProductText(
                                    'Total Amount : ',
                                    '${totalAmount}',
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  _ProductText(
                                    'Total Payable Amount : ',
                                    '${totalPayableAmount}',
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  appCommonFlatButton(
                      btnTxt: AppStrings.lblAdd,
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.productWithPriceModel.discount =
                              double.parse(_discount.text);
                          widget.productWithPriceModel.entered_price =
                              double.parse(_price.text);
                          widget.productWithPriceModel.quantity =
                              double.parse(_quantity.text);
                          print(
                              'api product model========${widget.productWithPriceModel}');
                          _bloc.add(AddProductToCart(
                              productWithPriceModel:
                                  widget.productWithPriceModel));
                        }
                      })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _ProductText(title, data) => Text(
        '$title$data',
        style: CustomTextStyle.smallTextStyle,
      );

  _manageProductState(state) {
    if (state is GetProductSuccessState) {
      List<ProductWithPriceModel> tempData = state.data;
      tempData.forEach((element) {
        if (element.id == widget.productWithPriceModel.id) {
          widget.productWithPriceModel = element;
          _updateValueWhenComeFromCart();
        }
      });
      _bloc.add(GetUomListFromDB());
    } else {
      _bloc.add(GetUomListFromDB());
      Flushbar(
        title: AppStrings.lblFieldSales,
        message: AppStrings.msgDataNotAvailable,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  _manageUomState(state) {
    if (state is UomSuccessState) {
      skuModel.clear();
      uomList.clear();
      _uomDataResponse = state.data;
      if (widget.productWithPriceModel?.uom_1 != 0) {
        final uom1Details = _uomDataResponse.firstWhere(
            (element) => element.id == widget.productWithPriceModel?.uom_1);
        final uom2Details = _uomDataResponse.firstWhere(
            (element) => element.id == widget.productWithPriceModel?.uom_2);
        skuModel.add(SKUModel(
            type: uom1Details.uoMName ?? "",
            subType: '${widget.productWithPriceModel?.uom_2_value} '
                '${uom2Details.uoMName ?? ""}'));
        if (widget.productWithPriceModel?.is_sellable_uom1 == 1) {
          uomList.add(UOMModel(
              id: uom1Details.id ?? 0, name: uom1Details.uoMName ?? ""));
          _uomId = uom1Details.id ?? 0;
        }
        if (widget.productWithPriceModel?.uom_3 != 0) {
          var uom3Details = _uomDataResponse.firstWhere(
              (element) => element.id == widget.productWithPriceModel?.uom_3);
          skuModel.add(SKUModel(
              type: uom2Details.uoMName ?? "",
              subType: '${widget.productWithPriceModel?.uom_3_value} '
                  '${uom3Details.uoMName ?? ""}'));
          if (widget.productWithPriceModel?.uom_4 !=null && widget.productWithPriceModel?.uom_4 != 0) {
            var uom4Details = _uomDataResponse.firstWhere(
                (element) => element.id == widget.productWithPriceModel?.uom_4);
            skuModel.add(SKUModel(
                type: uom3Details.uoMName ?? "",
                subType: uom4Details.uoMName ?? ""));
          }
          if (widget.productWithPriceModel?.is_sellable_uom2 == 1) {
            uomList.add(UOMModel(
                id: uom2Details.id ?? 0, name: uom2Details.uoMName ?? ""));
            if (uomList.isEmpty) {
              _uomId = uom2Details.id ?? 0;
            } else {}
          }
        }
      }
      _bloc.add(GetGroupListFromDB());
    } else {
      _bloc.add(GetGroupListFromDB());
      Flushbar(
        title: AppStrings.lblFieldSales,
        message: AppStrings.msgDataNotAvailable,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  _manageProductSchemeState(state) {
    if (state is ProductSchemaSuccessState) {
      schemaList = [];
      state.data.forEach((element) {
        schemaList.add(SchemeListDataResponse.fromJson(element));
      });
      print("schema list:${schemaList.length}");
    } else {
      showSnackBar(context, state.msg ?? "");
    }
  }

  _manageGroupState(state) {
    if (state is GroupSuccessState) {
      _productGroupItems = state.data;
      if (widget.productWithPriceModel.group_id != null) {
        _groupName = (_productGroupItems.firstWhere((element) =>
                element.id == widget.productWithPriceModel.group_id)).name ??
            "";
      }
      if (widget.productWithPriceModel.sub_group_id != null) {
        _subGroupName = (_productGroupItems.firstWhere((element) =>
                    element.id == widget.productWithPriceModel.sub_group_id))
                .name ??
            "";
      }
      _bloc.add(GetCategoryListFromDB());
    } else {
      _bloc.add(GetCategoryListFromDB());
      Flushbar(
        title: AppStrings.lblFieldSales,
        message: AppStrings.msgDataNotAvailable,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  _manageCategoryState(state) {
    if (state is CategorySuccessState) {
      _productCategory = state.data;
      if (widget.productWithPriceModel.category_id != null) {
        _categoryName = (_productCategory.firstWhere((element) =>
                element.id == widget.productWithPriceModel.category_id)).name ??
            "";
      }
      if (widget.productWithPriceModel.sub_category_id != null) {
        _subCategoryName = (_productCategory.firstWhere((element) =>
                    element.id == widget.productWithPriceModel.sub_category_id))
                .name ??
            "";
      }
      _bloc.add(GetProductPrice(productId: widget.productWithPriceModel.id!));
    } else {
      _bloc.add(GetProductPrice(productId: widget.productWithPriceModel.id!));
      Flushbar(
        title: AppStrings.lblFieldSales,
        message: AppStrings.msgDataNotAvailable,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  _manageAddInCartState(state) {
    if (state is SuccessState) {
      Navigator.of(context).pop();
      showCustomFlushBar(context, AppStrings.msgAddToCartSuccess);
    } else {
      Flushbar(
        title: AppStrings.lblFieldSales,
        message: state.msg,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  _manageStockState(state) {
    if (state is StockSuccessState) {
      _stockData = state.data;
      widget.productWithPriceModel.availableStock = _stockData?.data;
    } else {
      Flushbar(
        title: AppStrings.lblFieldSales,
        message: state.msg,
        duration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  Widget _skuList() => ListView.builder(
      shrinkWrap: true,
      itemCount: skuModel.length,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Align(
                  child: _skuTitleText(skuModel[index].type),
                ),
                Expanded(
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: _skuText(skuModel[index].subType))),
              ],
            ),
          ));

  Widget _skuTitleText(title) => _textWidget(
        title,
        CustomTextStyle.imageDetailsTextStyle,
      );

  Widget _skuText(type) => _textWidget(
        type,
        CustomTextStyle.smallTextStyle,
      );

  Widget _totalPriceTitleText(title) => _textWidget(
        title,
        CustomTextStyle.imageDetailsTextStyle,
      );

  Widget _totalPriceText(price) => _textWidget(
        price,
        CustomTextStyle.smallTextStyle,
      );

  Widget _textWidget(String text, TextStyle? style) =>
      Text(text, style: style ?? CustomTextStyle.smallTextStyle);

  Widget _titleText(text) => _textWidget(
        text,
        CustomTextStyle.imageDetailsTextStyle,
      );

  Widget _categoryView(group, subGroup, category, subCategory) => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [_titleText(AppStrings.group), _skuText(group)],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    _titleText(AppStrings.subGroup),
                    _skuText(subGroup)
                  ],
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [_titleText(AppStrings.category), _skuText(category)],
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  _titleText(AppStrings.subCategory),
                  _skuText(subCategory)
                ],
              ),
            ],
          )
        ],
      );

  Widget _productForm() => Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 22,
                child: CustomNumberInputField(
                  validator: (value) =>
                      requiredQuantityFieldValidation(value!) != ""
                          ? requiredQuantityFieldValidation(value)
                          : null,
                  controller: _quantity,
                  inputType: TextInputType.number,
                  labelText: 'Enter Qty.',
                  onChanged: (value) {
                    calculateTotalPrice();
                  },
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 22,
                child: CustomDropDownUomList(
                  labelText: AppStrings.lblUom,
                  initialValue: uomList.isNotEmpty ? _passUomValue() : null,
                  items: uomList,
                  iconPath: AppAssets.icDropDownArrow,
                  onItemSelected: (value) {
                    _uomName = (value as UOMModel).name;
                    widget.productWithPriceModel.selected_uom = _uomName;
                    _uomId = (value as UOMModel).id;
                    widget.productWithPriceModel.selected_uom_id = _uomId;
                    updatedProductPrice();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 22,
                child: CustomNumberInputField(
                  validator: (value) => requiredFieldWithPriceValidation(
                              value!,
                              widget.productWithPriceModel.min_base_price ??
                                  0.0,
                              widget.productWithPriceModel.max_base_price ??
                                  0.0) !=
                          ""
                      ? requiredFieldWithPriceValidation(
                          value!,
                          widget.productWithPriceModel.min_base_price ?? 0.0,
                          widget.productWithPriceModel.max_base_price ?? 0.0)
                      : null,
                  controller: _price,
                  enabled: false,
                  inputType: TextInputType.number,
                  labelText: 'Enter Price',
                  onChanged: (value) {
                    calculateTotalPrice();
                  },
                ),
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width / 2) - 22,
                child: CustomNumberInputField(
                  validator: (value) => requiredFieldWithDiscountValidation(
                              value!,
                              widget.productWithPriceModel.min_base_price ??
                                  0.0,
                              widget.productWithPriceModel.max_base_price ??
                                  0.0) !=
                          ""
                      ? requiredFieldWithDiscountValidation(
                          value!,
                          widget.productWithPriceModel.min_base_price ?? 0.0,
                          widget.productWithPriceModel.max_base_price ?? 0.0)
                      : null,
                  controller: _discount,
                  inputType: TextInputType.number,
                  labelText: 'Discount',
                  onChanged: (value) {
                    calculateTotalPrice();
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomDropDownAddNewOrderInput(
            labelText: AppStrings.lblSelectProductScheme,
            initialValue: schemaList.isNotEmpty ? _passSchemeValue() : null,
            items: schemaList,
            iconPath: AppAssets.icDropDownArrow,
            onItemSelected: (value) {
              resetScheme();
              _schemeId = (value as SchemeListDataResponse).id;
              widget.productWithPriceModel.selected_scheme_id = _schemeId;
              _schemeName = value.name;
              widget.productWithPriceModel.scheme_name = _schemeName;
              applySchemeOnProduct(value);
            },
          ),
          const SizedBox(
            height: 15,
          ),
          /*Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _totalPriceTitleText('Total Price : '),
              _totalPriceText(_totalPrice ?? '0'),
            ],
          ),*/
        ],
      ));

  void updatedProductPrice() {
    if (_uomId == null) {
      return;
    }
    final selectedAddress = widget.outletInfo!.customerAddress
        ?.firstWhere((element) => element.isDefaultAddress == true);
    var updatedPriceData = ProductPriceCalculation.calculateProductPrice(
        widget.productWithPriceModel.id!,
        productPriceList,
        widget.outletInfo!,
        selectedAddress!,
        _uomId ?? 0);
    setState(() {
      widget.productWithPriceModel.igst = updatedPriceData!.igst;
      widget.productWithPriceModel.cgst = updatedPriceData.cgst;
      widget.productWithPriceModel.sgst = updatedPriceData.sgst;
      widget.productWithPriceModel.mrp = updatedPriceData.mrp;
      widget.productWithPriceModel.min_base_price =
          updatedPriceData.minBasePrice;
      widget.productWithPriceModel.max_base_price =
          updatedPriceData.maxBasePrice;
      _price.text = '${widget.productWithPriceModel.max_base_price}';
    });

    calculateTotalPrice();
  }

  void applySchemeOnProduct(SchemeListDataResponse value) {
    if (value.freeProductId != null) {
      if (value.minOrderQnty != null &&
          value.maxOrderQnty != null &&
          value.maxOrderQnty != 0) {
        final freeProductQuantity =
            (int.parse(_quantity!.text) / value.complementaryQntyPercent!)
                .round();
        widget.productWithPriceModel.free_product_quantity =
            freeProductQuantity;
      } else if (value.minTotalValue != null &&
          value.maxTotalValue != null &&
          value.maxTotalValue != 0) {
        final freeProductQuantity =
            (totalAmount / value.complementaryQntyPercent!).round();
        widget.productWithPriceModel.free_product_quantity =
            freeProductQuantity;
      }
      widget.productWithPriceModel.free_product_id = value.freeProductId!;
      widget.productWithPriceModel.free_product_uom = value.complementaryUOM;
      _bloc.add(GetFreeProduct(
          productId: value.freeProductId!, uomId: value.complementaryUOM!));
    } else {
      widget.productWithPriceModel.scheme_discount =
          value.additionalDiscountPercent;
      calculateTotalPrice();
    }
  }

  void calculateTotalPrice() {
    if (_quantity!.text.isNotEmpty && _price!.text.isNotEmpty) {
      widget.productWithPriceModel.quantity = double.parse(_quantity!.text);
      widget.productWithPriceModel.entered_price = double.parse(_price!.text);
      widget.productWithPriceModel.discount =
          _discount.text.isNotEmpty ? double.parse(_discount.text) : 0;

      setState(() {
        totalAmount = ProductPriceCalculation.calculateTotalPrice(
            widget.productWithPriceModel);
        totalPayableAmount = ProductPriceCalculation.calculatePayableAmount(
            totalAmount,
            ProductPriceCalculation.calculateTotalDiscount(
                widget.productWithPriceModel),
            ProductPriceCalculation.calculateTotalTax(
                widget.productWithPriceModel));
      });
      _bloc.add(GetProductSchemaFromDB(
          id: widget.productWithPriceModel.id!,
          totalAmount: totalAmount,
          totalQuantity: int.parse(_quantity!.text),
          orderedUomId: widget.productWithPriceModel.selected_uom_id ?? 0));
    } else {
      totalAmount = 0;
      totalPayableAmount = 0;
    }
  }

  UOMModel? _passUomValue() {
    if (widget.cameFromCart ?? false) {
      final UOMModel? tempObject = uomList.firstWhereOrNull((element) =>
          widget.productWithPriceModel.selected_uom_id == element.id);
      widget.productWithPriceModel.selected_uom_id = tempObject?.id;
      widget.productWithPriceModel.selected_uom = tempObject?.name;
      return tempObject;
    }
    widget.productWithPriceModel.selected_uom_id = uomList[0]?.id;
    widget.productWithPriceModel.selected_uom = uomList[0]?.name;
    return uomList[0];
  }

  SchemeListDataResponse? _passSchemeValue() {
    final SchemeListDataResponse? tempObject = schemaList.firstWhereOrNull(
        (element) =>
            widget.productWithPriceModel.selected_scheme_id == element.id);
    return tempObject;
  }

  int _parseInt(String? value) {
    if (value != null && value.isNotEmpty) {
      return int.parse(value);
    } else {
      return 0;
    }
  }

  _calculateTotalPrice(String? quantity, String? price, String? discount) {
    _totalPrice =
        (_parseInt(quantity) * _parseInt(price)) - _parseInt(discount);
  }

  void resetScheme() {
    widget.productWithPriceModel.scheme_discount = null;
    widget.productWithPriceModel.free_product_uom_name = null;
    widget.productWithPriceModel.free_product_uom = null;
    widget.productWithPriceModel.free_product_name = null;
    widget.productWithPriceModel.free_product_quantity = null;
    widget.productWithPriceModel.scheme_name = null;
    widget.productWithPriceModel.selected_scheme_id = null;
    widget.productWithPriceModel.free_product_id = null;
  }

  ProductWithPriceModel copy(ProductWithPriceModel product) =>
      ProductWithPriceModel(
          id: product.id,
          name: product.name,
          product_code: product.product_code,
          group_id: product.group_id,
          sub_group_id: product.sub_group_id,
          category_id: product.category_id,
          sub_category_id: product.sub_category_id,
          scheme_id: product.scheme_id,
          hsn: product.hsn,
          cgst: product.cgst,
          sgst: product.sgst,
          igst: product.igst,
          uom_1: product.uom_1,
          uom_2: product.uom_2,
          uom_3: product.uom_3,
          uom_4: product.uom_4,
          uom_2_value: product.uom_2_value,
          uom_3_value: product.uom_3_value,
          is_sellable_uom1: product.is_sellable_uom1,
          is_sellable_uom2: product.is_sellable_uom2,
          // product price
          product_id: product.product_id,
          pricing_type: product.pricing_type,
          mrp: product.mrp,
          min_base_price: product.min_base_price,
          max_base_price: product.max_base_price,
          state_id: product.state_id,
          distributor_id: product.distributor_id,
          distributor_type: product.distributor_type,
          customer_id: product.customer_id,
          customer_type: product.customer_type,
          customer_category: product.customer_category,
          availableStock: product.availableStock,
          selected_scheme_id: product.selected_scheme_id,
          scheme_name: product.scheme_name,
          quantity: product.quantity,
          discount: product.discount,
          entered_price: product.entered_price,
          selected_uom_id: product.selected_uom_id,
          selected_uom: product.selected_uom,
          free_product_name: product.free_product_name,
          free_product_quantity: product.free_product_quantity,
          free_product_uom: product.free_product_uom,
          scheme_discount: product.scheme_discount,
          free_product_id: product.free_product_id,
          free_product_hsn: product.free_product_hsn,
          free_product_uom_name: product.free_product_uom_name);
}
