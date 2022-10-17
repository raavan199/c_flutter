import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants/app_constants.dart';
import '../../exports/resources.dart';

/// Created by Dev 2301 on 12/1/2021
/// Modified by Dev 2301 on 12/1/2021
/// Purpose : custom otp field
class PinField extends StatelessWidget {
  const PinField({
    required this.controller,
    required this.onChanged,
    this.onCompleted,
    Key? key,
  }) : super(key: key);
  final TextEditingController controller;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String> onChanged;
  @override
  Widget build(BuildContext context) => PinCodeTextField(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        appContext: context,
        length: NumericConstants.otpLength,
        validator: (v) {
          if (v!.length < NumericConstants.otpLength - 1) {
            return "";
          } else {
            return null;
          }
        },
        animationType: AnimationType.fade,
        enableActiveFill: true,
        textStyle: const TextStyle(
          fontSize: 18,
            color: AppColors.black, fontWeight: AppFonts.medium),
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 40,
          fieldWidth: 40,
          activeFillColor: AppColors.pinBackground,
          selectedFillColor: AppColors.pinBackground,
          inactiveFillColor: AppColors.pinBackground,
          activeColor: AppColors.pinBackground,
          errorBorderColor: AppColors.pinBackground,
          selectedColor: AppColors.pinBackground,
          inactiveColor: AppColors.pinBackground,
        ),
        controller: controller,
        keyboardType: TextInputType.number,
        cursorColor: Colors.black,
        onCompleted: onCompleted,
        onChanged: onChanged,
      );

}
