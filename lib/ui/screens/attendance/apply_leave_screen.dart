import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import '../../../blocs/apply_leave/apply_leave_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../../../services/shared_preference_service.dart';
import '../../widgets/custom_dropdown_leave_type.dart';
import '../base/base_screen.dart';

/// Created by Dev 2301 on 12/2/2021
/// Modified by Dev 2183 on 02/08/2022
/// Purpose : apply leave  screen open from Attendance screen
/// on tapping apply button in Leaves tab
class ApplyLeaveScreen extends StatefulWidget {
  const ApplyLeaveScreen({Key? key}) : super(key: key);

  @override
  _ApplyLeaveScreenState createState() => _ApplyLeaveScreenState();
}

class _ApplyLeaveScreenState extends State<ApplyLeaveScreen>
    with UtilityMixin, ValidationMixin {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  List<LeaveTypeData> leaveTypeList = [];

  final List<RadioSelectionItemModel> _radioSelectionList = [
    RadioSelectionItemModel(
      AppStrings.lblFirstHalf,
      isSelected: true,
    ),
    RadioSelectionItemModel(
      AppStrings.lblSecondHalf,
    ),
  ];
  RadioSelectionItemModel? selectedItem;

  bool isFullDay = true;
  bool isFirstHalf = true;

  LeaveTypeData leaveType = LeaveTypeData();
  String? remarks;
  String? fromDate;
  String? toDate;
  late ApplyLeaveBloc _bloc;
  DateTime currentDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  int? difference;

  @override
  Widget build(BuildContext context) => BaseScreen<ApplyLeaveBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(CallLeaveTypeAPI(fromTimeStamp: null));
      },
      builder: (context, bloc, child) =>
          BlocListener<ApplyLeaveBloc, BaseState>(
              listener: (context, state) {
                if (state is ApplyLeaveCallSuccessState) {
                  Navigator.of(context).pop(true);
                } else if (state is ApplyLeaveCallFailState) {
                  showCustomDialog(context, state.msg ?? "Error", "Alert", AppStrings.ok);
                } else if (state is LeaveTypeSuccessState) {
                  leaveTypeList = state.data;
                } else if (state is LeaveTypeFailState) {}
              },
              child: GestureDetector(
                onTap: () => hideKeyboard(context),
                child: Scaffold(
                  appBar: CustomAppBar(
                    hasBack: true,
                    title: AppStrings.lblApplyLeave,
                  ),
                  body: SafeArea(
                    child: CommonContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              child: ListView(
                            children: [
                              _enterDetailsView(
                                  _fromDateController, _toDateController),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          )),
                          _bottomButtonView(),
                        ],
                      ),
                    ),
                  ),
                ),
              )));

  ///common card background container
  Widget _cardContainer({required Widget child}) => Container(
        margin: const EdgeInsets.symmetric(vertical: AppStyles.pageSideMargin),
        padding: const EdgeInsets.symmetric(
            vertical: AppStyles.pageSideMargin,
            horizontal: AppStyles.pageSideMargin),
        child: child,
      );

  ///enter details view
  Widget _enterDetailsView(TextEditingController _fromDateController,
          TextEditingController _toDateController) =>
      _cardContainer(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ///form fields
              InkWell(
                onTap: () {
                  DatePicker.showDatePicker(context,
                      minTime:
                          DateTime(currentDate.year, currentDate.month - 1),
                      maxTime:
                          DateTime(currentDate.year, currentDate.month + 3, 0),
                      onChanged: (date) {}, onConfirm: (date) {
                    if (toDate != null) {
                      difference =
                          daysBetween(date, DateTime.parse(toDate ?? '').toLocal());
                      print(difference);
                      if (difference!.isNegative) {
                        showCustomFlushBar(context,
                            'From date should be smaller then To date');
                      } else {
                        if (difference! >= 1) {
                          setState(() {
                            isFullDay = true;
                          });
                        }
                        fromDate = getDateAndTImeWithTimeZone(date);
                        _fromDateController.text =
                            '${date.day}-${date.month}-${date.year}';
                      }
                    } else {
                      fromDate = getDateAndTImeWithTimeZone(date);
                      _fromDateController.text =
                          '${date.day}-${date.month}-${date.year}';
                    }
                  },
                      currentTime: fromDate != null
                          ? DateTime.parse(fromDate!).toLocal()
                          : currentDate);
                },
                child: CustomTextInputField(
                  enabled: false,
                  controller: _fromDateController,
                  labelText: AppStrings.lblFromDate,
                  validator: (value) => requiredFieldValidation(value!) != ""
                      ? requiredFieldValidation(value)
                      : null,
                ),
              ),
              _spacerVertical(),
              InkWell(
                onTap: () {
                  if (fromDate == null) {
                    showCustomFlushBar(context, 'Select from date first. ');
                  } else {
                    DatePicker.showDatePicker(context,
                        minTime: DateTime(
                          currentDate.year,
                          currentDate.month - 1,
                        ),
                        maxTime: DateTime(
                            currentDate.year, currentDate.month + 3, 0),
                        onChanged: (date) {}, onConfirm: (date) {
                      difference = daysBetween(
                          DateTime.parse(fromDate!).toLocal(), date);
                      print(difference);
                      if (difference!.isNegative) {
                        showCustomFlushBar(
                            context, 'To date should be bigger then From date');
                      } else {
                        if (difference! >= 1) {
                          setState(() {
                            isFullDay = true;
                          });
                        }
                        toDate = getDateAndTImeWithTimeZone(date);
                        _toDateController.text =
                            '${date.day}-${date.month}-${date.year}';
                      }
                    },
                        currentTime: toDate != null
                            ? DateTime.parse(toDate!).toLocal()
                            : DateTime.parse(fromDate!).toLocal());
                  }
                },
                child: CustomTextInputField(
                  enabled: false,
                  controller: _toDateController,
                  labelText: AppStrings.lblToDate,
                  validator: (value) => requiredFieldValidation(value!) != ""
                      ? requiredFieldValidation(value)
                      : null,
                ),
              ),
              _spacerVertical(), _switchView(),
              if (!isFullDay) _radioSelectionView(),
              _spacerVertical(),
              CustomDropDownLeaveType(
                items: leaveTypeList,
                validator: (value) {
                  if (value != null) {
                    leaveType = value;
                  } else {
                    return AppStrings.emptyValidation;
                  }
                },
                leaveType: (value) {
                  leaveType = value;
                  print('selected leave = ${leaveType.name}');
                },
              ),

              _spacerVertical(),
              CustomTextInputField(
                labelText: AppStrings.lblRemarks,
                maxLines: 5,
                onChanged: (value) {
                  remarks = value;
                },
                validator: (value) => requiredFieldValidation(value!) != ""
                    ? requiredFieldValidation(value)
                    : null,
              ),
            ],
          ),
        ),
      );

  Widget _radioSelectionView() => RadioSelectionView(
        list: _radioSelectionList,
        hasDecoration: false,
        hasSpaceBetween: false,
        fontSize: 12,
        fontWeight: AppFonts.medium,
        onItemChanged: (data) {
          selectedItem = data;
          if (selectedItem!.title == AppStrings.lblFirstHalf) {
            isFirstHalf = true;
          } else {
            isFirstHalf = false;
          }
        },
      );

  Widget _switchView() => Row(
        children: [
          const Text(
            AppStrings.lblHalfDay,
            style: TextStyle(
                color: AppColors.black,
                fontWeight: AppFonts.medium,
                fontSize: 13),
          ),
          Switch(
            value: isFullDay,
            activeColor: AppColors.primary,
            inactiveThumbColor: AppColors.primary,
            inactiveTrackColor: AppColors.tabBackground.withAlpha(150),
            onChanged: (isReceived) {
              if (fromDate != null && toDate != null) {
                if (daysBetween(DateTime.parse(fromDate ?? ''),
                        DateTime.parse(toDate ?? '')) ==
                    0) {
                  setState(() {
                    isFullDay = !isFullDay;
                  });
                } else {
                  showCustomFlushBar(
                      context, 'Selected Date differance is more than a day');
                }
              } else {
                showCustomFlushBar(context, 'Select Date First');
              }
            },
          ),
          const Text(
            AppStrings.lblFullDay,
            style: TextStyle(
                color: AppColors.black,
                fontWeight: AppFonts.medium,
                fontSize: 13),
          ),
        ],
      );

  Widget _spacerVertical() => const SizedBox(
        height: 15,
      );

  Widget _bottomButtonView() => appCommonFlatButton(
        btnTxt: AppStrings.lblApplyLeave,
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            showCustomDialog(context, 'Are you sure you want to apply leave?',
                AppStrings.lblApplyLeave, AppStrings.lblYes, yesOnPressed: () {
              _onApply();
            }, no: AppStrings.lblNo, noOnPressed: () {});
          }
        },
      );

  _onApply() async {
    final userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    print('on yes clicked');
    await ApiService().checkInternet().then((internet) {
      if (internet) {
        _bloc.add(
          CallApplyLeaveAPI(
              leaveData: LeaveItem(
            id: 0,
            fromDate: fromDate,
            toDate: toDate,
            isHalfDay: !isFullDay,
            isFirstHalf: !isFullDay ? isFirstHalf : null,
            leaveTypeId: leaveType.id ?? 0,
            remarks: remarks,
            leaveStatus: LeaveStatusId.pending,
            created_by: userId,
            created_on: getCurrentDateAndTime(),
          )),
        );
      } else {
        showNoInternetDialog(context,
            content: AppStrings.msgCheckInternetForAddLeave);
      }
    });

    // Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _toDateController.dispose();
    _fromDateController.dispose();
  }

  int daysBetween(DateTime from, DateTime to) =>
      getYearMonthDate(to).difference(getYearMonthDate(from)).inDays;

  DateTime getYearMonthDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}
