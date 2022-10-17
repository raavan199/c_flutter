import 'package:cygneto/services/api/api_service.dart';
import 'package:cygneto/ui/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../login/login_screen.dart';
import '../sync_data/sync_data_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with UtilityMixin {
  List<HomeModel> titleList = [];

  @override
  void initState() {
    super.initState();
    titleList
      ..add(HomeModel('field sales', AppAssets.imgFieldSales, () {
        ApiService().checkInternet().then((internet) {
          if (internet) {
            _onClickGridItem(const SyncDataScreen());
          } else {
            _onClickGridItem(const DashBoardScreen());
          }
        });


      }))
      ..add(HomeModel('distribution', AppAssets.imgDistribution, () {}))
      ..add(HomeModel('van sales', AppAssets.imgVan, () {}))
      ..add(HomeModel('pos', AppAssets.imgPOS, () {}))
      ..add(HomeModel('E-commerce', AppAssets.imgECommerce, () {}))
      ..add(HomeModel('accounting', AppAssets.imgAccounting, () {}))
      ..add(HomeModel('settings', AppAssets.imgSettings, () {}))
      ..add(HomeModel('help', AppAssets.imgSupport, () {}))
      ..add(HomeModel('about', AppAssets.imgAboutUs, () {}));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          height: Get.height,
          color: AppColors.primary,
          child: Stack(
            children: [
              ///Cygnet logo
              ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 50, left: 50, right: 50),
                    child: SvgPicture.asset(
                      AppAssets.icLogoLarge,
                    ),
                  ),

                  ///module grid
                  GridView.count(
                    padding: const EdgeInsets.only(bottom: AppStyles.primaryButtonHeight),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 10,
                    children: List<Widget>.generate(titleList.length,
                        (index) => _gridItem(titleList.elementAt(index))),
                  ),
                ],
              ),

              ///logout button
              Align(
                alignment: Alignment.bottomRight,
                child: _btnLogout(),
              ),

            ],
          ),
        ),
      );

  Widget _btnLogout() => InkWell(
    onTap: _onClickLogout,
    child: Container(
      height: AppStyles.primaryButtonHeight,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppStyles.commonCornerRadius)),
      ),
      width: (MediaQuery.of(context).size.width / 2) - 25,
      child: const Center(
        child: Text(
          AppStrings.lblLogout,
          style: TextStyle(
              color: AppColors.primary,
              fontWeight: AppFonts.bold,
              fontSize: 16),
        ),
      ),
    ),
  );

  Widget _gridItem(HomeModel item) => InkWell(
        onTap: item.onTap,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(children: [
          SizedBox(
            height: 120,
            width: 140,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.asset(
                item.image,
                height: 70,
                width: 100,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(item.title.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: AppFonts.normal)),
        ]),
      );

  void _onClickGridItem(Widget screen) {
    clearStackAndAddScreen(context, screen);
  }

  void _onClickLogout() {
    //redirect to login
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}

class HomeModel {
  HomeModel(this.title, this.image, this.onTap);

  final String title;
  final String image;
  final VoidCallback onTap;
}
