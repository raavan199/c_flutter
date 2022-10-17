import 'package:cygneto/data/models/outlet/customer_category_data_response.dart';
import 'package:cygneto/exports/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

class CustomDropdownStateAddress extends StatefulWidget {
  CustomDropdownStateAddress(
      {required this.items,
      required this.iconPath,
      required this.state,
      required this.validator,
      this.customerAddressResponse,
      this.initialValue,
      this.labelText,
      Key? key})
      : super(key: key);
  final String? labelText;
  final int? initialValue;
  final List<StateDataItemResponse>? items;
  final CustomerAddressResponse? customerAddressResponse;
  final String iconPath;
  final FormFieldValidator<int>? validator;
  Function state;

  @override
  State<CustomDropdownStateAddress> createState() =>
      _CustomDropdownStateAddressState();
}

class _CustomDropdownStateAddressState
    extends State<CustomDropdownStateAddress> {
  @override
  Widget build(BuildContext context) => DropdownButtonFormField<int>(
        value: widget.initialValue,
        key: widget.key,
        items: widget.items
            ?.map<DropdownMenuItem<int>>((stateData) => DropdownMenuItem<int>(
                  value: stateData.id,
                  child: Text(stateData.name ?? ""),
                ))
            .toList(),
        onChanged: (id) {
          widget.state(widget.items?.firstWhere((element) => element.id == id));
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
