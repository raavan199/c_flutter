import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../exports/resources.dart';
import '../../resources/app_assets.dart';

class BadgeIcon extends StatelessWidget {
  const BadgeIcon(
      {required this.icon,
      this.badgeCount = 0,
      this.showIfZero = false,
      this.badgeColor = AppColors.primary,
      this.badgeTextStyle = const TextStyle(
        color: Colors.white,
        fontSize: 8,
      )});

  final String icon;
  final int badgeCount;
  final bool showIfZero;
  final Color badgeColor;
  final TextStyle badgeTextStyle;

  @override
  Widget build(BuildContext context) =>
      Stack(clipBehavior: Clip.none, children: <Widget>[
        SvgPicture.asset(
          AppAssets.icCart,
          width: 23,
          height: 23,
        ),
        if (badgeCount > 0 || showIfZero) badge(badgeCount),
      ]);

  Widget badge(int count) => Positioned(
        right: -5,
        top: -5,
        child: Container(
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(8.5),
          ),
          constraints: const BoxConstraints(
            minWidth: 15,
            minHeight: 15,
          ),
          child: Center(
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
}
