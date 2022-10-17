import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/leave/leave_balance.dart';
import '../../../../../exports/resources.dart';
import '../../../../../exports/utilities.dart';
import '../../../../../exports/widgets.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose :available leaves list view in Leave page
class AvailableLeavesListView extends StatelessWidget {
  const AvailableLeavesListView({
    required this.list,
    Key? key,
  }) : super(key: key);

  final List<LeaveBalance> list;
  @override
  Widget build(BuildContext context) => _listView();

  Widget _listView() => ListView.builder(
    itemCount: list.length,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, i) {
      final item = list[i];
      return _buildItemView(item,i);
    },
  );

  /// Created by Dev 2301 on 12/9/2021
  /// Modified by Dev 2301 on 12/9/2021
  /// Purpose : list item view
  Widget _buildItemView(LeaveBalance item,int index) => Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
        child: Container(
          decoration: BoxDecoration(
            color: index == 0 ? Colors.grey[300] : Colors.white,
            boxShadow: const [Shadows.greyShadow],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: Get.width*.5,
                height: 100,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: bgLine(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        BoxItem(
                          title: AppStrings.lblAvail,
                          value: '${item.availLeaves}',
                          padding: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: BoxItem(
                            title: AppStrings.lblBalance,
                            value: '${item.totalLeaves}',
                            padding: 0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                item.leaveTypeName ?? '',
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight:index == 0 ? AppFonts.extraBold :AppFonts.medium),
              )))
            ],
          ),
        ),
      );
}

