part of 'attendance_bloc.dart';

abstract class AttendanceEvent extends Equatable {
  const AttendanceEvent();

  @override
  List<Object?> get props => [];
}

class GetLastAttendanceDetail extends AttendanceEvent {
  const GetLastAttendanceDetail({required this.todayDate});

  final String todayDate;

  @override
  List<Object> get props => [todayDate];
}

class GetAttendanceItem extends AttendanceEvent {
  const GetAttendanceItem();

  @override
  List<Object> get props => [];
}

class CalculatePresentAbsentAndLeave extends AttendanceEvent {
  const CalculatePresentAbsentAndLeave(
      {required this.startDateOfMonth,
      required this.endDateOfMonth,
      required this.lastDateOfMonth});

  final String startDateOfMonth;
  final String endDateOfMonth;
  final String lastDateOfMonth;

  @override
  List<Object> get props => [startDateOfMonth, endDateOfMonth,lastDateOfMonth];
}

class InsertAttendanceIntoDB extends AttendanceEvent {
  const InsertAttendanceIntoDB(
      {required this.attendanceItem, required this.attendanceDetails});

  final AttendanceItem attendanceItem;
  final AttendanceDetails attendanceDetails;

  @override
  List<Object> get props => [attendanceItem, attendanceDetails];
}

class UpdatePunchOutIntoDB extends AttendanceEvent {
  const UpdatePunchOutIntoDB(
      {required this.attendanceItem, required this.attendanceDetails});

  final AttendanceItem attendanceItem;
  final AttendanceDetails attendanceDetails;

  @override
  List<Object> get props => [attendanceItem, attendanceDetails];
}

class UploadUnSyncRecords extends AttendanceEvent {
  const UploadUnSyncRecords();

  @override
  List<Object> get props => [];
}
