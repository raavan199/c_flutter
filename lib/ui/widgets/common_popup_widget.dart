import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../themes/custom_text_style.dart';

class CommonPopupWidget extends StatelessWidget {
  CommonPopupWidget(
      {required this.title, required this.description, Key? key})
      : super(key: key);
  String title;
  String description;

  @override
  Widget build(BuildContext context) => Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
            style: CustomTextStyle.blackBold12TextStyle,),
          const SizedBox(
            height: 6,
          ),
          Text(description,
            style: CustomTextStyle.filterHeaderTextStyle.copyWith(
              height: 1.3
            ),)
        ],
      ),
    );
}
