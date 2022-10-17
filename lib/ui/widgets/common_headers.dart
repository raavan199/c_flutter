import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../exports/resources.dart';
import '../../exports/themes.dart';

/// Created by Dev 2301 on 12/3/2021
/// Modified by Dev 2301 on 12/3/2021
/// Purpose : simple header view that dispalys screen name and
/// is used with common container
class CommonSimpleHeader extends StatelessWidget {
  const CommonSimpleHeader(
    this.title, {
    this.subTitle,
    this.date,
    Key? key,
  }) : super(key: key);
  final String title;
  final String? subTitle;
  final String? date;

  @override
  Widget build(BuildContext context) => Container(
        height: 50,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text.rich(
                TextSpan(
                    text: title.toUpperCase(),
                    style: CustomTextStyle.screenHeaderTextStyle,
                    children: <InlineSpan>[
                      if (subTitle != null)
                        TextSpan(
                          text: subTitle!.toUpperCase(),
                          style: const TextStyle(
                              color: AppColors.accentYellow,
                              fontSize: 20,
                              fontWeight: AppFonts.normal,
                              letterSpacing: 1),
                        )
                    ]),
              ),
            ),
            if (date != null) dateView(date!)
          ],
        ),
      );
}

/// Created by Dev 2301 on 12/4/2021
/// Modified by Dev 2301 on 12/4/2021
/// Purpose : center alignment header
/// commonly used in tabbed layout screens
class CommonCenterHeader extends StatelessWidget {
  const CommonCenterHeader(
    this.title, {
    Key? key,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) => Container(
        height: 56,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title.toUpperCase(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: CustomTextStyle.screenHeaderTextStyle),
          ],
        ),
      );
}

/// Created by Dev 2301 on 12/3/2021
/// Modified by Dev 2301 on 12/3/2021
/// Purpose : detailed header with company names and action icons
class CommonDetailedHeader extends StatelessWidget {
  const CommonDetailedHeader({
    this.outletName,
    this.retailerType,
    this.retailerLocation,
    required this.screenName,
    this.showActions = false,
    this.showLocation = false,
    this.isEditEnabled = false,
    this.hasExtraPadding = false,
    this.date,
    this.editOnTap,
    this.locationOnTap,
    this.cameraOnTap,
    Key? key,
  }) : super(key: key);

  final String? outletName;
  final String? retailerType;
  final String? retailerLocation;
  final String screenName;
  final bool showActions;
  final bool showLocation;
  final bool isEditEnabled;
  final String? date;
  final VoidCallback? editOnTap;
  final VoidCallback? locationOnTap;
  final VoidCallback? cameraOnTap;

  ///pass hasExtraPadding = true when timer is displayed
  final bool hasExtraPadding;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ///name
            Row(
              children: [
                Expanded(
                  child: Text(
                    '$outletName',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: CustomTextStyle.screenHeaderTextStyle,
                  ),
                ),

                ///side actions

                if (showActions)
                  Row(
                    children: [
                      if (isEditEnabled)
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: _roundedIconWithBg(
                              AppAssets.icEdit, AppColors.white, editOnTap),
                        ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: _roundedIconWithBg(
                            AppAssets.icCamera, AppColors.white, cameraOnTap),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: _roundedIconWithBg(AppAssets.iclocation,
                            AppColors.white, locationOnTap),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ///location
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "$retailerType | $retailerLocation",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: AppFonts.normal,
                      ),
                    ),
                  ),
                  if(date !=null)
                    dateView(date!)
                ],
              ),
            ),
          ],
        ),
      );

  Widget _roundedIconWithBg(
          String imagePath, Color backgroundColor, VoidCallback? onTap) =>
      InkWell(
        onTap: onTap ?? () {},
        child: Container(
          width: 30,
          height: 30,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: SvgPicture.asset(imagePath),
        ),
      );
}

/// Created by Dev 2301 on 12/4/2021
/// Modified by Dev 2301 on 12/4/2021
/// Purpose : date view widget used in header
Widget dateView(String date) => Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          AppAssets.icCalendar,
          height: 15,
          width: 15,
          color: Colors.white,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5,top: 2),
          child: Text(date,
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 14,
                  fontWeight: AppFonts.normal)),
        )
      ],
    );

/// Created by Dev 2183 on 12/28/2021
/// Modified by Dev 2183 on 12/28/2021
/// Purpose :to display icon and texts in header
class CommonRouteHeader extends StatelessWidget {
  const CommonRouteHeader(
      {required this.routeCount, required this.outletCount, Key? key})
      : super(key: key);

  final String routeCount;
  final String outletCount;

  @override
  Widget build(BuildContext context) => Container(
        height: 45,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppAssets.icRouter,
              width: 15,
              height: 15,
              color: AppColors.white,
            ),
            const Padding(padding: EdgeInsets.only(right: 7)),
            Text.rich(
              TextSpan(
                  text: '$routeCount ',
                  style: CustomTextStyle.buttonTextStyle,
                  children: <InlineSpan>[
                    TextSpan(
                      text: AppStrings.lblRoutes,
                      style: CustomTextStyle.buttonTextStyle,
                    )
                  ]),
            ),
            const Spacer(),
            SvgPicture.asset(
              AppAssets.icOutlet,
              width: 15,
              height: 15,
              color: AppColors.white,
            ),
            const Padding(padding: EdgeInsets.only(right: 7)),
            Text.rich(
              TextSpan(
                  text: '$outletCount ',
                  style: CustomTextStyle.buttonTextStyle,
                  children: <InlineSpan>[
                    TextSpan(
                      text: AppStrings.lblOnlyOutlets,
                      style: CustomTextStyle.buttonTextStyle,
                    )
                  ]),
            ),
          ],
        ),
      );
}
