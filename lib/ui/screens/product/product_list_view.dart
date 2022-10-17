import 'package:flutter/material.dart';

import '../../../blocs/product/product_bloc.dart';
import '../../../data/models/AvailableStock/available_stock_response.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../add_new_order/add_new_order.dart';
import 'product_details_widget.dart';

/// Created by Dev 2183 on 12/8/2021
/// Modified by Dev 2183 on 12/8/2021
/// Purpose : List View of products based on filter

class ProductListView extends StatefulWidget with UtilityMixin {
  const ProductListView(
      {required this.productNameList,
      required this.outletInfo,
      required this.bloc,
      required this.warehouseId,
      required this.distributorId,
      required this.updateState,
      this.availableStockResponse,
      Key? key})
      : super(key: key);
  final List<ProductWithPriceModel> productNameList;
  final CustomerDataItemsResponse? outletInfo;
  final ProductBloc bloc;
  final AvailableStockResponse? availableStockResponse;
  final int warehouseId;
  final int distributorId;
  final Function updateState;

  @override
  State<ProductListView> createState() => _ProductListViewState();
}

class _ProductListViewState extends State<ProductListView> with UtilityMixin {
  int? stockIndex;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: widget.productNameList.length,
          shrinkWrap: true,
          padding: const EdgeInsets.only(
            top: 10,
            left: AppStyles.pageSideMargin,
            right: AppStyles.pageSideMargin,
            bottom: 10,
          ),
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [Shadows.greyShadow],
              borderRadius: BorderRadius.circular(5),
            ),
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            child: ProductDetailsWidget(
              mrp: '${AppStrings.inr} ${widget.productNameList[index].mrp!}',
              price: '''
${AppStrings.inr} ${widget.productNameList[index].min_base_price} - ${widget.productNameList[index].max_base_price}''',
              productName: widget.productNameList[index].name!,
              qty: "100",
              productImage: "productNameList[index].image",
              infoVisibility: false,
              addOnTap: () async {
                await navigationWithAwaitPush(
                    context,
                    AddNewOrderScreen(
                      productDataFromIntent: widget.productNameList[index],
                      outletInfo: widget.outletInfo,
                      warehouseId: widget.warehouseId,
                    ));

                widget.updateState();
              },
              availableStock: widget.productNameList[index].availableStock,
              onStockTap: () {
                widget.bloc.add(GetAvailableStock(
                  warehouseId: widget.warehouseId,
                  productId: widget.productNameList[index].product_id ?? 0,
                  uoM: widget.productNameList[index].uom_1 ?? 0,
                ));
                stockIndex = index;
              },
            ),
          ),
        ),
      );
}
