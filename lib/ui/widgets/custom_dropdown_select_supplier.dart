import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../resources/app_colors.dart';
import '../../resources/app_fonts.dart';

class CustomDropdownSelectSupplier extends StatefulWidget {
  CustomDropdownSelectSupplier(
      {required this.items,
        required this.iconPath,
        required this.validator,
        this.customerDataItemsResponse,
        this.initialValue,
        this.labelText,
        required this.selectedSupplier,
        Key? key})
      : super(key: key);
  final String? labelText;
  final String? initialValue;
  final List<DistributionData>? items;
  final CustomerDataItemsResponse? customerDataItemsResponse;
  final String iconPath;
  Function selectedSupplier;
  FormFieldValidator<DistributionData>? validator;

  @override
  State<CustomDropdownSelectSupplier> createState() =>
      _CustomDropdownSelectSupplierState();
}

class _CustomDropdownSelectSupplierState
    extends State<CustomDropdownSelectSupplier> {

  @override
  Widget build(BuildContext context) =>
      DropdownButtonFormField<DistributionData>(
        items: widget.items
            ?.map<DropdownMenuItem<DistributionData>>(
                (distributionData) => DropdownMenuItem<DistributionData>(
              value: distributionData,
              child: Text(distributionData.businessName??""),
            ))
            .toList(),
        onChanged: (distributionData) {
          widget.selectedSupplier(distributionData);
          setState(() {});
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
