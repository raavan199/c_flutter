import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../exports/themes.dart';
import 'custom_number_input.dart';

/// Created by Dev 2301 on 11/30/2021
/// Modified by Dev 2301 on 11/30/2021
/// Purpose : custom text input field with label
class LabeledTextInputField extends StatelessWidget {
  const LabeledTextInputField(
      {this.isPassWord = false,
      this.inputType = TextInputType.text,
      this.inputAction = TextInputAction.next,
      this.hintText,
      this.controller,
      this.validator,
      this.onChanged,
      this.label,
      Key? key})
      : super(key: key);
  final String? label;
  final bool isPassWord;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String? hintText;
  final TextEditingController? controller;
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
          CustomNumberInputField(
            maxLength: 6,
            maxLengthEnforcement: MaxLengthEnforcement.enforced,
            isPassWord: isPassWord,
            inputType: inputType,
            inputAction: inputAction,
            hintText: hintText,
            controller: controller,
            validator: validator,
            onChanged: onChanged,
          ),
        ],
      );
}
