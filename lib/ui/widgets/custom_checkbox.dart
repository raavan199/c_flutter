import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../themes/custom_text_style.dart';

/// Created by Dev 1051 on 7/15/2021
/// Modified by Dev 2301 on 8/3/2021
/// Purpose : Custom check box used to provide check box with the name.
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({
    required this.checkedValue,
    required this.toggleCheckBox,
    this.checkBoxName,
    this.activeColor,
    Key? key,
  }) : super(key: key);
  final String? checkBoxName;
  final bool checkedValue;
  final Function toggleCheckBox;
  final Color? activeColor;

  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) => Row(
        children: [
          Checkbox(
            value: widget.checkedValue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: widget.activeColor ?? AppColors.black,
            onChanged: (_) => widget.toggleCheckBox(),
          ),
          if (widget.checkBoxName != null)
            GestureDetector(
              onTap: () {
                widget.toggleCheckBox();
              },
              child: Text(
                widget.checkBoxName ?? "",
                style: CustomTextStyle.rememberMeTextStyle,
              ),
            ),
        ],
      );
}
