import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : custom dropdown widget
class CustomDropDownWarehouse extends StatefulWidget {
  const CustomDropDownWarehouse(
      {required this.items,
        required this.iconPath,
        required this.validator,
        this.initialValue,
        this.labelText,
        this.onItemSelected,
        Key? key})
      : super(key: key);
  final String? labelText;
  final String? initialValue;
  final List<WarehouseDataItemsResponse> items;
  final String iconPath;
  final Function? onItemSelected;
  final FormFieldValidator<WarehouseDataItemsResponse>? validator;

  @override
  State<CustomDropDownWarehouse> createState() => _CustomDropDownWarehouseState();
}

class _CustomDropDownWarehouseState extends State<CustomDropDownWarehouse> {
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<WarehouseDataItemsResponse>(
    items: widget.items
        .map((value) => DropdownMenuItem<WarehouseDataItemsResponse>(
      value: value,
      child: Text(value.name??""),
    ))
        .toList(),
    onChanged: (selectedValue) {
      if (widget.onItemSelected != null) {
        widget.onItemSelected!(selectedValue);
      }
    },
    validator: widget.validator,
    icon: SvgPicture.asset(
      widget.iconPath,
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
        labelText: widget.labelText,
        labelStyle: widget.labelText != null
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
