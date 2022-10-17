import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../exports/resources.dart';
import '../../exports/themes.dart';

/// Created by Dev 2301 on 11/30/2021
/// Modified by Dev 2301 on 11/30/2021
/// Purpose : custom text input field
class CustomTextInputField extends StatefulWidget {
  const CustomTextInputField({
    this.isPassWord = false,
    this.isUpperCase = false,
    this.inputType = TextInputType.text,
    this.inputAction = TextInputAction.next,
    this.hintText,
    this.controller,
    this.validator,
    this.onChanged,
    this.labelText,
    this.initialValue,
    this.enabled = true,
    this.maxLines = 1,
    this.maxLength,
    this.maxLengthEnforcement = MaxLengthEnforcement.none,
    Key? key,
  }) : super(key: key);

  final bool isPassWord;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final String? hintText;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;
  final String? labelText;
  final String? initialValue;
  final bool enabled;
  final int maxLines;
  final bool isUpperCase;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;

  @override
  _CustomTextInputFieldState createState() => _CustomTextInputFieldState();
}

class _CustomTextInputFieldState extends State<CustomTextInputField> {
  bool _hidePassword = true;

  void _toggleVisibility() {
    setState(() {
      _hidePassword = !_hidePassword;
    });
  }

  @override
  Widget build(BuildContext context) => TextFormField(
        maxLength: widget.maxLength,
        maxLengthEnforcement: widget.maxLengthEnforcement,
        textCapitalization: widget.isUpperCase
            ? TextCapitalization.characters
            : TextCapitalization.none,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: widget.initialValue,
        validator: widget.validator,
        controller: widget.controller,
        obscureText: widget.isPassWord && _hidePassword,
        style: CustomTextStyle.inputFieldText,
        textInputAction: widget.inputAction,
        cursorColor: AppColors.black,
        keyboardType: widget.inputType,
        enabled: widget.enabled,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
            isDense: true,
            // this will remove the default content padding
            // now you can customize it here or add padding widget

            focusedBorder: _inputBorder(),
            enabledBorder: _inputBorder(),
            disabledBorder: _inputBorder(),
            errorBorder: _inputBorder(color: AppColors.red),
            focusedErrorBorder: _inputBorder(color: AppColors.red),
            hintText: widget.hintText,
            suffixIcon: _getSuffix(widget.isPassWord),
            labelText: widget.labelText ?? widget.labelText,
            labelStyle: widget.labelText != null
                ? const TextStyle(
                    fontFamily: AppFonts.fontName,
                    fontSize: 12,
                    fontWeight: AppFonts.medium,
                    color: Colors.black)
                : const TextStyle()),
        onChanged: widget.onChanged,
      );

  OutlineInputBorder _inputBorder({Color? color}) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: color ?? AppColors.border,
        ),
      );

  Widget? _getSuffix(isVisible) {
    if (isVisible) {
      return GestureDetector(
        onTap: _toggleVisibility,
        child: Icon(
          _hidePassword ? Icons.visibility : Icons.visibility_off,
          color: AppColors.black,
        ),
      );
    } else {
      return null;
    }
  }
}
