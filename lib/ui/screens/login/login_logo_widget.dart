import 'package:flutter/material.dart';

import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';

/// Created by Dev 1051 on 7/15/2021
/// Modified by Dev 1051 on 7/19/2021
/// Purpose : This is a login logo content widget. which will contain
class LoginLogoWidget extends StatefulWidget {
  const LoginLogoWidget({Key? key}) : super(key: key);

  @override
  _LoginLogoWidgetState createState() => _LoginLogoWidgetState();
}

class _LoginLogoWidgetState extends State<LoginLogoWidget> {
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: const [
              BackgroundContainer(
                height: 173,
                backgroundColor: AppColors.black,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 50),
              )
            ],
          ),
        ],
      );
}
