import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../blocs/base/base_bloc.dart';
import '../../../../../blocs/leave/leave_bloc.dart';
import '../../../../../data/models/leave/leave_balance.dart';
import '../../../../../data/models/leave/leave_item.dart';
import '../../../../../data/models/leave_type/leave_type_data.dart';
import '../../../../../exports/constants.dart';
import '../../../../../exports/mixins.dart';
import '../../../../../exports/resources.dart';
import '../../../../../exports/themes.dart';
import '../../../../../exports/widgets.dart';
import '../../../../../services/api/api_service.dart';
import '../../../../../services/shared_preference_service.dart';
import '../../../../widgets/calendar_header.dart';
import '../../../base/base_screen.dart';
import '../../apply_leave_screen.dart';
import 'applied_leaves_list_view.dart';
import 'available_leaves_list_view.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : Leave tab view in Attendance screen
class LeaveTabView extends StatefulWidget {
  const LeaveTabView({Key? key}) : super(key: key);

  @override
  _LeaveTabViewState createState() => _LeaveTabViewState();
}

class _LeaveTabViewState extends State<LeaveTabView> with UtilityMixin {
  List<LeaveItem> _leavesList = [];
  List<LeaveItem> _monthLeavesList = [];
  List<LeaveBalance> _leavesbalanceList = [];

  late LeaveBloc _bloc;
  DateTime selectedMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _page();

  /// Created by Dev 2301 on 12/9/2021
  /// Modified by Dev 2301 on 12/9/2021
  /// Purpose : main content view for page
  Widget _page() => BaseScreen<LeaveBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        callGetLeaveAPI();
      },
      builder: (context, bloc, child) => BlocListener<LeaveBloc, BaseState>(
          listener: (context, state) {
            if (state is CallLeaveSuccessState) {
              _leavesList = state.data;
              _leavesbalanceList = state.leave;
              getLeaveList(selectedMonth);
            } else if (state is CallLeaveFailState) {
              showCustomFlushBar(context, state.msg!);
            } else if (state is ManageLeaveCallSuccessState) {
              callGetLeaveAPI();
            } else if (state is ManageLeaveCallFailState) {}
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ///month header
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: AppStyles.pageSideMargin),
                      child: CalendarHeader(
                        month: selectedMonth,
                        selectedMonth: (value) {
                          selectedMonth = value;
                          print(selectedMonth);
                          _monthLeavesList.clear();
                          getLeaveList(selectedMonth);
                        },
                      ),
                    ),

                    ///leaves list
                    AvailableLeavesListView(list: _leavesbalanceList),

                    if (_monthLeavesList.isNotEmpty)

                      ///applied leaves list
                      AppliedLeavesListView(
                        list: _monthLeavesList,
                        leaveTypes: _leavesbalanceList,
                        onItemTap: (item) {},
                        onCancel: (item) {
                          showCustomDialog(
                              context,
                              'Are you sure you want to cancel the leave??',
                              'Cancel Leave',
                              AppStrings.lblYes,
                              no: AppStrings.lblNo, yesOnPressed: () {
                            cancelLeaveAPICall(item);
                          }, noOnPressed: () {});
                        },
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Center(
                            child: Text(
                          AppStrings.msgNoDataToDisplay,
                          style: CustomTextStyle.titleTextStyle,
                        )),
                      ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),

              ///add activity button
              appCommonFlatButton(
                  btnTxt: AppStrings.lblApplyLeave, onPressed: _onApply)
            ],
          )));

  void _onApply() async {
    var tempData = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ApplyLeaveScreen(),
      ),
    );
    if (tempData) {
      callGetLeaveAPI();
    }
  }

  cancelLeaveAPICall(LeaveItem item) async {
    final userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    print('on yes clicked');
    await ApiService().checkInternet().then((internet) {
      if (internet) {
        _bloc.add(ManageLeaveAPiCall(
          leaveData: LeaveItem(
              id: item.id,
              fromDate: item.fromDate,
              toDate: item.toDate,
              isHalfDay: item.isHalfDay,
              isFirstHalf: item.isFirstHalf,
              leaveTypeId: item.leaveTypeId,
              remarks: item.remarks,
              leaveStatus: LeaveStatusId.cancelled,
              created_by: item.created_by,
              created_on: item.created_on,
              modified_by: userId,
              modified_on: getCurrentDateAndTime()),
        ));
      } else {
        showNoInternetDialog(context, content: AppStrings.msgInternetRequired);
      }
    });
  }

  callGetLeaveAPI() {
    ApiService().checkInternet().then((value) {
      if (!value) {
        showNoInternetDialog(context, content: AppStrings.msgInternetShouldOn);
      } else {
        _bloc.add(const CallLeaveApi(pageIndex: 1, fromTimeStamp: null));
      }
    });
  }

  void getLeaveList(DateTime selectedMonth) {
    setState(() {
      _monthLeavesList = _leavesList.where((element) =>
      getDateFromDateTime(element.fromDate!, format: DateFormats.mmYYYY) ==
          getDateFromDateTime(selectedMonth.toString(), format: DateFormats.mmYYYY) ||
          getDateFromDateTime(element.toDate!, format: DateFormats.mmYYYY) ==
          getDateFromDateTime(selectedMonth.toString(), format: DateFormats.mmYYYY))
          .toList();
    });
    print(_monthLeavesList.length);
  }
}
