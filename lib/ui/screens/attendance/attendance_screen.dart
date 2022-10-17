import 'package:flutter/material.dart';

import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../widgets/custom_tab_bar.dart';
import 'tabs/leave/leaves_tab_view.dart';
import 'tabs/missed_punch/missed_punch_tab_view.dart';
import 'tabs/timesheet/timesheet_tab_view.dart';

/// Created by Dev 2301 on 12/2/2021
/// Modified by Dev 2301 on 12/2/2021
/// Purpose : attendance screen open from side menu
/// on tapping 2nd item "Attendance"
class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with UtilityMixin, TickerProviderStateMixin {
  late TabController _tabController;
  TabItems _currentTab = TabItems.timeSheet;

  void _selectTab(TabItems tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
    } else {
      setState(() {
        _currentTab = tabItem;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTab = TabItems.values[_tabController.index];
      });
    });
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => hideKeyboard(context),
        child: Scaffold(
          appBar: CustomAppBar(
            title: AppStrings.lblAttendance,
          ),
          drawer: const AppDrawer(
            selectedIndex: 1,
          ),
          body: SafeArea(
            child: Container(
              color: AppColors.primary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomTabBar(
                      currentTab: _currentTab,
                      onSelectTab: _selectTab,
                      controller: _tabController),
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(AppStyles.commonCornerRadius),
                          topRight:
                              Radius.circular(AppStyles.commonCornerRadius)),
                      child: Container(
                        decoration: AppStyles.commonContainer,
                        // color: Colors.grey,
                        child: TabBarView(
                          controller: _tabController,
                          children: const [
                            TimeSheetTabView(),
                            MissedPunchTabView(),
                            LeaveTabView(),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
