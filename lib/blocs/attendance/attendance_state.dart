part of 'attendance_bloc.dart';

abstract class AttendanceState extends Equatable {
  const AttendanceState();

  @override
  List<Object?> get props => [];
}

class GetLastAttendanceSuccessState extends BaseState {
  const GetLastAttendanceSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetLastAttendanceFailState extends BaseState {
  const GetLastAttendanceFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class GetAttendanceItemSuccessState extends BaseState {
  const GetAttendanceItemSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class GetAttendanceItemFailState extends BaseState {
  const GetAttendanceItemFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class CalcPresentAbsentAndLeaveSuccessState extends BaseState {
  const CalcPresentAbsentAndLeaveSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class CalcPresentAbsentAndLeaveFailState extends BaseState {
  const CalcPresentAbsentAndLeaveFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class InsertAttendanceSuccessState extends BaseState {
  const InsertAttendanceSuccessState(
      {this.attendanceItem, this.attendanceDetail});

  final dynamic attendanceItem;
  final dynamic attendanceDetail;

  @override
  List<Object> get props => <Object>[attendanceItem, attendanceDetail];
}

class InsertAttendanceFailState extends BaseState {
  const InsertAttendanceFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
class UpdateAttendanceSuccessState extends BaseState {
  const UpdateAttendanceSuccessState(
      {this.attendanceItem, this.attendanceDetail});

  final dynamic attendanceItem;
  final dynamic attendanceDetail;

  @override
  List<Object> get props => <Object>[attendanceItem, attendanceDetail];
}

class UpdateAttendanceFailState extends BaseState {
  const UpdateAttendanceFailState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class ImageUploadSuccessState extends BaseState {
  const ImageUploadSuccessState();

  @override
  List<Object> get props => <Object>[];
}

class ImageUploadFailedState extends BaseState {
  const ImageUploadFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}

class AttendanceUploadSuccessState extends BaseState {
  const AttendanceUploadSuccessState({this.data});

  final dynamic data;

  @override
  List<Object> get props => <Object>[data];
}

class AttendanceUploadFailedState extends BaseState {
  const AttendanceUploadFailedState({this.msg});

  final String? msg;

  @override
  List<Object> get props => <Object>[msg!];
}
