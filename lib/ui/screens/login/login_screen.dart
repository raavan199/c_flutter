import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../database/app_database.dart';
import '../../../database/db_module.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import '../../../services/service_locator.dart';
import '../../../services/shared_preference_service.dart';
import '../base/base_screen.dart';
import '../forgot_pin/send_otp_screen.dart';
import '../home/home_screen.dart';
import 'login_screen_container.dart';

/// Created by Dev 2301 on 11/26/2021
/// Modified by Dev 2136 on 01/10/2022
/// Purpose : login screen of the app
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with ValidationMixin, UtilityMixin {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  late LoginBloc _bloc = LoginBloc(locator<DBModule>());
  AppDatabase? database;
  late String? loginNumber;
  late DBModule dbModule;

  @override
  void initState() {
    super.initState();
    SharedPreferenceService()
        .getStringValuesSF(SharedPrefsConstants.number)
        .then((value) => {
      if (value != null)
        {
          setState(() {
            _phoneController.text = value;
          })
        }
    });
    //_phoneController.text = "9727172818";
    //_pinController.text = "123123";
    /// prepare db object and add migration.
  }

  @override
  Widget build(BuildContext context) => BaseScreen<LoginBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
        },
        builder: (context, bloc, child) => BlocListener<LoginBloc, BaseState>(
          listener: (context, state) {
            if (state is LoginSuccessState) {
              final LoginResponse loginResponse = state.data;
              LoginSuccessCall(loginResponse);
            } else if (state is LoginFailedState) {
              showCustomFlushBar(context, state.msg);
            } else if (state is PinHashSuccessState) {
              if (state.data != null) {
                final LoginDataResponse loginDataResponse = state.data;
                if (loginDataResponse.pinHash == _pinController.text) {
                  clearStackAndAddScreen(context, const HomeScreen());
                }
              } else if (state.data == null) {
                showNoInternetDialog(context);
              } else {
                showSnackBar(context, AppStrings.msgInvalidMoNumberOrPin);
              }
            } else if (state is PinHashFailedState) {
              showCustomFlushBar(context, state.msg);
            }
          },
          child: Scaffold(
              backgroundColor: AppColors.white,
              body: Stack(
                children: [
                  LoginScreenContainer(
                    hasBack: false,
                    title: AppStrings.lblLogin,
                    btnText: AppStrings.lblLogin,
                    onButtonTap: _onClickLogin,
                    child: _buildLoginView(),
                  ),
                  LoaderView<LoginBloc>(
                    loader: CustomLoader.normal(),
                  ),
                ],
              )),
        ),
      );

  Map<String, dynamic> _loginDataResponseToJson(LoginDataResponse instance) =>
      <String, dynamic>{
        jsonEncode('fullName'): jsonEncode(instance.fullName),
        jsonEncode('email'): jsonEncode(instance.email),
        jsonEncode('jwtToken'): jsonEncode(instance.jwtToken),
        jsonEncode('refreshToken'): jsonEncode(instance.refreshToken),
        jsonEncode('image'): jsonEncode(instance.image),
        jsonEncode('userId'): jsonEncode(instance.userId),
        jsonEncode('isAdmin'): jsonEncode(instance.isAdmin),
        jsonEncode('userRoleName'): jsonEncode(instance.userRoleName),
        jsonEncode('pinHash'): jsonEncode(instance.pinHash),
      };

  Widget _buildLoginView() => Container(
    color: Colors.white,
    child: Form(
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
              const SizedBox(
                height: 30,
              ),
              LabeledTextInputField(
                isPassWord: true,
                controller: _pinController,
                label: AppStrings.lblEnterOtp,
                inputType: TextInputType.number,
                validator: (value) => pinFieldValidation(value!) != ""
                    ? pinFieldValidation(value)
                    : null,
              ),
              const SizedBox(
                height: 30,
              ),
              _forgotPinView(),
            ],
          ),
        ),
  );

  Widget _forgotPinView() => Container(
        alignment: Alignment.centerRight,
        child: InkWell(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          onTap: _onClickForgotPin,
          child: Text(
            AppStrings.lblForgotPin,
            style: CustomTextStyle.normalUnderlineTextStyle,
          ),
        ),
      );

  /// Created by Dev 2301 on 11/26/2021
  /// Modified by Dev 2301 on 11/26/2021
  /// Purpose : click method for login button
  void _onClickLogin() async {
    if (_formKey.currentState?.validate() ?? false) {
      //redirect to home
      hideKeyboard(context);
      doLogIn(_phoneController.value.text, _pinController.value.text);
      //clearStackAndAddScreen(context, const HomeScreen());
    }
  }

  /// Created by Dev 2301 on 11/26/2021
  /// Modified by Dev 2301 on 11/26/2021
  /// Purpose : click method for login button
  void _onClickForgotPin() {
    //redirect to reset pin
    hideKeyboard(context);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SendOtpScreen()),
    );
  }

  /// Created by Dev 2136 on 12/23/2021
  /// Modified by Dev 2136 on 12/23/2021
  /// Purpose : This method is used to do login.
  void doLogIn(String mobileNumber, String pin) {
    _bloc.add(LoginButtonPressed(mobileNumber: mobileNumber, pin: pin));
  }

  void LoginSuccessCall(LoginResponse loginResponse) {
    SharedPreferenceService().addStringToSF(
      SharedPrefsConstants.jwtToken,
      loginResponse.userData.jwtToken!,
    );
    SharedPreferenceService().addIntToSF(
      SharedPrefsConstants.userId,
      loginResponse.userData.userId!,
    );
    SharedPreferenceService().addStringToSF(
      SharedPrefsConstants.number,
      _phoneController.text,
    );
    final loginDataResponse =
        _loginDataResponseToJson(loginResponse.userData).toString();
    SharedPreferenceService().addStringToSF(
      SharedPrefsConstants.userDataResponse,
      loginDataResponse,
    );
    clearStackAndAddScreen(context, const HomeScreen());
  }

  Future<void> _saveIntoDatabase(LoginDataResponse userData, pin) async =>
      await dbModule.dbInstance.loginDao
          .insertLoginData(LoginDataResponse(
        fullName: userData.fullName,
        email: userData.email,
        jwtToken: userData.jwtToken,
        refreshToken: userData.refreshToken,
        image: userData.image,
        userId: userData.userId,
        isAdmin: userData.isAdmin,
        userRoleName: userData.userRoleName,
        //pinHash: userData.pinHash,
        pinHash: pin,
      ))
          .then((value) async {
        await dbModule.dbInstance.userRoleRightsDao
            .insertAllData(userData.userRoleRights ?? []);

        /// updating previous screen.
      });
}
