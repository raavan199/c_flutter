import 'package:flutter/material.dart';

import '../../../../../exports/resources.dart';
import '../../../../../exports/utilities.dart';
import '../../../../../exports/widgets.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : apply view in missed punch page
class ApplyMissedPunchView extends StatelessWidget {
  const ApplyMissedPunchView({
    required this.onApply,
    Key? key,
  }) : super(key: key);

  final VoidCallback onApply;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [Shadows.greyShadow],
                borderRadius:
                    BorderRadius.circular(AppStyles.commonCardCornerRadius),
              ),
              margin: const EdgeInsets.symmetric(
                  vertical: 15, horizontal: AppStyles.pageSideMargin),
              padding: const EdgeInsets.symmetric(
                  vertical: 25, horizontal: AppStyles.pageSideMargin),
              child: _applyView(),
            ),
            Positioned(
              bottom: 0,
              right: AppStyles.pageSideMargin,
              // width: 100,
              child: SizedBox(
                height: 30,
                child: appCommonRoundedButton(
                    btnTxt: AppStrings.lblApply, onPressed: onApply),
              ),
            )
          ],
        ),
      );

  Widget _applyView() => Form(
        key: key,
        child: Row(
          children: const [
            Expanded(
              child: CustomTextInputField(
                labelText: AppStrings.lblDate,
                inputType: TextInputType.datetime,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: CustomTextInputField(
                  labelText: AppStrings.lblHours,
                  inputType: TextInputType.datetime),
            ),
          ],
        ),
      );
}
