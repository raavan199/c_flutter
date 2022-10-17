import 'package:cygneto/data/models/entities/sku_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/sacheme_list/scheme_list_data_response.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : custom dropdown widget
class CustomDropDownAddNewOrderInput extends StatefulWidget {
  CustomDropDownAddNewOrderInput(
      {required this.items,
      required this.iconPath,
      required this.onItemSelected,
      this.initialValue,
      this.labelText,
      Key? key})
      : super(key: key);
  final String? labelText;
  final SchemeListDataResponse? initialValue;
  final List<SchemeListDataResponse> items;
  final String iconPath;
  Function onItemSelected;

  @override
  State<CustomDropDownAddNewOrderInput> createState() =>
      _CustomDropDownAddNewOrderInputState();
}

class _CustomDropDownAddNewOrderInputState
    extends State<CustomDropDownAddNewOrderInput> {
  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<SchemeListDataResponse>(
        value: widget.initialValue,
        items: widget.items
            .map<DropdownMenuItem<SchemeListDataResponse>>(
                (schemaData) => DropdownMenuItem<SchemeListDataResponse>(
                      value: schemaData,
                      child: Text(schemaData.name!),
                    ))
            .toList(),
        onChanged: (schemaData) {
          print("selected schema:${schemaData!.name}");
          widget.onItemSelected(schemaData);
        },
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
