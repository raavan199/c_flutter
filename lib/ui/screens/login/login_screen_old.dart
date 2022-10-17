import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/login/login_bloc.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/shared_preference_service.dart';
import '../base/base_screen.dart';
import 'login_bottom_widget.dart';
import 'login_field_widget.dart';
import 'login_logo_widget.dart';

/// Created by Dev 1051 on 7/15/2021
/// Modified by Dev 1051 on 7/19/2021
/// Purpose : This is a login screen parent widget. here, we will show login
/// screen, add validations etc.
class LoginScreenOld extends StatefulWidget {
  const LoginScreenOld({Key? key}) : super(key: key);

  @override
  _LoginScreenOldState createState() => _LoginScreenOldState();
}

class _LoginScreenOldState extends State<LoginScreenOld> with UtilityMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var _isButtonEnabled = false;
  final bool _isUsernamePasswordStored = false;
  final bool _shallShowFaceId = false;
  final bool _shallShowFingerPrintId = false;
  bool _isRememberMeSelected = false;
  late LoginBloc _bloc;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    /// Checking here for stored email id and if stored, setting it to
    /// input field.
    SharedPreferenceService()
        .getStringValuesSF(SharedPrefsConstants.emailId)
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    _usernameController.value = TextEditingValue(text: value);
                  })
                }
            });

    /// Checking here for stored password and if stored, setting it to
    /// input field.
    SharedPreferenceService()
        .getStringValuesSF(SharedPrefsConstants.password)
        .then((value) => {
              if (value != null)
                {
                  setState(() {
                    _passwordController.value = TextEditingValue(text: value);
                  })
                }
            });
  }

  @override
  Widget build(BuildContext context) => BaseScreen<LoginBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
        },
        builder: (context, bloc, child) => BlocListener<LoginBloc, BaseState>(
          listener: (context, state) {
            if (state is SuccessState) {
              //do redirection
            }
            if (state is FailedState) {
              showSnackBar(context, state.msg ?? "");
            }
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
              backgroundColor: AppColors.white,
              body: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const LoginLogoWidget(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LoginFieldWidget(
                                  usernameController: _usernameController,
                                  passwordController: _passwordController,
                                  onSignInClicked: _onSignInClicked,
                                  onForgotPasswordClicked:
                                      _onForgotPassWordClicked,
                                  checkedValue: _isRememberMeSelected,
                                  toggleCheckBox: _toggleRememberMe,
                                  onTextChanged: _onTextChange,
                                  formKey: _formKey,
                                  isButtonEnabled: _isButtonEnabled),
                              Container(
                                height: 24,
                              ),
                              LoginBottomWidget(
                                  onFingerPrintClicked: _onFingerPrintClicked,
                                  onFaceIdClicked: _onFaceIdClicked,
                                  showFaceIdButton: _isUsernamePasswordStored &&
                                      _shallShowFaceId,
                                  showFingerPrintButton:
                                      _isUsernamePasswordStored &&
                                          _shallShowFingerPrintId)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  LoaderView<LoginBloc>(
                    loader: CustomLoader.normal(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  /// Created by Dev 1051 on 7/19/2021
  /// Modified by Dev 1051 on 7/19/2021
  /// Purpose : This method is used to toggle the remember me task.
  void _toggleRememberMe() {
    setState(() {
      _isRememberMeSelected = !_isRememberMeSelected;
    });
  }

  /// Created by Dev 1051 on 7/19/2021
  /// Modified by Dev 1051 on 7/19/2021
  /// Purpose : This method is used to handle face id click event. Here we will
  /// perform authorization task based on face id status.
  void _onFaceIdClicked() {}

  /// Created by Dev 1051 on 7/19/2021
  /// Modified by Dev 1051 on 7/19/2021
  /// Purpose : This method is used to handle fingerprint id click event.
  /// Here we will perform authorization task based on face id status.
  void _onFingerPrintClicked() {}

  /// Created by Dev 1051 on 7/19/2021
  /// Modified by Dev 1051 on 7/19/2021
  /// Purpose : This method will get called once user click on sign in button.
  void _onSignInClicked() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      //doSignIn(_usernameController.value.text, _passwordController.value.text);
    }
  }

  /// Created by Dev 1051 on 7/19/2021
  /// Modified by Dev 2196 on 7/19/2021
  /// Purpose : Once user click on forgot password, this method will called and
  /// from here, user will navigate to the forgot password.
  void _onForgotPassWordClicked() {}

  /// Created by Dev 1051 on 7/19/2021
  /// Modified by Dev 1051 on 7/19/2021
  /// Purpose : This method will get called once user enter anything in the
  /// field, from here we will check for the validation
  /// and show or hide an errors.
  void _onTextChange() {
    final isValid = _formKey.currentState?.validate();
    if (_isButtonEnabled != isValid) {
      setState(() {
        _isButtonEnabled = isValid!;
      });
    }
  }

  /// Created by Dev 1051 on 7/21/2021
  /// Modified by Dev 1051 on 7/21/2021
  /// Purpose : This method is used to do signin.
  /*
  void doSignIn(String username, String password) {
    _bloc.add(LoginButtonPressed(email: username, password: password));
  }

   */
}
