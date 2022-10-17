import 'package:flutter/material.dart';

import '../../exports/resources.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : custom radio button widget

class CustomRadioWidget extends StatelessWidget {
  const CustomRadioWidget({
    required this.value,
    required this.onChanged,
    required this.radioSelection,
    this.labelText,
    this.fontSize,
    this.fontWeight,
    this.height,
    this.isHorizontal = true,
    Key? key,
  }) : super(key: key);
  final bool value;
  final String? labelText;
  final ValueChanged<bool> onChanged;
  final bool radioSelection;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double? height;
  final bool? isHorizontal;

  @override
  Widget build(BuildContext context) {
    const colorChecked = AppColors.primary;
    const colorUnChecked = AppColors.white;
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          switch (value) {
            case false:
              onChanged(true);
              break;
            case true:
              onChanged(false);
              break;
            default: // case null:
              onChanged(false);
              break;
          }
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: value == true ? colorChecked : colorUnChecked,
                border: Border.all(color: colorChecked),
                borderRadius: BorderRadius.circular(10),
              ),
              height: 16,
              width: 16,
              child: Visibility(
                visible: value,
                child: const Icon(
                  Icons.done,
                  size: 11,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            if (labelText != null && !isHorizontal!)
              Expanded(
                child: Text(
                  labelText ?? "",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.justify,
                  maxLines: 5,
                  style: TextStyle(
                      fontSize: fontSize ?? 11,
                      fontWeight: fontWeight ?? AppFonts.medium),
                ),
              )
            else if (labelText != null)
              Text(
                labelText ?? "",
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                maxLines: 5,
                style: TextStyle(
                    fontSize: fontSize ?? 11,
                    fontWeight: fontWeight ?? AppFonts.medium),
              ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
      ),
    );
  }
}
