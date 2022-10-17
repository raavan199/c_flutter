import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/product_list/product_list_data_items_response.dart';
import '../../exports/resources.dart';
import '../../themes/custom_text_style.dart';

class CustomDropDownProductInput extends StatefulWidget {
  const CustomDropDownProductInput(
      {required this.items,
      required this.iconPath,
      required this.onChanged,
      required this.validator,
      this.initialValue,
      this.labelText,
      Key? key})
      : super(key: key);
  final String? labelText;
  final String? initialValue;
  final List<ProductListDataItemsResponse> items;
  final String iconPath;
  final Function onChanged;
  final FormFieldValidator<ProductListDataItemsResponse>? validator;

  @override
  State<CustomDropDownProductInput> createState() =>
      _CustomDropDownProductInputState();
}

class _CustomDropDownProductInputState
    extends State<CustomDropDownProductInput> {
  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<ProductListDataItemsResponse>(
        items: widget.items
            .map((value) => DropdownMenuItem<ProductListDataItemsResponse>(
                  value: value,
                  child: Text(value.name ?? ""),
                ))
            .toList(),
        onChanged: (data) {
          widget.onChanged(data);
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
