import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

/// Created by Dev 2183 on 02/18/2021
/// Modified by Dev 2183 on 02/18/2021
/// Purpose : custom dropdown widget
class CustomDropDownActivityRegisterType extends StatefulWidget {
  CustomDropDownActivityRegisterType(
      {required this.items,
        required this.activityType,
        this.initialValue,
        this.validator,
        Key? key})
      : super(key: key);
  ActivityRegisterTypeData? initialValue;
  List<ActivityRegisterTypeData>? items = [];
  final FormFieldValidator<ActivityRegisterTypeData>? validator;
  Function activityType;

  @override
  State<CustomDropDownActivityRegisterType> createState() =>
      _CustomDropDownActivityRegisterTypeState();
}

class _CustomDropDownActivityRegisterTypeState extends State<CustomDropDownActivityRegisterType> {
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<ActivityRegisterTypeData>(
    value: widget.initialValue,
    items: widget.items!
        .map<DropdownMenuItem<ActivityRegisterTypeData>>(
            (activityType) => DropdownMenuItem<ActivityRegisterTypeData>(
          value: activityType,
          child: Text(activityType.name!),
        ))
        .toList(),
    onChanged: (ActivityRegisterTypeData) {
      widget.activityType(ActivityRegisterTypeData);
    },
    validator: widget.validator,
    // value:ActivityRegisterTypeData,
    icon: SvgPicture.asset(
      AppAssets.icDropDownArrow,
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
      labelText: AppStrings.lblActivityType,
      labelStyle: const TextStyle(
          fontFamily: AppFonts.fontName,
          fontSize: 12,
          fontWeight: AppFonts.medium,
          overflow: TextOverflow.ellipsis,
          color: Colors.black),
    ),
  );

  OutlineInputBorder _inputBorder({Color? color}) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(
      color: color ?? AppColors.border,
    ),
  );
}
