import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/entities/sku_model.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

/// Created by Dev 2136 on 20/1/2022
/// Modified by Dev 2136 on 20/1/2022
/// Purpose : custom dropdown widget
class CustomDropDownUomList extends StatefulWidget {
  CustomDropDownUomList(
      {required this.items,
        required this.iconPath,
        required this.onItemSelected,
        this.initialValue,
        this.labelText,
        Key? key})
      : super(key: key);
  final String? labelText;
  final UOMModel? initialValue;
  final List<UOMModel> items;
  final String iconPath;
  Function onItemSelected;

  @override
  State<CustomDropDownUomList> createState() =>
      _CustomDropDownUomListState();
}

class _CustomDropDownUomListState
    extends State<CustomDropDownUomList> {
  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<UOMModel>(
        value: widget.initialValue,
        items: widget.items
            .map<DropdownMenuItem<UOMModel>>(
                (uomData) => DropdownMenuItem<UOMModel>(
              value: uomData,
              child: Text(uomData.name),
            ))
            .toList(),
        onChanged: (uomData) {
          widget.onItemSelected(uomData);
          print("selected schema:${uomData!.name}");
          /*widget.uomId(uomData.id);
          widget.uomName(uomData.name);*/
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
