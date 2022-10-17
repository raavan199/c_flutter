import 'package:cygneto/data/models/outlet/customer_category_data_response.dart';
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
class CustomDropdownCategoryModifyOutlets extends StatefulWidget {
  CustomDropdownCategoryModifyOutlets(
      {required this.items,
      required this.iconPath,
      required this.category,
      this.customerDataItemsResponse,
      this.initialValue,
      this.labelText,
        this.validator,
      Key? key})
      : super(key: key);
  final String? labelText;
  final int? initialValue;
  final List<CustomerCategoryDataResponse>? items;
  final CustomerDataItemsResponse? customerDataItemsResponse;
  final String iconPath;
  Function category;
  final FormFieldValidator<int>? validator;

  @override
  State<CustomDropdownCategoryModifyOutlets> createState() =>
      _CustomDropdownCategoryModifyOutletsState();
}

class _CustomDropdownCategoryModifyOutletsState
    extends State<CustomDropdownCategoryModifyOutlets> {

  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<int>(
        value: widget.initialValue,
        items: widget.items
            ?.map<DropdownMenuItem<int>>(
                (customerCategory) =>
                    DropdownMenuItem<int>(
                      value: customerCategory.id,
                      child: Text(customerCategory.categoryName!),
                    ))
            .toList(),
        onChanged: (id) {
          widget.category(
              widget.items?.firstWhere((element) => element.id == id));
        },
        validator: widget.validator,
        icon: SvgPicture.asset(
          widget.iconPath,
          height: 12,
          width: 12,
        ),
        //value: customerTypeDataResponse,
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
