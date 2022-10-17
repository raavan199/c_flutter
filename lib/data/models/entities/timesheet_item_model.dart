/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : time sheet entry list item model

class TimeSheetItemModel {
  TimeSheetItemModel({
    required this.entryDate,
    required this.punchInTime,
    required this.punchOutTime,
  });

  String entryDate;
  String punchInTime;
  String punchOutTime;
}
