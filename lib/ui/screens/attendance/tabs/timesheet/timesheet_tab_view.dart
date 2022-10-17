import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../blocs/attendance/attendance_bloc.dart';
import '../../../../../blocs/base/base_bloc.dart';
import '../../../../../constants/app_constants.dart';
import '../../../../../data/models/attendance/total_calculation.dart';
import '../../../../../exports/mixins.dart';
import '../../../../../exports/models.dart';
import '../../../../../exports/resources.dart';
import '../../../../../exports/widgets.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/shared_preference_service.dart';
import '../../../../widgets/event_calendar.dart';
import '../../../base/base_screen.dart';
import '../../../activity_register/activity_register_screen.dart';
import 'time_sheet_list_view.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : time sheet tab view in Attendance screen
class TimeSheetTabView extends StatefulWidget {
  const TimeSheetTabView({Key? key}) : super(key: key);

  @override
  _TimeSheetTabViewState createState() => _TimeSheetTabViewState();
}

class _TimeSheetTabViewState extends State<TimeSheetTabView> with UtilityMixin {
  List<HorizontalBoxListModel> _leavesList = [];
  AttendanceDetails lastAttendanceDetail = AttendanceDetails();
  List<AttendanceItem> attendanceItem = [];
  List<AttendanceDetails> attendancedetail = [];
  TotalCalculation totalDetail = TotalCalculation();
  DateTime currentMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);

  late AttendanceBloc _bloc;
  int punchType = 0;

  var calenderDate = DateTime.now();
  var calenderMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BaseScreen<AttendanceBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
       getLastAttendance();
        _bloc.add(CalculatePresentAbsentAndLeave(
            startDateOfMonth: DateFormat('yyyy-MM-dd').format(calenderMonth),
            endDateOfMonth: getCurrentDate(format: DateFormats.yyyyMMddDash),
        lastDateOfMonth: getDateFromDate(DateTime(
            calenderMonth.year, calenderMonth.month + 1, 0),
            format: DateFormats.yyyyMMddDash)));
        getAttendanceItem();
      },
      builder: (context, bloc, child) =>
          BlocListener<AttendanceBloc, BaseState>(
              listener: (context, state) {
                if (state is GetLastAttendanceSuccessState) {
                  var data = state.data as List<Map<dynamic, dynamic>>;
                  if (data.isEmpty) {
                    lastAttendanceDetail = AttendanceDetails();
                  } else {
                    setState(() {
                      lastAttendanceDetail =
                          AttendanceDetails.fromJsonForRowQuery(state.data[0]);
                    });
                  }
                  print("GetLastAttendanceSuccessState");
                } else if (state is GetLastAttendanceFailState) {
                } else if (state is GetAttendanceItemSuccessState) {
                  setState(() {
                    attendanceItem = state.data;
                  });
                  print("GetAttendanceSuccessState");
                } else if (state is GetAttendanceItemFailState) {
                } else if (state is CalcPresentAbsentAndLeaveSuccessState) {
                  setState(() {
                    totalDetail =
                        TotalCalculation.fromJsonForRowQuery(state.data[0]);
                    _leavesList = [
                      HorizontalBoxListModel(
                          totalDetail.totalAttendance.toString() ?? '0',
                          'Present'),
                      HorizontalBoxListModel(
                          totalDetail.totalAbsent.toString() ?? '0', 'Absent'),
                      HorizontalBoxListModel(
                          totalDetail.totalLeave.toString() ?? '0', 'Leaves'),
                    ];
                  });
                  print("CalcPresentAbsentAndLeaveSuccessState");
                } else if (state is CalcPresentAbsentAndLeaveFailState) {
                } else if (state is InsertAttendanceSuccessState) {
                  setState(getAttendanceItem);
                  print('InsertAttendanceSuccessState');
                  uploadUnSyncRecords();
                } else if (state is InsertAttendanceFailState) {
                } else if (state is UpdateAttendanceSuccessState) {
                  print('UpdateAttendanceSuccessState');
                  setState(getAttendanceItem);
                  uploadUnSyncRecords();
                } else if (state is UpdateAttendanceFailState) {
                } else if (state is ImageUploadSuccessState) {
                  print('ImageUploadSuccessState');
                } else if (state is ImageUploadFailedState) {
                } else if (state is AttendanceUploadSuccessState) {
                  print('AttendanceUploadSuccessState');
                  setState(getAttendanceItem);

                } else if (state is AttendanceUploadFailedState) {}
              },
              child: _page()));

  /// Created by Dev 2301 on 12/9/2021
  /// Modified by Dev 2301 on 12/9/2021
  /// Purpose : main content view for page
  Widget _page() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView(
              children: [
                ///calendar
                SizedBox(
                    /*height: 300,*/
                    child: EventCalendar(
                  list: attendanceItem,
                  selectedDate: (dateTime) {
                    calenderDate = dateTime;
                    _bloc.add(GetLastAttendanceDetail(
                        todayDate: getDateFromDate(dateTime,
                            format: DateFormats.yyyyMMddDash)));
                  },
                  selectedMonth: (month) {
                    setState(() {
                      calenderMonth = month;
                    });
                    var lastdate = DateTime(
                        calenderMonth.year, calenderMonth.month + 1, 0);
                    _bloc.add(CalculatePresentAbsentAndLeave(
                        startDateOfMonth:
                            DateFormat('yyyy-MM-dd').format(calenderMonth),
                        endDateOfMonth: getDateFromDate(calenderMonth) ==
                                getDateFromDate(currentMonth)
                            ? getCurrentDate(format: DateFormats.yyyyMMddDash)
                            : getDateFromDate(lastdate,
                                format: DateFormats.yyyyMMddDash),
                    lastDateOfMonth: getDateFromDate(lastdate,
                        format: DateFormats.yyyyMMddDash)));
                  },
                )),

                ///month header
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text(
                    DateFormat('MMMM yyyy').format(calenderMonth),
                    style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontSize: 16,
                        fontWeight: AppFonts.bold,
                        color: AppColors.black),
                  ),
                ),

                ///leaves list
                HorizontalBoxesView(
                  list: _leavesList,
                  itemClick: () {},
                ),

                ///time sheet entry list
                TimeSheetListView(
                  onItemTap: (item) {},
                  selectedDate: calenderDate,
                  lastattendanceDetail: lastAttendanceDetail,
                  attendanceCaptureDetail: (newAttendanceDetail) {
                    addAttendanceIntoDB(newAttendanceDetail);
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),

          ///add activity button
          appCommonFlatButton(
              btnTxt: AppStrings.lblAddActivity, onPressed: onButtonTap)
        ],
      );

  /// Created by Dev 2301 on 12/9/2021
  /// Modified by Dev 2301 on 12/9/2021
  /// Purpose : on bottom button tap method
  void onButtonTap() {
    navigationPush(
        context, const ActivityRegisterScreen(isFromAttendance: true));
  }

  void addAttendanceIntoDB(AttendanceDetails attendanceDetails) async {
    int userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    var attendanceId = generateRandomNumber();
    String createdOn = getCurrentDateAndTime();
    print('AttendanceInto DB call ${attendanceDetails.id}');
    if (attendanceDetails.attendanceId == null) {
      attendanceDetails.id = generateRandomNumber();
      attendanceDetails.attendanceId = attendanceId;
      attendanceDetails.created_by = userId;
      attendanceDetails.created_on = createdOn;
      attendanceDetails.status = BaseStatus.active;
      attendanceDetails.isSync = SyncStatus.unSync;
      lastAttendanceDetail = attendanceDetails;
      _bloc.add(InsertAttendanceIntoDB(
          attendanceItem: AttendanceItem(
              id: attendanceId,
              status: BaseStatus.active,
              created_on: createdOn,
              isSync: SyncStatus.unSync,
              attendanceStatus: 1,
              created_by: userId),
          attendanceDetails: lastAttendanceDetail));
    } else {
      if (attendanceDetails.id == null) {
        attendanceDetails.id = generateRandomNumber();
        attendanceDetails.created_by = userId;
        attendanceDetails.created_on = createdOn;
        attendanceDetails.isSync = SyncStatus.unSync;
      } else {
        attendanceDetails.modified_by = userId;
        attendanceDetails.modified_on = createdOn;
        attendanceDetails.isSync = SyncStatus.unSync;
      }
      lastAttendanceDetail = attendanceDetails;
      _bloc.add(UpdatePunchOutIntoDB(
          attendanceItem: AttendanceItem(
              id: attendanceDetails.attendanceId,
              modified_on: createdOn,
              modified_by: userId),
          attendanceDetails: lastAttendanceDetail));
    }
  }

  uploadUnSyncRecords() async {
    await ApiService().checkInternet().then((internet) {
      if (internet) {
        _bloc.add(const UploadUnSyncRecords());
      }
    });
  }

  void getLastAttendance() {
    _bloc.add(GetLastAttendanceDetail(
        todayDate:
        getCurrentDate(format: DateFormats.yyyyMMddDash)));
  }
  void getAttendanceItem() {
    _bloc.add(const GetAttendanceItem());
  }
}
