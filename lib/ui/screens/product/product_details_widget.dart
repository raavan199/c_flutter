import 'package:flutter/material.dart';

import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget(
      {required this.productName,
      required this.qty,
      this.availableStock,
      required this.price,
      required this.mrp,
      required this.productImage,
      this.infoVisibility = false,
      this.addOnTap,
      this.onStockTap,
      Key? key})
      : super(key: key);

  final String productName;
  final String qty;
  final double? availableStock;
  final String price;
  final String mrp;
  final String productImage;
  final bool infoVisibility;
  final VoidCallback? addOnTap;
  final VoidCallback? onStockTap;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              Container(
                width: 70,
                height: 70,
                margin: const EdgeInsets.only(right: 10),
                child: Image(
                    image: AssetImage(
                  productImage,
                )),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            productName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: CustomTextStyle.mobileNumberTextStyle,
                          ),
                        ),
                        Visibility(
                          visible: infoVisibility,
                          child: const SizedBox(
                            height: 16,
                            width: 16,
                            child: SvgImageView(
                              path: AppAssets.icInfo,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      qty,
                      style: CustomTextStyle.mobileNumberTextStyle,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MaterialButton(
                      elevation: 4,
                      color: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      onPressed: onStockTap,
                      child: Text(
                        availableStock == null
                            ? 'Avl. Stock'
                            : 'Avl. Stock : ${availableStock?.toStringAsFixed(2)}',
                        style: CustomTextStyle.buttonTextStyle,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price : $price',
                    style: CustomTextStyle.smallTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'MRP : ${mrp}',
                    style: CustomTextStyle.smallTextStyle,
                  ),
                ],
              ),
              MaterialButton(
                elevation: 4,
                color: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: addOnTap,
                child: Text(
                  AppStrings.lblAdd,
                  style: CustomTextStyle.buttonTextStyle,
                ),
              )
            ],
          )
        ],
      );
}
