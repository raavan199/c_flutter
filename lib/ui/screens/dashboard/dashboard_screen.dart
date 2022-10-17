import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

import '../../../data/models/login/login_data_response.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> with UtilityMixin {
  Map<String, int> effortSummaryMap = {};
  Map<String, int> salesSummaryMap = {};
  Map<String, int> attendanceMap = {};
  final DateTime _currentDate = DateTime.now();
  LoginDataResponse? loginDataResponse;

  // ignore: unused_field
  final EventList<Event> _markedDateMap = EventList<Event>(
    events: {
      DateTime(2019, 2, 10): [
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 1',
          dot: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            color: Colors.red,
            height: 5,
            width: 5,
          ),
        ),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 2',
        ),
        Event(
          date: DateTime(2019, 2, 10),
          title: 'Event 3',
        ),
      ],
    },
  );

  @override
  void initState() {
    super.initState();
    fetchUserDataFromSharedPreference().then((value) {
      setState(() {
        loginDataResponse = value;
      });
    });
    effortSummaryMap = {
      'Visits': 0,
      'Joint Visit': 0,
      'Avg. Time Spent': 0,
      'Total Work Time': 0,
      'Productivity Ratio': 0,
      'Missed Visits': 0
    };
    salesSummaryMap = {
      'Orders': 0,
      'Total Order Value': 0,
      'Avg. Order Value': 0,
      'No Orders': 0,
      'Total Collection': 0,
      'Total Due': 0
    };
    attendanceMap = {
      'Present': 0,
      'Absent': 0,
      'Half Days': 0,
      'Leaves Token': 0
    };
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: CustomAppBar(title: AppStrings.lblDashboard,),
        drawer: AppDrawer(
          selectedIndex: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: AppColors.primary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(AppStrings.lblDashboard.toUpperCase(),
                    style: const TextStyle(
                        fontWeight: AppFonts.extraBold,
                        fontSize: 20,
                        color: Colors.white,
                        letterSpacing: 1)),
                const SizedBox(
                  height: 15,
                ),
                const Text('01/Sep/2021 - 16/Sep/2021',
                    style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1,
                        fontSize: 12,
                        decoration: TextDecoration.underline)),
                const SizedBox(
                  height: 25,
                ),
                GridView.count(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 10,
                  children: [
                    customCard(AppStrings.lblEffortSummary, '16 Sep 2021',
                        effortSummaryMap),
                    customCard(AppStrings.lblSalesSummary, '16 Sep 2021',
                        salesSummaryMap),
                    customCard(AppStrings.lblAttendance, 'September 2021',
                        attendanceMap),
                    customCard(AppStrings.lblCalendar, '', null),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  Widget customCard(String title, String date, Map<String, int>? map) => Stack(
        children: <Widget>[
          Positioned(
            top: 8,
            right: 0,
            left: 0,
            child: Card(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Container(
                width: 200,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: title != AppStrings.lblCalendar
                    ? const EdgeInsets.all(20)
                    : EdgeInsets.zero,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      date,
                      style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 10,
                          fontWeight: AppFonts.extraBold),
                    ),
                    SizedBox(
                      height: title != AppStrings.lblCalendar ? 15 : 0,
                    ),
                    if (title != AppStrings.lblCalendar)
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: map!.length,
                          itemBuilder: (context, i) => Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: innerCardDetailWidget(map, i),
                              ))
                    else
                      Container(),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 0,
            right: 15,
            child: Container(
              alignment: Alignment.center,
              color: AppColors.accentYellow,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 12, fontWeight: AppFonts.normal),
              ),
            ),
          ),
        ],
      );

  Widget innerCardDetailWidget(Map<String, int> map, int i) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            map.keys.elementAt(i).toString(),
            style:
                const TextStyle(fontWeight: AppFonts.extraBold, fontSize: 11),
          ),
          Text(
            map.values.elementAt(i).toString(),
            style: const TextStyle(
              fontSize: 11,
            ),
          )
        ],
      );
}
