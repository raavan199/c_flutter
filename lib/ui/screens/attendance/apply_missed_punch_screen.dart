import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../blocs/apply_miss_punch/apply_miss_punch_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../constants/app_enums.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../base/base_screen.dart';

/// Created by Dev 2301 on 12/2/2021
/// Modified by Dev 2301 on 12/2/2021
/// Purpose : apply missed punch  screen open from Attendance screen
/// on tapping apply button in missed punch tab
class ApplyMissedPunchScreen extends StatefulWidget {
  ApplyMissedPunchScreen({required this.item, Key? key}) : super(key: key);

  MissPunchItem item;

  @override
  _ApplyMissedPunchScreenState createState() => _ApplyMissedPunchScreenState();
}

class _ApplyMissedPunchScreenState extends State<ApplyMissedPunchScreen>
    with UtilityMixin, ValidationMixin {
  late ApplyMissPunchBloc _bloc;
  final TextEditingController _punchOutTimeController = TextEditingController();
  final TextEditingController _applyReasonController = TextEditingController();
  final TextEditingController _reApplyReasonController =
      TextEditingController();
  final TextEditingController _workingHoursController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void initState() {
    _punchOutTimeController.text = '0:0';
    _workingHoursController.text = '0.0';

    super.initState();
  }

  @override
  Widget build(BuildContext context) => BaseScreen<ApplyMissPunchBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
      },
      builder: (context, bloc, child) =>
          BlocListener<ApplyMissPunchBloc, BaseState>(
              listener: (context, state) {
                if(state is ApplyMissPunchCallSuccessState){
                  Navigator.of(context).pop(true);
                }else if(state is ApplyMissPunchCallFailState){
                  showCustomFlushBar(context, 'Something went wrong, Please try again');
                  Navigator.of(context).pop();
                }
              },
              child: GestureDetector(
                onTap: () => hideKeyboard(context),
                child: Scaffold(
                  appBar: CustomAppBar(
                    hasBack: true,
                    title: AppStrings.lblMissedPunch,
                  ),
                  body: SafeArea(
                    child: CommonContainer(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                child: ListView(
                              children: [
                                _appliedDateField(),
                                _enterDetailsView(_punchOutTimeController),
                                if (widget.item.approverRemark != null)
                                  _multilineField(
                                      AppStrings.lblRejectedReason, false, null),
                                _multilineField(
                                    widget.item.missedPunchStatus ==
                                            RequestStatus.rejected.index
                                        ? AppStrings.lblReApplyReason
                                        : AppStrings.lblApplyReason,
                                    true,
                                  widget.item.missedPunchStatus ==
                                      RequestStatus.rejected.index
                                      ? _reApplyReasonController
                                      : _applyReasonController,),
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
                ),
              )));

  ///common card background container
  Widget _cardContainer({required Widget child}) => Container(
        width: Get.width,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [Shadows.greyShadow],
          borderRadius: BorderRadius.circular(AppStyles.commonCardCornerRadius),
        ),
        margin: const EdgeInsets.symmetric(
            vertical: 20, horizontal: AppStyles.pageSideMargin),
        padding: const EdgeInsets.symmetric(
            vertical: 20, horizontal: AppStyles.pageSideMargin),
        child: child,
      );

  ///applied date & time field
  Widget _appliedDateField() => _cardContainer(
        child: CustomTextInputField(
          labelText: AppStrings.lblAppliedDateTime,
          initialValue: getDateFromDateTime(
              widget.item.missedPunchDetails![0].createdOn!),
          enabled: false,
        ),
      );

  ///missed punch details button
  Widget _btnMissedPunchDetails() => Padding(
        padding:
            const EdgeInsets.symmetric(horizontal: AppStyles.pageSideMargin),
        child: Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  primary: AppColors.primary, elevation: 0),
              child: const Text(AppStrings.lblMissPunchDetails),
            ),
          ],
        ),
      );

  ///enter details view
  Widget _enterDetailsView(TextEditingController _punchOutTimeController) =>
      Stack(
        clipBehavior: Clip.none,
        children: [
          _cardContainer(
            child: Column(
              children: [
                ListView.builder(
                  itemCount: widget.item.missedPunchDetails!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => _fieldContainer(
                    child1: CustomTextInputField(
                      labelText: AppStrings.lblPunchIn,
                      enabled: false,
                      initialValue: get12HTime(DateTime.parse(widget
                              .item.missedPunchDetails![index].punchInTime!)
                          .toLocal()),
                    ),
                    child2:
                        widget.item.missedPunchDetails![index].punchOutTime ==
                                null
                            ? InkWell(
                                onTap: () {
                                  if (widget.item.missedPunchDetails![index]
                                          .punchOutTime ==
                                      null) {
                                    DatePicker.showTime12hPicker(context,
                                        onConfirm: (time) {
                                      if (checkDifference(
                                          DateTime.parse(widget
                                                  .item
                                                  .missedPunchDetails![index]
                                                  .punchInTime!)
                                              .toLocal(),
                                          time)) {
                                        _punchOutTimeController.text =
                                            get12HTime(time);
                                        widget.item.missedPunchDetails![index].punchOutTime = getDateAndTImeWithTimeZone(time);
                                        print('confirm $time');
                                        setState(() {
                                          _workingHoursController.text =
                                              calculateHours(
                                                  time,
                                                  DateTime.parse(widget
                                                          .item
                                                          .missedPunchDetails![
                                                              index]
                                                          .punchInTime!)
                                                      .toLocal());
                                        });
                                      } else {
                                        showCustomFlushBar(context,
                                            'end Time should be higher then start Time');
                                      }
                                    },
                                        currentTime: DateTime.parse(widget
                                                .item
                                                .missedPunchDetails![index]
                                                .punchInTime!)
                                            .toLocal());
                                  }
                                },
                                child: CustomTextInputField(
                                  enabled: false,
                                  validator: (value) =>
                                      requiredFieldValidation(value!) != ""
                                          ? requiredFieldValidation(value)
                                          : null,
                                  labelText: AppStrings.lblPunchOut,
                                  controller: _punchOutTimeController,
                                ),
                              )
                            : CustomTextInputField(
                                labelText: AppStrings.lblPunchOut,
                                enabled: false,
                                initialValue: get12HTime(DateTime.parse(widget
                                        .item
                                        .missedPunchDetails![index]
                                        .punchOutTime!)
                                    .toLocal()),
                              ),
                  ),
                ),
                _fieldContainer(child1: Container(), child2: _hoursField()),
              ],
            ),
          ),
          Positioned(top: -7, child: _btnMissedPunchDetails()),
        ],
      );

  Widget _fieldContainer({required Widget child1, required Widget child2}) =>
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: child1,
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: child2,
            )
          ],
        ),
      );

  Widget _hoursField() => Row(
        children: [
          Expanded(
            child: _workingHoursController.text.isEmpty ? CustomTextInputField(
              // controller: _workingHoursController,
              initialValue: widget.item.hours,
              enabled: false,
            ) : CustomTextInputField(
              controller: _workingHoursController,
              // initialValue: widget.item.hours,
              enabled: false,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          const Text(
            "HRS.",
            style: TextStyle(color: AppColors.black, fontWeight: AppFonts.bold),
          )
        ],
      );

  Widget _multilineField(
          String lbl, bool enable, TextEditingController? controller) =>
      Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 10, horizontal: AppStyles.pageSideMargin),
        child: Row(
          children: [
            Expanded(
              child: CustomTextInputField(
                labelText: lbl,
                maxLines: 5,
                controller: controller,
                initialValue: _multilineFieldValue(lbl),
                enabled: enable,
                validator: (value) => requiredFieldValidation(value!) != ""
                    ? requiredFieldValidation(value)
                    : null,
              ),
            ),
          ],
        ),
      );

  Widget _bottomButtonView() => appCommonFlatButton(
        btnTxt: widget.item.missedPunchStatus == RequestStatus.rejected.index
            ? AppStrings.lblReApply
            : AppStrings.lblApply,
        onPressed: () {
          if (_formKey.currentState?.validate() ?? false) {
            _onApply();
          }
        },
      );

  _onApply() async {
    if(_applyReasonController.text.isNotEmpty) {
      widget.item.applyReason = _applyReasonController.text;
    }if(_reApplyReasonController.text.isNotEmpty) {
      widget.item.reApplyReason = _reApplyReasonController.text;
    }

    await ApiService().checkInternet().then((internet) {
      if (internet) {
        _bloc.add(CallMissPunchApplyApi(missPunchData: widget.item));
      } else {
        showNoInternetDialog(context, content: AppStrings.msgInternetShouldOn);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _reApplyReasonController.dispose();
    _applyReasonController.dispose();
    _punchOutTimeController.dispose();
  }

  Duration durationParse() {
    final ts = DateFormat('y-MM-dd').format(DateTime.now());
    final dt = DateTime.parse('$ts ${widget.item.hours}');
    return Duration(hours: dt.hour, minutes: dt.minute, seconds: dt.second);
  }

  String calculateHours(DateTime punchOutTime, DateTime punchInTime) {
    var diff = punchOutTime.difference(punchInTime);
    var hours;
    if(widget.item.hours == null){
     hours = diff;
    }
    else {
      hours = durationParse() + diff;
    }
    return "${hours.inHours.toString().padLeft(2, '0')}: ${hours.inMinutes.remainder(60)}";
  }

  String? _multilineFieldValue(String lbl) {
    if(lbl == AppStrings.lblRejectedReason){
      return widget.item.approverRemark;
    } else if (lbl == AppStrings.lblApplyReason || lbl == AppStrings.lblReApplyReason){
       return null;
    } else {
      return null;
    }

  }
}
