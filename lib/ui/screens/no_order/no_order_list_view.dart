import 'package:cygneto/data/models/no_order/no_order_type_data.dart';
import 'package:cygneto/exports/utilities.dart';
import 'package:flutter/material.dart';

import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import 'no_order_radio_selection_view.dart';

/// Created by Dev 2183 on 12/14/2021
/// Modified by Dev 2183 on 12/14/2021
/// Purpose : No Order Scrollable List View
class NoOrderListView extends StatefulWidget with UtilityMixin {
  NoOrderListView(
      {required this.addRemarks,
      required this.noOrderRadioList,
      this.outletInfo,
      Key? key})
      : super(key: key);

  final List<RadioSelectionItemModel> noOrderRadioList;
  final CustomerDataItemsResponse? outletInfo;
  Function addRemarks;

  @override
  State<NoOrderListView> createState() => _NoOrderListViewState();
}

class _NoOrderListViewState extends State<NoOrderListView> {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NameNumberWidget(
              retailerName: widget.outletInfo!.contactPersonName,
              number: widget.outletInfo!.mobileNumber),
          const SizedBox(
            height: 18,
          ),
          Text(
            'Select No-Order Reason',
            style: CustomTextStyle.calendarHeaderTextStyle,
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [Shadows.greyShadow],
              borderRadius:
                  BorderRadius.circular(AppStyles.commonCardCornerRadius),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: NoOrderRadioSelectionView(
              list: widget.noOrderRadioList,
              hasSpaceBetween: true,
              fontSize: 12,
              fontWeight: AppFonts.medium,
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          CustomTextInputField(
            labelText: "Remarks",
            maxLines: 2,
            onChanged: (value) {
              widget.addRemarks(value);
            },
          ),
        ],
      );
}
