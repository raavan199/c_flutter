import 'package:flutter/material.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';

/// Created by Dev 1051 on 7/16/2021
/// Modified by Dev 1051 on 7/19/2021
/// Purpose : This is a login field widget which will be used to show login
/// field with sign in button, remember me, forgot password.

class LoginFieldWidget extends StatefulWidget {
  const LoginFieldWidget(
      {required this.usernameController,
      required this.passwordController,
      required this.onSignInClicked,
      required this.onForgotPasswordClicked,
      required this.checkedValue,
      required this.toggleCheckBox,
      required this.onTextChanged,
      required this.formKey,
      required this.isButtonEnabled,
      Key? key})
      : super(key: key);

  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final Function onSignInClicked;
  final Function onForgotPasswordClicked;
  final bool checkedValue;
  final Function toggleCheckBox;
  final Function onTextChanged;
  final GlobalKey formKey;
  final bool isButtonEnabled;

  @override
  _LoginFieldWidgetState createState() => _LoginFieldWidgetState();
}

class _LoginFieldWidgetState extends State<LoginFieldWidget>
    with ValidationMixin {
  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.welcomeTitle,
              style: CustomTextStyle.largeBoldTextStyle,
            ),
            Text(
              AppStrings.signInToContinue,
              style: CustomTextStyle.mediumTextStyle,
            ),
            Container(
              height: 24,
            ),
            CustomTextInputField(
              inputType: TextInputType.emailAddress,
              hintText: AppStrings.username,
              controller: widget.usernameController,
              validator: (value) =>
                  validateEmail(value!) != "" ? validateEmail(value) : null,
              onChanged: (_) => widget.onTextChanged(),
            ),
            Container(
              height: 20,
            ),
            CustomTextInputField(
              isPassWord: true,
              controller: widget.passwordController,
              inputAction: TextInputAction.done,
              hintText: AppStrings.password,
              validator: (value) => requiredFieldValidation(value!) != ""
                  ? requiredFieldValidation(value)
                  : null,
              onChanged: (_) => widget.onTextChanged(),
            ),
            Container(
              height: 21,
            ),
            Row(
              children: [
                CustomCheckBox(
                    checkBoxName: AppStrings.rememberMe,
                    checkedValue: widget.checkedValue,
                    toggleCheckBox: widget.toggleCheckBox),
                const Spacer(),
                InkWell(
                  onTap: () {
                    widget.onForgotPasswordClicked();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                    child: const Text(
                      AppStrings.forgotPassword,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 21,
            ),
            ElevatedButton(
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 45)),
                textStyle:
                    MaterialStateProperty.all(CustomTextStyle.buttonTextStyle),
                backgroundColor: widget.isButtonEnabled
                    ? MaterialStateProperty.all(AppColors.accentYellow)
                    : MaterialStateProperty.all(AppColors.hint),
                elevation: MaterialStateProperty.all(0),
                foregroundColor: MaterialStateProperty.all(AppColors.white),
              ),
              onPressed: widget.isButtonEnabled
                  ? () {
                      widget.onSignInClicked();
                    }
                  : null,
              child: const Text(AppStrings.signIn),
            )
          ],
        ),
      );
}
