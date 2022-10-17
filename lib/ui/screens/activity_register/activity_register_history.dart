import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/actitivy_history/activity_history_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../data/models/activty_register/activity_registered_item.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../mixins/utility_mixin.dart';
import '../../../services/api/api_service.dart';
import '../base/base_screen.dart';
import 'activity_details_screen.dart';

class ActivityRegisterHistoryScreen extends StatefulWidget {
  const ActivityRegisterHistoryScreen({Key? key}) : super(key: key);

  @override
  _ActivityRegisterHistoryScreenState createState() =>
      _ActivityRegisterHistoryScreenState();
}

class _ActivityRegisterHistoryScreenState
    extends State<ActivityRegisterHistoryScreen> with UtilityMixin {
  final List<ActivityRegisteredItem> _activityHistoryList = [];
  final List<ActivityRegisteredItem> _activityHistoryDisplayList = [];

  late ActivityHistoryBloc _bloc;

  DateTime startDate = DateTime(
      DateTime.now().year, DateTime.now().month - 1, DateTime.now().day);
  DateTime endDate = DateTime.now();

  int deleteIndex = -1;

  @override
  Widget build(BuildContext context) => BaseScreen<ActivityHistoryBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
          _bloc.add(GetActivityHistory(
              startDate: startDate.toString(), endDate: endDate.toString()));
        },
        builder: (context, bloc, child) =>
            BlocListener<ActivityHistoryBloc, BaseState>(
                listener: (context, state) {
                  if (state is GetActivityHistorySuccessState) {
                    _activityHistoryList.clear();
                    _activityHistoryDisplayList.clear();
                    for (final value in state.data) {
                      _activityHistoryList.add(
                          ActivityRegisteredItem.fromJsonForRowQuery(value));
                    }
                    print(_activityHistoryList.length);
                    setState(() {
                      _activityHistoryDisplayList.addAll(_activityHistoryList);
                    });
                    print("GetActivityHistorySuccessState");
                  } else if (state is GetActivityHistoryFailedState) {
                    print("GetActivityHistoryFailedState");
                  } else if (state is DeleteActivityAPISuccessState) {
                    _bloc.add(GetActivityHistory(
                        startDate: startDate.toString(),
                        endDate: endDate.toString()));
                  } else if (state is DeleteActivityAPIFailedState) {
                    print("DeleteActivityAPIFailedState");
                    showCustomFlushBar(context, state.msg);
                  } else if (state is DeleteActivityByIdFailedState) {
                    print("DeleteActivityAPIFailedState");
                    showCustomFlushBar(context, state.msg);
                  } else if (state is DeleteActivityByIdSuccessState) {
                    _bloc.add(GetActivityHistory(
                        startDate: startDate.toString(),
                        endDate: endDate.toString()));
                  }
                },
                child: Scaffold(
                  appBar: CustomAppBar(
                    title: AppStrings.lblActivityHistory,
                    hasBack: true,
                  ),
                  body: SafeArea(
                    child: CommonContainer(
                      child: _buildHistoryScreenView(),
                    ),
                  ),
                )),
      );

  Widget _buildHistoryScreenView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: InkWell(
                        onTap: () async {
                          await showDateRangePicker(
                                  context: context,
                                  firstDate: DateTime(DateTime.now().year - 10,
                                      DateTime.now().month, DateTime.now().day),
                                  lastDate: DateTime.now(),
                              initialEntryMode: DatePickerEntryMode.calendarOnly)
                              .then((value) {
                            setState(() {
                              startDate = value!.start;
                              endDate = value.end;
                              _bloc.add(GetActivityHistory(
                                  startDate: startDate.toString(),
                                  endDate: endDate.toString()));
                            });
                          });
                        },
                        child: Text(
                          '${getDateFromDateTime(startDate.toIso8601String())} - ${getDateFromDateTime(endDate.toIso8601String())}',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 12,
                            fontWeight: AppFonts.extraBold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (_activityHistoryDisplayList.isNotEmpty)
                      _buildListview()
                    else
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          AppStrings.msgNoDataToDisplay,
                          style: CustomTextStyle.titleTextStyle,
                        ),
                      )),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  void getActivityHistory() => _bloc.add(GetActivityHistory(
        startDate: startDate.toString(), endDate: endDate.toString()));

  Widget _buildListview() => ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _activityHistoryDisplayList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [Shadows.greyShadow],
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                navigationPush(
                    context,
                    ActivityDetailScreen(
                        data: _activityHistoryDisplayList[index]));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _TextField(
                                  getDateFromDateTime(
                                      _activityHistoryDisplayList[index].date!,
                                      format: DateFormats.ddMMyyyyDash),
                                  CustomTextStyle.calendarHeaderTextStyle),
                            ],
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Row(
                            children: [
                              _TextField(
                                get12HTimeString(
                                    _activityHistoryDisplayList[index]
                                        .startTime!),
                              ),
                              Text(" - ",
                                  style: CustomTextStyle.smallGreyTextStyle),
                              _TextField(get12HTimeString(
                                  _activityHistoryDisplayList[index].endTime!)),
                            ],
                          ),
                        ]),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: _TextField(
                              _activityHistoryDisplayList[index]
                                  .activityTypeName!,
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 8),
                            child: InkWell(
                              onTap: () {
                                deleteIndex = index;
                                showCustomDialog(
                                    context,
                                    "Are you sure?",
                                    "Delete Activity!",
                                    AppStrings.lblYes, yesOnPressed: () {
                                  deleteActivity(
                                      _activityHistoryDisplayList[index]);
                                }, no: AppStrings.lblNo);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: AppColors.colorError,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ));

  Widget _TextField(String textTitle, [TextStyle? titleTextStyle]) => Text(
        textTitle,
        style: titleTextStyle ?? CustomTextStyle.smallGreyTextStyle,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
      );

  void deleteActivity(ActivityRegisteredItem activity) {
    if (activity.isSync == SyncStatus.sync) {
      ApiService().checkInternet().then((internet) {
        if (internet) {
          _bloc.add(DeleteActivityAPICall(id: activity.id!));
        } else {
          showCustomDialog(
              context,
              "Required internet connection for delete registered activity",
              AppStrings.lblNoInternet,
              AppStrings.ok);
        }
      });
    } else {
      _bloc.add(DeleteActivityById(id: activity.id!));
    }
  }
}
