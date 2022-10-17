import 'dart:io';

import 'package:flutter/material.dart';
import '../../exports/resources.dart';
import '../../themes/custom_text_style.dart';

/// Created by Dev 2196 on 7/13/2021
/// Modified by Dev 2301 on 9/6/2021
/// Purpose : this class contains the function for showing alert widgets
class CustomAlert {
  void showConfirmationAlertDialog(
    BuildContext context, {
    required String title,
    required String content,
    required String btnOkText,
    required VoidCallback onOkTap,
    String? btnCancelText,
    VoidCallback? onCancelTap,
    WillPopCallback? onWillPop,
    bool isConfirmation = true,
    TextAlign? textAlign,
  }) {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (buildContext, animation, secondaryAnimation) =>
            WillPopScope(
              onWillPop: onWillPop,
              child: Dialog(
                backgroundColor: AppColors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.only(top:13),
                  child: Wrap(
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(
                            0, 18, 0, 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25,
                                      right: 25),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      title,
                                      style: CustomTextStyle.dialogHeaderStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25,
                                      right: 25,
                                      top: 10,
                                      bottom: 20),
                                  child: Text(
                                    content,
                                    textAlign: TextAlign.left,
                                    style: CustomTextStyle.dialogTextStyle,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Container(
                                height: 40,
                                decoration: const BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            ))),
                                margin: EdgeInsets.zero,
                                padding: EdgeInsets.zero,
                                child: Row(
                                  children: <Widget>[
                                    if (isConfirmation)
                                      Expanded(
                                        child: MaterialButton(
                                          splashColor: Platform.isIOS
                                              ? Colors.transparent
                                              : Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onPressed: onCancelTap ??
                                              () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pop();
                                              },
                                          child: Text(
                                            btnCancelText ?? AppStrings.lblCancel,
                                            style: CustomTextStyle
                                                .dialogButtonStyle,
                                          ),
                                        ),
                                      ),
                                    if (isConfirmation)
                                      Container(
                                        width: 1,
                                        color: AppColors.black,
                                      ),
                                    Expanded(
                                      child: MaterialButton(
                                        splashColor: Platform.isIOS
                                            ? Colors.transparent
                                            : Colors.white10,
                                        highlightColor: Colors.transparent,
                                        height: 40,
                                        onPressed: onOkTap,
                                        child: Text(
                                          btnOkText,
                                          style:
                                              CustomTextStyle.dialogButtonStyle,
                                        ),
                                        //color: AppColors.secondary_color,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
