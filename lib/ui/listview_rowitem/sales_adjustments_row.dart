import 'package:cygneto/constants/app_enums.dart';
import 'package:cygneto/exports/mixins.dart';
import 'package:cygneto/exports/resources.dart';
import 'package:cygneto/exports/utilities.dart';
import 'package:cygneto/exports/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/sales_return/sales_return_item.dart';

class SalesAdjustmentsRow extends StatelessWidget with UtilityMixin {
  SalesReturnItem data;
  VoidCallback? onPress;
  bool? isLableDisplay = false;

  SalesAdjustmentsRow({required this.data, this.onPress, this.isLableDisplay});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Stack(children: [
            Container(
              margin: EdgeInsets.only(top: Get.width * .015),
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [Shadows.greyShadow],
                  borderRadius: BorderRadius.circular(5),
                ),
                height: AppStyles.SalesAdjustCardHeight,
                padding: const EdgeInsets.fromLTRB(16,16,16,0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: Get.width * .15,
                          margin: const EdgeInsets.only(right: 10),
                          child: Text(
                            getDateAndMonthFromDateTime(data.returnDate ?? ""),
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: AppFonts.normal,
                                fontFamily: AppFonts.fontName),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            data.productName ?? "",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                                height: 1.1,
                                fontSize: 13,
                                fontWeight: AppFonts.normal,
                                color: AppColors.primary),
                          ),
                        ),
                        Container(
                          width: Get.width * .20,
                          padding: const EdgeInsets.only(right: 2),
                          margin: const EdgeInsets.only(left: 10),
                          child: Text(
                            getQuantity(),
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: AppFonts.normal,
                                fontFamily: AppFonts.fontName),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: data.rate != null && data.rate != 0.0,
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  height: Get.height * .031,
                  width: Get.width * .22,
                  margin: EdgeInsets.only(
                      right: Get.width * .010, top: Get.width * .17),
                  decoration: const BoxDecoration(
                      color: AppColors.accentYellow,
                      boxShadow: [Shadows.yellowShadow],
                      borderRadius: BorderRadius.all(Radius.circular(06))),
                  child: Center(
                    child: Text(
                      "INR ${data.rate}",
                      style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.white,
                          fontWeight: AppFonts.normal,
                          fontFamily: AppFonts.fontName),
                    ),
                  ),
                ),
              ),
            ),
            if (isLableDisplay == true)
              Align(
                alignment: Alignment.topRight,
                child: RequestStatusBadge(status: getApprovalStatus()),
              )
            else
              Container(),
          ]),
          const SizedBox(
            height: 15,
          )
        ],
      );

  String getQuantity() {
    var totalQuantity = 0.0;
    totalQuantity = totalQuantity + data.sellableQuantity!;
    if (data.damagedQuantity != null) {
      totalQuantity = totalQuantity + data.damagedQuantity!;
    }
    return "${totalQuantity.toStringAsFixed(2)}";
  }

  RequestStatus getApprovalStatus() {
    if (data.isApprove == true) {
      return RequestStatus.approved;
    } else if (data.isCancel == true) {
      return RequestStatus.cancelled;
    } else {
      return RequestStatus.pending;
    }
  }
}
