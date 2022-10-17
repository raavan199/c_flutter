import 'package:flutter/widgets.dart';

import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../mixins/validation_mixin.dart';
import '../../widgets/custom_dropdown_invoice.dart';
import '../../widgets/custom_dropdown_product.dart';
import '../../widgets/custom_dropdown_return_reason.dart';
import '../../widgets/custom_dropdown_select_supplier.dart';
import '../../widgets/custom_dropdown_warehouse.dart';

class SalesReturnFormWidget extends StatefulWidget {
  List<ProductListDataItemsResponse> productList;
  List<SalesReturnReason> reasonList;
  List<DistributionData> distributorList;
  List<WarehouseDataItemsResponse> warehouseList;
  List<OrderInvoiceMapping> invoiceList;
  ProductListDataItemsResponse? product;
  Function selectedProduct;
  Function selectedWarehouse;
  Function selectedReason;
  Function selectedInvoice;
  Function selectedDistributor;
  Function selectedUOM;
  final TextEditingController batchNumberController;
  final TextEditingController damagedController;
  final TextEditingController sellableController;
  GlobalKey<FormState> formKey;

  SalesReturnFormWidget(
      {required this.productList,
      required this.reasonList,
      required this.warehouseList,
      required this.distributorList,
      required this.invoiceList,
      required this.selectedProduct,
      required this.selectedWarehouse,
      required this.selectedReason,
      required this.selectedInvoice,
      required this.selectedDistributor,
      required this.selectedUOM,
      required this.batchNumberController,
      required this.damagedController,
      required this.sellableController,
      required this.formKey,
      Key? key})
      : super(key: key);

  @override
  _SalesReturnFormWidgetState createState() => _SalesReturnFormWidgetState();
}

class _SalesReturnFormWidgetState extends State<SalesReturnFormWidget>
    with ValidationMixin {
  List<String> oumList = [];
  List<WarehouseDataItemsResponse> warehouseListBasedOnSelectedSupplier = [];

  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Column(
          children: [
            CustomDropDownProductInput(
              labelText: AppStrings.lblSalesReturnProduct,
              items: widget.productList,
              iconPath: AppAssets.icDropDownArrow,
              validator: (value) {
                if (value == null) {
                  return AppStrings.selectProductEmptyValidation;
                }
              },
              onChanged: (data) {
                final productItem = data as ProductListDataItemsResponse;
                widget.product = productItem;
                widget.selectedProduct(productItem);
                setState(() {
                  oumList = [];
                  if (productItem.isSellableUoM1 == true) {
                    oumList.add(productItem.uom1Name!);
                  }
                  if (productItem.isSellableUoM2 == true) {
                    oumList.add(productItem.uom2Name!);
                  }
                });
              },
            ),
            const SizedBox(
              height: 17,
            ),
            CustomTextInputField(
              labelText: AppStrings.lblBatchNumber,
              controller: widget.batchNumberController,
            ),
            const SizedBox(
              height: 17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: CustomTextInputField(
                    labelText: AppStrings.lblDamagedQuantity,
                    controller: widget.damagedController,
                    inputType: TextInputType.number,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: CustomTextInputField(
                    labelText: AppStrings.lblReturnQty,
                    controller: widget.sellableController,
                    inputType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value == "") {
                        return AppStrings.emptySellableValidation;
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 17,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: CustomDropDownInput(
                    labelText: AppStrings.lblUoM,
                    items: oumList,
                    iconPath: AppAssets.icDropDownArrow,
                    validator: (value) {
                      if (value == null) {
                        return AppStrings.emptyUOMValidation;
                      }
                    },
                    onItemSelected: (selectedUOM) {
                      if (widget.product?.uom1Name == selectedUOM) {
                        widget.selectedUOM(widget.product?.uoM1);
                      }
                      if (widget.product?.uom2Name == selectedUOM) {
                        widget.selectedUOM(widget.product?.uoM2);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: CustomDropDownInvoice(
                      labelText: AppStrings.lblSelectInvoice,
                      items: widget.invoiceList,
                      iconPath: AppAssets.icDropDownArrow,
                      onItemSelected: (invoice) {
                        widget.selectedInvoice(invoice);
                      }),
                )
              ],
            ),
            const SizedBox(
              height: 17,
            ),
            CustomDropDownReturnReasonInput(
              labelText: AppStrings.lblSelectReason,
              items: widget.reasonList,
              iconPath: AppAssets.icDropDownArrow,
              validator: (value) {
                if (value == null) {
                  return AppStrings.emptyReasonValidation;
                }
              },
              onChanged: (value) {
                widget.selectedReason(value);
              },
            ),
            const SizedBox(
              height: 17,
            ),
            CustomDropdownSelectSupplier(
              labelText: AppStrings.lblSelectDistributor,
              items: widget.distributorList,
              iconPath: AppAssets.icDropDownArrow,
              validator: (value) {
                if (value == null) {
                  return AppStrings.emptyDistributorValidation;
                }
              },
              selectedSupplier: (selectedSupplier) {
                widget.selectedDistributor(selectedSupplier);
                final filterdWarehouse = widget.warehouseList.where(
                    (element) => element.distributorId == selectedSupplier.id);
                if (filterdWarehouse.isNotEmpty) {
                  setState(() {
                    warehouseListBasedOnSelectedSupplier
                        .addAll(filterdWarehouse);
                  });
                }
              },
            ),
            const SizedBox(
              height: 17,
            ),
            CustomDropDownWarehouse(
              labelText: AppStrings.lblSelectSupplierWarehouse,
              items: warehouseListBasedOnSelectedSupplier,
              iconPath: AppAssets.icDropDownArrow,
              validator: (value) {
                if (value == null) {
                  return AppStrings.emptyWarehouseValidation;
                }
              },
              onItemSelected: (selectedWareHouse) {
                widget.selectedWarehouse(selectedWareHouse);
              },
            )
          ],
        ),
      );
}
