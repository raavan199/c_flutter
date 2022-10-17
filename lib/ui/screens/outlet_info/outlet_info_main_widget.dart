import 'package:cygneto/exports/utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/models/entities/outlet_info_buttons_model.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';

class OutletInfoMainWidget extends StatelessWidget {
  final  VoidCallback onItemTap;
  String? iconPath,title;

   OutletInfoMainWidget({
    required this.onItemTap,
    required this.iconPath,this.title});


  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onItemTap,
    child: Container(
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [Shadows.greyShadow],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(iconPath!),
            const SizedBox(
              height: 10,
            ),
            Text(title!, style: CustomTextStyle.mobileNumberTextStyle),
          ],
        ),
      ),
    ),
  );

}
