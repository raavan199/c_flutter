import 'package:cygneto/data/models/customer_type/customer_type_data_response.dart';
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
class CustomDropDownModifyOutlets extends StatefulWidget {
  CustomDropDownModifyOutlets(
      {required this.items,
      required this.iconPath,
      required this.customerType,
      this.customerDataItemsResponse,
      this.initialValue,
      this.labelText,
      this.validator,
      Key? key})
      : super(key: key);
  final String? labelText;
  int? initialValue;
  List<CustomerTypeDataResponse>? items = [];
  final CustomerDataItemsResponse? customerDataItemsResponse;
  final String iconPath;
  final FormFieldValidator<int>? validator;
  Function customerType;

  @override
  State<CustomDropDownModifyOutlets> createState() =>
      _CustomDropDownModifyOutletsState();
}

class _CustomDropDownModifyOutletsState
    extends State<CustomDropDownModifyOutlets> {
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<int>(
        value: widget.initialValue,
        items: widget.items!
            .map<DropdownMenuItem<int>>((customerType) => DropdownMenuItem<int>(
                  value: customerType.id,
                  child: Text(customerType.typeName!),
                ))
            .toList(),
        onChanged: (id) {
          widget.customerType(
              widget.items?.firstWhere((element) => element.id == id));
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
