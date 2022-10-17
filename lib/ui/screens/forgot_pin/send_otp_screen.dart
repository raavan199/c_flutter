import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/forgot_pin/forgot_pin_bloc.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';
import '../login/login_screen_container.dart';
import 'otp_verification_screen.dart';

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2301 on 11/26/2021
/// Purpose : send otp screen
/// user will get redirected to this screen on taping forgot pin link
/// on Login screen
class SendOtpScreen extends StatefulWidget {
  const SendOtpScreen({Key? key}) : super(key: key);

  @override
  _SendOtpScreenState createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen>
    with ValidationMixin, UtilityMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  late ForgotPinBloc _bloc;

  @override
  Widget build(BuildContext context) => BaseScreen<ForgotPinBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
        },
        builder: (context, bloc, child) =>
            BlocListener<ForgotPinBloc, BaseState>(
          listener: (context, state) {
            if (state is SuccessState) {
              //do redirection
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => OtpVerificationScreen(
                          phone: _phoneController.text,
                        )),
              );
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
                    title: AppStrings.lblResetPin,
                    btnText: AppStrings.lblSendOtp,
                    onButtonTap: _onClickSendOtp,
                    hasBack: true,
                    child: _buildSendOtpView(),
                  ),
                  LoaderView<ForgotPinBloc>(
                    loader: CustomLoader.normal(),
                  ),
                ],
              )),
        ),
      );

  Widget _buildSendOtpView() => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            PhoneNumberInputField(
              controller: _phoneController,
              label: AppStrings.lblEnterMobile,
              validator: (value) => phoneFieldValidation(value!) != ""
                  ? phoneFieldValidation(value)
                  : null,
            ),
          ],
        ),
      );

  /// Created by Dev 2301 on 11/26/2021
  /// Modified by Dev 2136 on 12/27/2021
  /// Purpose : click method for send otp button
  void _onClickSendOtp() {
    if (_formKey.currentState?.validate() ?? false) {
      //final phone = "+91 ${_phoneController.value.text}";
      hideKeyboard(context);
      doForgotOTP(_phoneController.value.text);
    }
  }

  /// Created by Dev 2136 on 12/24/2021
  /// Modified by Dev 2136 on 12/24/2021
  /// Purpose : This method is used to do sent otp.
  void doForgotOTP(String mobileNumber) {
    _bloc.add(SendOtpButtonPressed(
      mobileNumber: mobileNumber,
      forgotPinApiType: ForgotPinApiType.sendOtp,
    ));
  }
}
