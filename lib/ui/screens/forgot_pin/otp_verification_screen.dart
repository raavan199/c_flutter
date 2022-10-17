import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/forgot_pin/forgot_pin_bloc.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';
import '../login/login_screen_container.dart';
import 'reset_pin_screen.dart';

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2301 on 11/26/2021
/// Purpose : otp verification screen
/// user will get redirected to this screen after requesting for otp
/// on send otp screen
class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({
    required this.phone,
    Key? key,
  }) : super(key: key);
  final String phone;

  @override
  _OtpVerificationScreenState createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with ValidationMixin, UtilityMixin {
  static const tag = "OtpVerificationScreen";
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _pinController = TextEditingController();
  late ForgotPinBloc _bloc;

  TextStyle _subHeaderTextStyle({Color? color}) => TextStyle(
      color: color ?? AppColors.black,
      fontSize: 16,
      fontWeight: AppFonts.medium);

  @override
  Widget build(BuildContext context) => BaseScreen<ForgotPinBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
        },
        builder: (context, bloc, child) =>
            BlocListener<ForgotPinBloc, BaseState>(
          listener: (context, state) {
            //to fetch resend otp response
            if (state is VerifyOtpSuccessState) {
              //do redirection
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ResetPinScreen(
                          phone: widget.phone,
                        )),
              );
            } else if (state is VerifyOtpFailedState) {
              showCustomFlushBar(context, state.msg ?? "");
            } else if (state is ResendOtpSuccessState) {
              _pinController.text = "";
              showCustomFlushBar(context, 'OTP resent successfully');
            } else if (state is ResendOtpFailedState) {
              showCustomFlushBar(context, state.msg ?? "");
            }
          },
          child: Scaffold(
              backgroundColor: AppColors.white,
              body: Stack(
                children: [
                  LoginScreenContainer(
                    hasBack: true,
                    title: AppStrings.lblVerification,
                    btnText: AppStrings.lblContinue,
                    onButtonTap: _onClickContinue,
                    child: _buildVerificationView(),
                  ),
                  LoaderView<ForgotPinBloc>(
                    loader: CustomLoader.normal(),
                  ),
                ],
              )),
        ),
      );

  Widget _buildVerificationView() => Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 30,
            ),
            _headerView(),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 50),
              child: _pinView(),
            ),
            _resendButtonView(),
          ],
        ),
      );

  Widget _headerView() => Padding(
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          children: [
            Text(
              AppStrings.lblEnterVerificationCode,
              style: _subHeaderTextStyle(),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              widget.phone,
              style: _subHeaderTextStyle(color: AppColors.primary),
            ),
          ],
        ),
      );

  Widget _pinView() => PinField(
        controller: _pinController,
        onChanged: (value) {},
        onCompleted: (value) {
          Logger.d(tag, "otp : $value");
        },
      );

  Widget _resendButtonView() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            AppStrings.lblNotReceivedCode,
            style: TextStyle(
                color: AppColors.black,
                fontSize: 14,
                fontWeight: AppFonts.medium),
          ),
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: _onClickResend,
            child: const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                AppStrings.lblResend,
                style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    decoration: TextDecoration.underline,
                    fontWeight: AppFonts.medium),
              ),
            ),
          ),
        ],
      );

  /// Created by Dev 2301 on 11/26/2021
  /// Modified by Dev 2301 on 11/26/2021
  /// Purpose : click method for continue button
  void _onClickContinue() {
    if (_formKey.currentState?.validate() ?? false) {
      //redirect to verification screen
      hideKeyboard(context);
      doVerification(widget.phone, _pinController.text);
    }
  }

  /// Created by Dev 2301 on 12/1/2021
  /// Modified by Dev 2301 on 12/1/2021
  /// Purpose : click method for resend otp
  void _onClickResend() {
    _bloc.add(SendOtpButtonPressed(
      mobileNumber: widget.phone,
      forgotPinApiType: ForgotPinApiType.resendOtp,
    ));
  }

  /// Created by Dev 2136 on 12/24/2021
  /// Modified by Dev 2136 on 12/24/2021
  /// Purpose : This method is used to do verify otp.
  void doVerification(String mobileNumber, String otp) {
    _bloc.add(VerifyOtpButtonPressed(mobileNumber: mobileNumber, otp: otp));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
