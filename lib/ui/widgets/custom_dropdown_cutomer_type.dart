import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

class CustomDropdownCustomerType extends StatefulWidget {
  CustomDropdownCustomerType(
      {required this.items,
      required this.iconPath,
      required this.customerType,
      this.validator,
      this.customerAddressResponse,
      this.initialValue,
      this.labelText,
      Key? key})
      : super(key: key);
  final String? labelText;
  final int? initialValue;
  final List<CustomerTypeDataResponse>? items;
  final CustomerAddressResponse? customerAddressResponse;
  final String iconPath;
  final FormFieldValidator<int>? validator;
  Function customerType;

  @override
  State<CustomDropdownCustomerType> createState() =>
      _CustomDropdownCustomerTypeState();
}

class _CustomDropdownCustomerTypeState
    extends State<CustomDropdownCustomerType> {
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<int>(
        key: widget.key,
        items: widget.items
            ?.map<DropdownMenuItem<int>>((data) => DropdownMenuItem<int>(
                  value: data.id,
                  child: Text(data.typeName ?? ""),
                ))
            .toList(),
        onChanged: (id) {
          widget.customerType(
              widget.items?.firstWhere((element) => element.id == id));
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
