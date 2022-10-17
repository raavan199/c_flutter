import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../exports/resources.dart';

/// Created by Dev 2196 on 7/27/2021
/// Modified by Dev 2301 on 3/8/2021
/// Purpose : This widget used to add button on navigation bar.
class OutlinedIconButton extends StatelessWidget {
  const OutlinedIconButton({
    required this.title,
    required this.onPressed,
    required this.icon,
    Key? key,
    this.textOrIconColor,
    this.paddingLeft,
    this.paddingRight,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final String icon;
  final Color? textOrIconColor;
  final double? paddingLeft;
  final double? paddingRight;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(
            right: paddingRight ?? AppDimens.commonPadding,
            left: paddingLeft ?? AppDimens.commonPadding),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: onPressed,
          child: Center(
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                border: Border.all(color: textOrIconColor ?? AppColors.black),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: SvgPicture.asset(
                      icon,
                      height: 10,
                      color: textOrIconColor ?? AppColors.black,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                        fontFamily: AppFonts.fontName,
                        color: textOrIconColor ?? AppColors.black,
                        fontSize: 11,
                        fontWeight: AppFonts.semiBold),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}

/// Created by Dev 2301 on 8/3/2021
/// Modified by Dev 2301 on 8/3/2021
/// Purpose : opaque app bar button
class OpaqueAppbarButton extends StatelessWidget {
  const OpaqueAppbarButton({
    required this.title,
    required this.onPressed,
    this.isEnabled = true,
    Key? key,
  }) : super(key: key);

  final String title;
  final VoidCallback onPressed;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
            right: AppDimens.commonPadding, left: AppDimens.commonPadding),
        child: InkWell(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: isEnabled ? onPressed : null,
          child: Center(
            child: Container(
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                  color: isEnabled ? AppColors.accentYellow : AppColors.hint,
                  borderRadius: const BorderRadius.all(Radius.circular(3))),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(
                      fontFamily: AppFonts.fontName,
                      color: isEnabled ? AppColors.white : AppColors.hint,
                      fontSize: 11,
                      fontWeight: AppFonts.semiBold),
                ),
              ),
            ),
          ),
        ),
      );
}
