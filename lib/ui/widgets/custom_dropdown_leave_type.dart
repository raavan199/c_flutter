import 'package:cygneto/data/models/customer_type/customer_type_data_response.dart';
import 'package:cygneto/data/models/leave_type/leave_type_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/customer/customer_data_items_response.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : custom dropdown widget
class CustomDropDownLeaveType extends StatefulWidget {
  CustomDropDownLeaveType(
      {required this.items,
      required this.leaveType,
      this.initialValue,
      this.validator,
      Key? key})
      : super(key: key);
  LeaveTypeData? initialValue;
  List<LeaveTypeData>? items = [];
  final FormFieldValidator<LeaveTypeData>? validator;
  Function leaveType;

  @override
  State<CustomDropDownLeaveType> createState() =>
      _CustomDropDownLeaveTypeState();
}

class _CustomDropDownLeaveTypeState extends State<CustomDropDownLeaveType> {
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<LeaveTypeData>(
        value: widget.initialValue,
        items: widget.items!
            .map<DropdownMenuItem<LeaveTypeData>>(
                (leaveType) => DropdownMenuItem<LeaveTypeData>(
                      value: leaveType,
                      child: Text(leaveType.name!),
                    ))
            .toList(),
        onChanged: (leaveTypedata) {
          widget.leaveType(leaveTypedata);
        },
        validator: widget.validator,
        // value:LeaveTypeData,
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
          labelText: AppStrings.lblLeaveType,
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
