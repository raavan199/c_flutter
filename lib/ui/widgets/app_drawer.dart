import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/login/login_data_response.dart';
import '../../exports/mixins.dart';
import '../../exports/resources.dart';
import '../../exports/utilities.dart';
import '../../services/shared_preference_service.dart';
import '../screens/attendance/attendance_screen.dart';
import '../screens/login/login_screen.dart';
import '../screens/routes/route_screen.dart';
import '../screens/timeline/timeline_screen.dart';

/// Created by Dev 2301 on 11/30/2021
/// Modified by Dev 2301 on 11/30/2021
/// Purpose : app drawer of in the app
class AppDrawer extends StatefulWidget {
  const AppDrawer(
      {required this.selectedIndex,
      //this.userName,
      //this.userDesignation,
      Key? key})
      : super(key: key);

  final int selectedIndex;
  //final String? userName;
  //final String? userDesignation;

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> with UtilityMixin {
  /// Created by Dev 2301 on 11/30/2021
  /// Modified by Dev 2301 on 03/16/2022
  /// Purpose : drawer item list
  List<DrawerItemModel> _drawerItemList(BuildContext context) => [
        DrawerItemModel(AppStrings.lblDashboard, AppAssets.icDashboard, () {}),
        DrawerItemModel(AppStrings.lblAttendance, AppAssets.icAttendance, () {
          clearStackAndAddScreen(context, const AttendanceScreen());
        }),
        DrawerItemModel(AppStrings.lblTimeline, AppAssets.icTimeLine, () {
          clearStackAndAddScreen(context, const TimelineScreen());
        }),
        DrawerItemModel(AppStrings.lblRoutes, AppAssets.icRoute, () {
          clearStackAndAddScreen(context, const RouteScreen());
        }),
        DrawerItemModel(AppStrings.lblCatalogue, AppAssets.icLayer, () {}),
        DrawerItemModel(
            AppStrings.lblWorkSummary, AppAssets.icWorkSummary, () {}),
        DrawerItemModel(AppStrings.lblMovement, AppAssets.icMovement, () {}),
        DrawerItemModel(AppStrings.lblClaims, AppAssets.icClaims, () {}),
        // DrawerItemModel(AppStrings.lblLeaves, AppAssets.icLeaves, () {}),
        DrawerItemModel(AppStrings.lblSettings, AppAssets.icSetting, () {}),
        DrawerItemModel(AppStrings.lblHelp, AppAssets.icHelp, () {}),
        DrawerItemModel(AppStrings.lblLogout, AppAssets.icLogOut, () {
          _logout(context);
        }),
      ];
  LoginDataResponse? loginDataResponse;

  @override
  void initState() {
    super.initState();
    fetchUserDataFromSharedPreference().then((value) {
      setState(() {
        loginDataResponse = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(context).unfocus();

    Logger.d("App Drawer", "");
    final itemList = _drawerItemList(context);
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Colors.transparent,
      ),
      child: Drawer(
        elevation: 0,
        child: SafeArea(
          child: Container(
            margin: const EdgeInsets.only(top: 60),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(AppStyles.commonCornerRadius)),
            ),
            child: Column(
              children: <Widget>[
                _buildHeader(context),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: List<Widget>.generate(
                      itemList.length,
                      (index) => _buildDrawerItem(
                        assetPath: itemList[index].image,
                        text: itemList[index].title,
                        color: index == widget.selectedIndex
                            ? AppColors.primary
                            : AppColors.black,
                        onTap: itemList[index].onTap,
                      ),
                    ).toList(),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Created by Dev 2301 on 11/30/2021
  /// Modified by Dev 2301 on 11/30/2021
  /// Purpose : header view
  Widget _buildHeader(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            ClipOval(
              child: Container(
                  height: 66,
                  width: 66,
                  color: AppColors.primary,
                  alignment: Alignment.center,
                  child: /*user.profileUrl == null
                    ?*/
                      Center(
                    child: SvgPicture.asset(
                      AppAssets.imgPOS,
                      // height: 70,
                      // width: 70,
                      color: Colors.white,
                      fit: BoxFit.scaleDown,
                    ),
                  )
                  /*: Image.memory(
                        base64Decode(user.profileUrl),
                        fit: BoxFit.cover,
                        height: 120,
                        width: 120,
                      ),*/
                  ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      loginDataResponse?.fullName ?? "",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: AppFonts.normal,
                          color: AppColors.primary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      loginDataResponse?.userRoleName ?? "",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: AppFonts.normal,
                        color: AppColors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _close(context),
          ],
        ),
      );

  /// Created by Dev 2301 on 11/30/2021
  /// Modified by Dev 2301 on 11/30/2021
  /// Purpose : close button
  Widget _close(BuildContext context) => Align(
        alignment: Alignment.topRight,
        child: SizedBox(
          height: 40,
          width: 40,
          child: MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.close,
              size: 25,
              color: AppColors.secondary,
            ),
          ),
        ),
      );

  /// Created by Dev 2301 on 11/30/2021
  /// Modified by Dev 2301 on 11/30/2021
  /// Purpose : drawer menu item widget
  Widget _buildDrawerItem(
          {required String assetPath,
          required String text,
          required Color color,
          required GestureTapCallback onTap}) =>
      InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          height: 50,
          child: Row(
            children: <Widget>[
              SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset(
                  assetPath,
                  color: color,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Text(
                  text,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 14, fontWeight: AppFonts.normal, color: color),
                ),
              )
            ],
          ),
        ),
      );

  /// Created by Dev 2301 on 11/30/2021
  /// Modified by Dev 2301 on 11/30/2021
  /// Purpose : method to open screen
  void _openScreen(BuildContext context, Widget screen) {
    /* Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => screen), (route) => false);*/
  }

  void _logout(BuildContext context) {
    clearStackAndAddScreen(context, const LoginScreen());
  }

  Future<LoginDataResponse> fetchLoginDataResponse() async {
    final a =
        await SharedPreferenceService().getStringValuesSF('loginDataResponse');
    Map<String, dynamic> valueMap = json.decode(a!);
    final b = LoginDataResponse.fromJson(valueMap);
    print(b);
    return b;
  }
}

/// Created by Dev 2301 on 11/30/2021
/// Modified by Dev 2301 on 11/30/2021
/// Purpose : model class for drawer item
class DrawerItemModel {
  DrawerItemModel(this.title, this.image, this.onTap);

  final String title;
  final String image;
  final VoidCallback onTap;
}
