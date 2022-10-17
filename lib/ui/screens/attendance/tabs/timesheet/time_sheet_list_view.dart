import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../../constants/app_constants.dart';
import '../../../../../exports/mixins.dart';
import '../../../../../exports/models.dart';
import '../../../../../exports/resources.dart';
import '../../../../../exports/themes.dart';
import '../../../../../exports/utilities.dart';
import '../../../../../exports/widgets.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : list view in missed punch page
class TimeSheetListView extends StatefulWidget {
  const TimeSheetListView({
    required this.onItemTap,
    required this.lastattendanceDetail,
    required this.attendanceCaptureDetail,
    required this.selectedDate,
    Key? key,
  }) : super(key: key);

  final Function(TimeSheetItemModel) onItemTap;
  final AttendanceDetails lastattendanceDetail;
  final Function(AttendanceDetails) attendanceCaptureDetail;
  final DateTime selectedDate;

  @override
  State<TimeSheetListView> createState() => _TimeSheetListViewState();
}

class _TimeSheetListViewState extends State<TimeSheetListView>
    with UtilityMixin {
  String cameraFile = '';
  String punchTime = '';

  // int punchType = 1;
  ImagePicker picker = ImagePicker();
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");

  @override
  void initState() {
    checkPunchType();

    super.initState();
  }

  @override
  Widget build(BuildContext context) => _listView(context);

  Widget _listView(BuildContext context) =>
      Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Padding(
          padding: const EdgeInsets.only(right: 15, left: 15, bottom: 15),
          child: InkWell(
            onTap: () {},
            child: Stack(
              children: [
                Container(
                  height: Get.width * .2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [Shadows.greyShadow],
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        getDateFromDate(widget.selectedDate),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CustomTextStyle.retailerNameTextStyle,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            puchinOutTime(AppStrings.lblPunchIn,
                                widget.lastattendanceDetail.punchInTime),
                            puchinOutTime(AppStrings.lblPunchOut,
                                widget.lastattendanceDetail.punchOutTime)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                if(getDateFromDate(widget.selectedDate) == getDateFromDate(DateTime.now()))
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      height: Get.height * .05,
                      width: Get.width * .30,
                      margin: EdgeInsets.only(
                          right: Get.width * .02, top: Get.width * .16),
                      child: SizedBox(
                        width: Get.width * .25,
                        child: appCommonRoundedButton(
                            btnTxt: checkPunchType() == PunchType.punchIn
                                ? AppStrings.lblPunchIn
                                : AppStrings.lblPunchOut,
                            onPressed: openCamera),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  Widget puchinOutTime(String label, String? value) =>
      Column(
        children: [
          Text(
            label,
            style: CustomTextStyle.smallGreyTextStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            value.isNullOrBlank == true
                ? '-'
                : get12HTime(DateTime.parse(value!).toLocal()),
            style: CustomTextStyle.retailerNameTextStyle,
          )
        ],
      );

  openCamera() async {
    var pickFile =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    cameraFile = pickFile!.path;
    print('File : $cameraFile');
    setState(() {
      punchTime = getCurrentDateAndTime();
      if (checkPunchType() == PunchType.punchIn) {
        if (widget.lastattendanceDetail.punchInTime.isNullOrBlank == false &&
            widget.lastattendanceDetail.punchOutTime.isNullOrBlank == false) {
          widget.lastattendanceDetail.id = null;
          widget.lastattendanceDetail.modified_by = null;
          widget.lastattendanceDetail.modified_on = null;
          widget.lastattendanceDetail.created_on = null;
          widget.lastattendanceDetail.created_by = null;
          widget.lastattendanceDetail.punchOutTime = null;
          widget.lastattendanceDetail.punchOutImagePath = null;
          widget.lastattendanceDetail.punchOutMediaFileId = null;
        }
        widget.lastattendanceDetail.punchInTime = punchTime;
        widget.lastattendanceDetail.punchInImagePath = cameraFile;
        widget.lastattendanceDetail.punchInMediaFileId = null;
      } else if (checkPunchType() == PunchType.punchOut) {
        widget.lastattendanceDetail.punchOutTime = punchTime;
        widget.lastattendanceDetail.punchOutImagePath = cameraFile;
        widget.lastattendanceDetail.punchOutMediaFileId = null;
      }
      widget.attendanceCaptureDetail(widget.lastattendanceDetail);
    });
  }

  int checkPunchType() {
    int punchType;
    if (widget.lastattendanceDetail.id != null) {
      if (widget.lastattendanceDetail.punchInTime.isNullOrBlank == false &&
          widget.lastattendanceDetail.punchOutTime.isNullOrBlank == true) {
        punchType = PunchType.punchOut;
      } else if (widget.lastattendanceDetail.punchInTime.isNullOrBlank ==
          false &&
          widget.lastattendanceDetail.punchOutTime.isNullOrBlank == false) {
        punchType = PunchType.punchIn;
      } else {
        punchType = PunchType.punchIn;
      }
    } else {
      punchType = PunchType.punchIn;
    }
    return punchType;
  }
}
