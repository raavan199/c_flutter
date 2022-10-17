import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../exports/resources.dart';
import '../../exports/themes.dart';
import 'custom_number_input.dart';

/// Created by Dev 2301 on 11/30/2021
/// Modified by Dev 2301 on 11/30/2021
/// Purpose : custom text input field for phone number with country code
class PhoneNumberInputField extends StatelessWidget {
  const PhoneNumberInputField(
      {required this.controller,
      this.inputAction = TextInputAction.next,
      this.hintText,
      this.validator,
      this.onChanged,
      this.label,
      this.code = "91",
      Key? key})
      : super(key: key);
  final String? label;
  final String code;
  final TextInputAction inputAction;
  final String? hintText;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (label != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                label!,
                maxLines: 3,
                style: CustomTextStyle.inputFieldLabel,
              ),
            ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: AppColors.border),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: Center(
                  child: Text(
                    "+$code",
                    style: CustomTextStyle.inputFieldText,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: CustomNumberInputField(
                  maxLength: 10,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  inputAction: inputAction,
                  hintText: hintText,
                  controller: controller,
                  validator: validator,
                  onChanged: onChanged,
                  inputType: TextInputType.phone,
                ),
              ),
            ],
          ),
        ],
      );
}
