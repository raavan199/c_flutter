import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';

import '../../resources/app_assets.dart';
import 'common_popup_widget.dart';

class CommonInfoIcon extends StatelessWidget {
  String? title;
  String? description;

  CommonInfoIcon({this.title, this.description, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Positioned(
        top: 0,
        right: 0,
        child: InkWell(
          onTap: () {
            showPopover(
                transitionDuration: const Duration(milliseconds: 150),
                context: context,
                width: 200,
                height: 100,
                bodyBuilder: (context) => CommonPopupWidget(
                    title: title ?? "", description: description ?? ""));
          },
          child: SvgPicture.asset(
            AppAssets.icInfo,
            height: 22,
            width: 22,
          ),
        ),
      );
}
