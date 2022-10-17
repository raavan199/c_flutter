import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../blocs/activity_register/activity_register_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../data/models/activty_register/activity_register_type_data.dart';
import '../../../data/models/activty_register/activity_registered_item.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../../../services/shared_preference_service.dart';
import '../../widgets/custom_dropdown_activity_register_type.dart';
import '../base/base_screen.dart';
import 'activity_register_history.dart';

/// Created by Dev 2301 on 12/2/2021
/// Modified by Dev 2301 on 12/2/2021
/// Purpose : activity register  screen open from Attendance screen
/// on tapping add activity button
class ActivityRegisterScreen extends StatefulWidget {
  const ActivityRegisterScreen({required this.isFromAttendance, Key? key})
      : super(key: key);

  final bool isFromAttendance;

  @override
  _ActivityRegisterScreenState createState() => _ActivityRegisterScreenState();
}

class _ActivityRegisterScreenState extends State<ActivityRegisterScreen>
    with UtilityMixin, ValidationMixin {
  DateTime currentDate = DateTime.now();
  final TextEditingController _startTimeController = TextEditingController();
  final TextEditingController _endTimeController = TextEditingController();
  final TextEditingController _activtyDetailController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<ActivityRegisterTypeData> activityTypeList = [];
  ActivityRegisterTypeData activityType = ActivityRegisterTypeData();

  DateTime? startTime;
  DateTime? endTime;

  late ActivityRegisterBloc _bloc;

  @override
  Widget build(BuildContext context) => BaseScreen<ActivityRegisterBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(const GetActivityRegisterTypesFromDB());
      },
      builder: (context, bloc, child) =>
          BlocListener<ActivityRegisterBloc, BaseState>(
              listener: (context, state) {
                if (state is GetActivityTypesSuccessState) {
                  activityTypeList = state.data;
                } else if (state is GetActivityTypesFailedState) {
                  print('GetActivityTypesFailedState');
                } else if (state is InsertActivitySuccessState) {
                  ApiService().checkInternet().then((internet) {
                    if (internet) {
                      _bloc.add(const GetUnSyncActivityRegister());
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                } else if (state is InsertActivityFailedState) {
                  print('GetActivityTypesFailedState');
                } else if (state is GetUnSyncActivityFailedState) {
                  print('GetUnSyncActivityFailedState');
                } else if (state is GetActivityRegisteredAPISuccessState) {
                  Navigator.of(context).pop();
                } else if (state is GetActivityRegisteredAPIFailedState) {
                  print('DeleteUnSyncActivityFailedState');
                }
              },
              child: GestureDetector(
                onTap: () => hideKeyboard(context),
                child: Scaffold(
                    appBar: CustomAppBar(
                      hasBack: true,
                      title: AppStrings.lblActivity.toUpperCase(),
                    ),
                    body: SafeArea(
                      child: CommonContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                child: ListView(
                              children: [
                                const SizedBox(
                                  height: 15,
                                ),
                                _enterActivityDetails(),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            )),
                            _bottomButtonView(),
                          ],
                        ),
                      ),
                    )),
              )));

  Widget _enterActivityDetails() => Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 20, horizontal: AppStyles.pageSideMargin),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),

              /*const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    "5 Activities",
                    style: TextStyle(color: AppColors.primary, fontSize: 12),
                  ),
                ),
              ),*/

              ///form fields
              CustomTextInputField(
                controller: _activtyDetailController,
                labelText: AppStrings.lblEnterActivityDetails,
                validator: (value) => requiredFieldValidation(value!) != ""
                    ? requiredFieldValidation(value)
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          DatePicker.showTime12hPicker(context,
                              onConfirm: (time) {
                            _startTimeController.text = get12HTime(time);
                            startTime = time;
                          }, currentTime: DateTime.now());
                        },
                        child: CustomTextInputField(
                          enabled: false,
                          controller: _startTimeController,
                          labelText: AppStrings.lblStartTime,
                          validator: (value) =>
                              requiredFieldValidation(value!) != ""
                                  ? requiredFieldValidation(value)
                                  : null,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (startTime != null) {
                            DatePicker.showTime12hPicker(context,
                                onConfirm: (time) {
                              if (checkDifference(startTime!, time)) {
                                _endTimeController.text = get12HTime(time);
                                endTime = time;
                              } else {
                                showCustomFlushBar(context,
                                    'end Time should be higher then start Time');
                              }
                            }, currentTime: startTime);
                          } else {
                            showCustomFlushBar(
                                context, 'Select start Time first.');
                          }
                        },
                        child: CustomTextInputField(
                          enabled: false,
                          controller: _endTimeController,
                          labelText: AppStrings.lblEndTime,
                          validator: (value) =>
                              requiredFieldValidation(value!) != ""
                                  ? requiredFieldValidation(value)
                                  : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              CustomDropDownActivityRegisterType(
                items: activityTypeList,
                validator: (value) {
                  if (value != null) {
                    activityType = value;
                  } else {
                    return AppStrings.emptyValidation;
                  }
                },
                activityType: (value) {
                  activityType = value;
                  print('selected leave = ${activityType.name}');
                },
              ),

              ///status
              if (widget.isFromAttendance)
                const SizedBox(
                  height: 10,
                )
              else
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: RequestStatusBadge(status: RequestStatus.pending),
                  ),
                )
            ],
          ),
        ),
      );

  Widget _btnViewActivityHistory() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppStyles.pageSideMargin),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            InkWell(
              onTap: _viewActivityHistory,
              child: Row(
                children: const [
                  Icon(
                    Icons.visibility_outlined,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  Text(
                    AppStrings.lblActivityHistory,
                    style: TextStyle(
                      color: AppColors.primary,
                      decoration: TextDecoration.underline,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget _bottomButtonView() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: appCommonFlatButton(
              btnTxt: AppStrings.lblActivityHistory,
              isTopRightRounded: false,
              onPressed: _viewActivityHistory,
            ),
          ),
          const SizedBox(
            width: 1,
          ),
          Expanded(
              child: appCommonFlatButton(
            btnTxt: AppStrings.lblSave,
            isTopLeftRounded: false,
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _onSave();
              }
            },
          )),
        ],
      );

  void _viewActivityHistory() {
    navigationPush(
        context, const ActivityRegisterHistoryScreen());
  }

  void _onDelete() {
    Navigator.of(context).pop();
  }

  void _onSave() async {
    final userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    final date = getCurrentDateAndTime();
    _bloc.add(InsertActivityRegisterIntoDB(
        activityData: ActivityRegisteredItem(
            id: generateRandomNumber(),
            status: BaseStatus.active,
            startTime: getDateAndTImeWithTimeZone(startTime!),
            endTime: getDateAndTImeWithTimeZone(endTime!),
            date: date,
            details: _activtyDetailController.text,
            created_on: date,
            created_by: userId,
            isSync: SyncStatus.unSync,
            activityRegisterStatus: ActivityRegisterStatus.Pending,
            activityTypeId: activityType.id)));
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
