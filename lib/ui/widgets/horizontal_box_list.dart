import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:popover/popover.dart';

import '../../exports/mixins.dart';
import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../exports/utilities.dart';
import '../../resources/app_assets.dart';
import 'common_info_icon.dart';
import 'common_popup_widget.dart';

/// Created by Dev 2301 on 12/2/2021
/// Modified by Dev 2301 on 12/2/2021
/// Purpose : common horizontal boxes list view
class HorizontalBoxesView extends StatelessWidget with UtilityMixin {
  HorizontalBoxesView({required this.list, required this.itemClick, Key? key})
      : super(key: key);

  final List<HorizontalBoxListModel> list;
  final Function itemClick;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 110,
        child: Stack(
          children: [
            Center(
              child: bgLine(),
            ),
            Center(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: List.generate(
                  list.length,
                  (i) => InkWell(
                    onTap: () => itemClick(i),
                    child: BoxItem(
                      title: list.elementAt(i).routeName,
                      value: list.elementAt(i).count,
                      informationIcon:
                          list.elementAt(i).informationIcon ?? false,
                      informationTitle: list.elementAt(i).informationTitle,
                      informationDetail: list.elementAt(i).informationDetail,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );

// Widget _buildItem(HorizontalCircularListModel item) => Container(
//       padding: const EdgeInsets.all(12),
//       child: Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               shape: BoxShape.circle,
//               boxShadow: [Shadows.blueShadow],
//             ),
//             child: CircleAvatar(
//               radius: 30,
//               backgroundColor: AppColors.accentYellow,
//               child: Text(
//                 item.count,
//                 style: const TextStyle(
//                     fontWeight: FontWeight.bold, color: Colors.white),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           Text(
//             item.routeName,
//             style: const TextStyle(
//               color: Colors.black,
//               fontSize: 13,
//               fontWeight: AppFonts.medium,
//             ),
//           )
//         ],
//       ),
//     );
}

Widget bgLine() => Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 1,
          color: const Color(0xffEEEDED),
          // color: Colors.red,
        ),
        const SizedBox(
          height: 1,
        ),
        Container(
          height: 3,
          color: const Color(0xffEEEDED),
          // color: Colors.red,
        )
      ],
    );

class BoxItem extends StatelessWidget with UtilityMixin {
  BoxItem(
      {required this.title,
      required this.value,
      this.padding = 12,
      this.informationIcon,
      this.informationTitle,
      this.informationDetail,
      Key? key})
      : super(key: key);

  final String title;
  final String value;
  final double padding;
  bool? informationIcon;
  String? informationTitle;
  String? informationDetail;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(padding),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [Shadows.greyShadow],
                borderRadius: BorderRadius.circular(5),
              ),
              height: 80,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: CustomTextStyle.filterHeaderTextStyle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    value,
                    style: CustomTextStyle.filterValueTextStyle,
                  ),
                ],
              ),
            ),
            if (informationIcon == true)
              CommonInfoIcon(title: informationTitle ?? "",
              description: informationDetail ?? "",),
            const SizedBox(width: 91,),
          ],
        ),
      );
}
