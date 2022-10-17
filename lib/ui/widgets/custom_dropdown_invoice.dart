import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/invoice/order_invoice_mapping.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : custom dropdown widget
class CustomDropDownInvoice extends StatelessWidget {
  const CustomDropDownInvoice(
      {required this.items,
      required this.iconPath,
      this.initialValue,
      this.labelText,
      this.onItemSelected,
      Key? key})
      : super(key: key);
  final String? labelText;
  final OrderInvoiceMapping? initialValue;
  final List<OrderInvoiceMapping> items;
  final String iconPath;
  final Function? onItemSelected;

  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<int>(
        items: items
            .map((value) => DropdownMenuItem<int>(
                  value: value.id,
                  child: Text(value.secondaryInvoiceSerialNumber),
                ))
            .toList(),
        value: initialValue?.id,
        key: key,
        onChanged: (selectedValue) {
          if (onItemSelected != null) {
            onItemSelected!(selectedValue);
          }
        },
        icon: SvgPicture.asset(
          iconPath,
          height: 12,
          width: 12,
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        style: CustomTextStyle.inputFieldText,
        decoration: InputDecoration(
            isDense: true,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            focusedBorder: _inputBorder(),
            enabledBorder: _inputBorder(),
            errorBorder: _inputBorder(color: AppColors.red),
            focusedErrorBorder: _inputBorder(color: AppColors.red),
            labelText: labelText,
            labelStyle: labelText != null
                ? const TextStyle(
                    fontFamily: AppFonts.fontName,
                    fontSize: 12,
                    fontWeight: AppFonts.medium,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.black)
                : const TextStyle()),
      );

  OutlineInputBorder _inputBorder({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: color ?? AppColors.border,
        ),
      );
}
