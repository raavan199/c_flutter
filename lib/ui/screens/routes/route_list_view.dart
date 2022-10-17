import 'package:flutter/material.dart';

import '../../../data/models/route/get_route_by_user_items.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../utilities/shadow.dart';
import 'routes_info_screen.dart';

/// Created by Dev 2301 on 12/2/2021
/// Modified by Dev 2301 on 12/2/2021
/// Purpose :
class RouteListView extends StatelessWidget with UtilityMixin {
  const RouteListView({required this.routeNameList, Key? key})
      : super(key: key);
  final List<RouteItems> routeNameList;
  double get _sidePadding => 15;

  @override
  Widget build(BuildContext context) => ListView.builder(
        shrinkWrap: true,
        itemCount: routeNameList.length,
        padding: const EdgeInsets.only(
          left: AppStyles.pageSideMargin,
          right: AppStyles.pageSideMargin,
        ),
        itemBuilder: (context, i) {
          final item = routeNameList.elementAt(i);
          return InkWell(
            onTap: () {
              navigationPush(
                  context,
                  RoutesInfoScreen(
                    routeName: item.name ?? "",
                    routeId: item.id ?? 0,
                  ));
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [Shadows.greyShadow],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: 10,
                        left: _sidePadding,
                      ),
                      child: Text(
                        item.name ?? "",
                        style: const TextStyle(
                            color: AppColors.black,
                            fontSize: 14,
                            fontWeight: AppFonts.semiBold),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      right: _sidePadding,
                      left: 10,
                    ),
                    child: Row(
                      children: [
                        Text(
                          "${AppStrings.lblOutlets} :"
                          " ${item.totalOutlets} | ",
                          style: CustomTextStyle.smallTextStyle,
                        ),
                        Text(
                          '${AppStrings.lblVisited} :'
                          ' ${item.visitsCount}',
                          style: CustomTextStyle.smallTextStyle,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
}
