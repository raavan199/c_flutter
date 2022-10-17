import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../payment_collection/payment_collection_screen.dart';

class AccountRow extends StatefulWidget {
  String date, invoiceNumber, price;
  bool isPaid;
Function onPayTap;
Function onViewTap;
  AccountRow(
      {required this.date,
      required this.invoiceNumber,
      required this.price,
      required this.isPaid,
      required this.onPayTap,
      required this.onViewTap,
      Key? key})
      : super(key: key);

  @override
  _AccountRowState createState() => _AccountRowState();
}

class _AccountRowState extends State<AccountRow> with UtilityMixin {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Stack(children: [
            Container(
              margin: EdgeInsets.only(top: Get.width * .015),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [Shadows.greyShadow],
                  borderRadius: BorderRadius.circular(5),
                ),
                height: AppStyles.SalesAdjustCardHeight,
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.invoiceNumber,
                            style: CustomTextStyle.blackBold12TextStyle,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                AppAssets.icCalendar,
                                height: 12,
                                width: 12,
                                color: AppColors.txtTimeColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 5, right: 5, top: 2),
                                child: Text(widget.date,
                                    style: const TextStyle(
                                        color: AppColors.txtTimeColor,
                                        fontSize: 11,
                                        fontWeight: AppFonts.normal)),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Text(
                      widget.price,
                      style: CustomTextStyle.smallTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                height: Get.height * .04,
                width: Get.width * (!widget.isPaid?0.43:0.22),
                margin: EdgeInsets.only(
                    right: Get.width * .010, top: Get.width * .17),
                child: Row(
                  children: [
                    InkWell(
                      onTap:(){
                        widget.onViewTap();
                      },
                      child: Container(
                        width: Get.width * .20,
                        decoration: const BoxDecoration(
                            color: AppColors.green,
                            boxShadow: [Shadows.blueShadow],
                            borderRadius: BorderRadius.all(Radius.circular(30))),
                        child: Center(
                          child: Text(
                            'View',
                            style: CustomTextStyle.transactionTitleTextStyle,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Visibility(
                      visible: !widget.isPaid,
                      child: Container(
                        width: Get.width * .20,
                        child: appCommonRoundedButton(
                            btnTxt: AppStrings.lblPay,
                            onPressed: () {
                              widget.onPayTap();
                            }),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]),
          const SizedBox(
            height: 15,
          )
        ],
      );
}
