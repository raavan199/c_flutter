
import 'package:cygneto/exports/themes.dart';
import 'package:cygneto/resources/app_colors.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  CustomDialog(
      {required String title,
      required String content,
      required Function yesOnPressed,
      Function? noOnPressed,
      required String yes, String? no}) {
    _title = title;
    _content = content;
    _yesOnPressed = yesOnPressed;
    _noOnPressed = noOnPressed;
    _yes = yes;
    _no = no;
  }

  String _title = '';
  String _content = '';
  String _yes = '';
  String? _no = '';
  Function _yesOnPressed = () {};
  Function? _noOnPressed = () {};

  @override
  Widget build(BuildContext context) => AlertDialog(
        title: Text(_title),
        content: Text(_content),
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        actions: <Widget>[

          MaterialButton(
            onPressed: () {
              if(_noOnPressed != null) {
                _noOnPressed!();
              }
            },
            child: Text(
              _no ?? '',
              style: CustomTextStyle.mobileNumberTextStyle,
            ),
          ),
          MaterialButton(
            onPressed: () {
              _yesOnPressed();
              Navigator.of(context).pop();
            },
            child: Text(
              _yes,
              style: CustomTextStyle.mobileNumberTextStyle,
            ),
          ),
        ],
      );
}
