import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/reset_pin/reset_pin_bloc.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../widgets/custom_dialog.dart';
import '../base/base_screen.dart';
import '../login/login_screen.dart';
import '../login/login_screen_container.dart';

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2301 on 11/26/2021
/// Purpose :user will get redirected to this screen on taping continue button
/// from otp verification screen
class ResetPinScreen extends StatefulWidget {
  const ResetPinScreen({required this.phone, Key? key}) : super(key: key);
  final String phone;

  @override
  _ResetPinScreenState createState() => _ResetPinScreenState();
}

class _ResetPinScreenState extends State<ResetPinScreen>
    with ValidationMixin, UtilityMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _verifyPinController = TextEditingController();
  late ResetPinBloc _bloc;

  @override
  Widget build(BuildContext context) => BaseScreen<ResetPinBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
        },
        builder: (context, build, child) =>
            BlocListener<ResetPinBloc, BaseState>(
          listener: (context, state) {
            if (state is SuccessState) {
              showConfirmationDialog();
            }
            if (state is FailedState) {
              Flushbar(
                title: AppStrings.lblFieldSales.toUpperCase(),
                message: state.msg ?? "",
                duration: const Duration(seconds: 3),
              ).show(context);
            }
          },
          child: Scaffold(
              backgroundColor: AppColors.white,
              body: Stack(
                children: [
                  LoginScreenContainer(
                    hasBack: true,
                    title: AppStrings.lblVerification,
                    btnText: AppStrings.lblSubmit,
                    onButtonTap: _onClickSubmit,
                    child: _buildResetView(),
                  ),
                  LoaderView<ResetPinBloc>(
                    loader: CustomLoader.normal(),
                  ),
                ],
              )),
        ),
      );

  Widget _buildResetView() => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            LabeledTextInputField(
              controller: _pinController,
              label: AppStrings.lblEnterNewPin,
              inputType: TextInputType.number,
              validator: (value) => pinFieldValidation(value!) != ""
                  ? pinFieldValidation(value)
                  : null,
            ),
            const SizedBox(
              height: 30,
            ),
            LabeledTextInputField(
              controller: _verifyPinController,
              label: AppStrings.lblReEnterNewPin,
              inputType: TextInputType.number,
              validator: (value) => pinFieldValidation(value!) != ""
                  ? pinFieldValidation(value)
                  : null,
            ),
          ],
        ),
      );

  void showConfirmationDialog() {
    final alert = showDialog(
        context: context,
        builder: (context) => CustomDialog(
          content: AppStrings.msgPinChangedSuccessfully,
          title: AppStrings.lblResetPinChange,
          yes: AppStrings.ok,
          yesOnPressed: () {
          },
        ));
    alert.whenComplete(() {
      clearStackAndAddScreen(context, const LoginScreen());
    });
  }

  /// Created by Dev 2301 on 11/26/2021
  /// Modified by Dev 2301 on 12/24/2021
  /// Purpose : click method for submit button
  void _onClickSubmit() {
    if (_formKey.currentState?.validate() ?? false) {
      if (_pinController.text == _verifyPinController.text) {
        hideKeyboard(context);
        doResetPin(widget.phone, _verifyPinController.text);
      } else {
        showSnackBar(context, "Pin and Re-enter Pin must be same");
      }
    }
  }

  /// Created by Dev 2136 on 12/24/2021
  /// Modified by Dev 2136 on 12/24/2021
  /// Purpose : This method is used to do reset pin.
  void doResetPin(String mobileNumber, String pin) {
    _bloc.add(ResetPinButtonPressed(mobileNumber: mobileNumber, pin: pin));
  }
}
