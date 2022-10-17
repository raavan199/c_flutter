import 'package:flutter/material.dart';
import '../../../exports/resources.dart';

/// Created by Dev 1051 on 7/16/2021
/// Modified by Dev 1051 on 7/16/2021
/// Purpose : This is a bottom widget of login screeen. here we have kept
/// required bottom view widgets like separator, or view, face id and
/// fingerprint buttons.

class LoginBottomWidget extends StatefulWidget {
  const LoginBottomWidget(
      {required this.showFaceIdButton,
      required this.showFingerPrintButton,
      required this.onFingerPrintClicked,
      required this.onFaceIdClicked,
      Key? key})
      : super(key: key);

  final Function onFingerPrintClicked;
  final Function onFaceIdClicked;
  final bool showFaceIdButton;
  final bool showFingerPrintButton;

  @override
  _LoginBottomWidgetState createState() => _LoginBottomWidgetState();
}

class _LoginBottomWidgetState extends State<LoginBottomWidget> {
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Row(
            children: [
              if (widget.showFaceIdButton || widget.showFingerPrintButton)
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.black,
                  ),
                ),
              if (widget.showFaceIdButton || widget.showFingerPrintButton)
                Expanded(
                  child: Container(
                    height: 1,
                    color: AppColors.black,
                  ),
                ),
              Container(),
            ],
          ),
          if (widget.showFaceIdButton || widget.showFingerPrintButton)
            Container(
              height: 16,
            )
          else
            Container(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.showFaceIdButton)
                InkWell(
                  child: const Icon(Icons.face_outlined),
                  onTap: () {
                    widget.onFaceIdClicked();
                  },
                ),
              if (widget.showFaceIdButton && widget.showFingerPrintButton)
                Container(
                  width: 34,
                ),
              if (widget.showFingerPrintButton)
                InkWell(
                  child: const Icon(Icons.fingerprint),
                  onTap: () {
                    widget.onFingerPrintClicked();
                  },
                ),
              Container(),
            ],
          ),
          const SizedBox(height: AppDimens.commonPadding)
        ],
      );
}
