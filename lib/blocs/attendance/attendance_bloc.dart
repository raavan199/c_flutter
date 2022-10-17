import 'dart:io';

import 'package:equatable/equatable.dart';

import '../../constants/app_constants.dart';
import '../../database/db_module.dart';
import '../../exports/models.dart';
import '../../services/shared_preference_service.dart';
import '../base/base_bloc.dart';

part 'attendance_event.dart';

part 'attendance_state.dart';

class AttendanceBloc extends BaseBloc<AttendanceEvent> {
  AttendanceBloc(this.dbModule) : super() {
    _onEvent();
  }

  late DBModule dbModule;

  void _onEvent() {
    on<GetLastAttendanceDetail>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.database
          .rawQuery(rawQueryForLastAttendanceDetail(event.todayDate))
          .then((value) {
        emit(GetLastAttendanceSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetLastAttendanceFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<GetAttendanceItem>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.attendanceDao.getAttendance()
          .then((value) {
        emit(GetAttendanceItemSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const GetAttendanceItemFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });



    on<CalculatePresentAbsentAndLeave>((event, emit) async {
      emit(const LoadingState());
      var userId = await SharedPreferenceService()
          .getIntValuesSF(SharedPrefsConstants.userId);
      await dbModule.dbInstance.database
          .rawQuery(rawQueryForCalPresentAbsentAndLeave(
              event.startDateOfMonth, event.endDateOfMonth, userId,event.lastDateOfMonth))
          .then((value) {
        emit(CalcPresentAbsentAndLeaveSuccessState(data: value));
        emit(const LoadingState(isLoading: false));
      }).catchError((e) {
        emit(const CalcPresentAbsentAndLeaveFailState(
            msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<InsertAttendanceIntoDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.attendanceDao
          .insertAttendance(event.attendanceItem)
          .then((attendanceItem) async {
        await dbModule.dbInstance.attendanceDetailDao
            .insertAttendanceDetailData(event.attendanceDetails)
            .then((attendanceDetail) async {
          emit(InsertAttendanceSuccessState(
              attendanceItem: attendanceItem,
              attendanceDetail: attendanceDetail));
          emit(const LoadingState(isLoading: false));
        }).catchError((e) {});
      }).catchError((e) {
        emit(const InsertAttendanceFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<UpdatePunchOutIntoDB>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.attendanceDao
          .updatePunchOut(
              event.attendanceItem.id!,
              event.attendanceItem.modified_on!,
              SyncStatus.unSync,
              event.attendanceItem.modified_by!)
          .then((attendanceItem) async {
        await dbModule.dbInstance.attendanceDetailDao
            .insertAttendanceDetailData(event.attendanceDetails)
            .then((attendanceDetail) async {
          emit(UpdateAttendanceSuccessState(
              attendanceItem: attendanceItem,
              attendanceDetail: attendanceDetail));
          emit(const LoadingState(isLoading: false));
        }).catchError((e) {
          print('error ${e.toString()}');
        });
      }).catchError((e) {
        emit(const UpdateAttendanceFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });

    on<UploadUnSyncRecords>((event, emit) async {
      emit(const LoadingState());
      await dbModule.dbInstance.attendanceDetailDao
          .getUnSyncAttendanceDetailData()
          .then((attendanceDetail) {
        if (attendanceDetail.isNotEmpty) {
          UploadImageLoopCall(0, attendanceDetail);
        } else {
          emit(const ImageUploadSuccessState());
          emit(const LoadingState(isLoading: false));
        }
      }).catchError((e) {
        emit(const InsertAttendanceFailState(msg: "Data Not available!"));
        emit(const LoadingState(isLoading: false));
      });
      return;
    });
  }

  String rawQueryForLastAttendanceDetail(String todayDate) =>
      "SELECT TT.* FROM ( "
  "SELECT Ad.*, "
  "row_number() OVER ( "
  "ORDER BY punchInTime  DESC ) Rono "
  "FROM Attendance AS A "
  "INNER JOIN AttendanceDetail AS AD on A.ID = AD.attendanceId "
          "WHere Date(AD.created_on) ='$todayDate') AS TT "
  "WHERE Rono = 1";

  String rawQueryForCalPresentAbsentAndLeave(
          String startDate, String endDate, int userId,String lastDateofMonth) =>
      "SELECT IFNULL(TMP.TotalAttendance,0) AS  TotalAttendance,"
      " IFNULL(TMP.TotalAbsent,0) AS TotalAbsent,"
      " IFNULL(TMP.TotalLeave,0) AS TotalLeave FROM ("
      "WITH Dates(date, created_by) AS ("
      "VALUES('$startDate', $userId ) "
      "UNION ALL "
      "SELECT date(date, '+1 day'), $userId "
      "FROM dates "
      "WHERE date < '$endDate') "
      "Select AC.TotalAttendance AS TotalAttendance,"
      "TA.TotalAbsent, TL.TotalLeave FROM ( "
      "Select Count(D.Date) AS TotalAbsent,"
      "  D.created_by "
      "From Dates AS D "
      "Left Join Attendance  AS A ON Date(A.created_on) =  D.date "
      "AND DATE(A.created_on) BETWEEN '$startDate'  AND '$endDate'"
      "Where strftime('%w', D.date) != '0' "
      "AND A.created_on  IS NULL "
      ") AS TA "
      "LEFT JOIN ( "
      "WITH Dates(LeaveStartDate, LeaveEndDate,isHalfDay,created_by) AS ( "
      "Select DATE(L.fromDate), DATE(L.ToDate) , L.isHalfDay ,L.created_by From Leave as L "
      "WHERE DATE(L.fromDate) BETWEEN '$startDate'  AND '$lastDateofMonth' "
      "AND L.created_by = $userId And leaveStatus in (1,2) "
      "UNION ALL "
      "SELECT date(LeaveStartDate, '+1 day'), D.LeaveEndDate, D.isHalfDay, D.created_by "
      "FROM dates AS D "
      "WHERE LeaveStartDate <D.LeaveEndDate ) "
      "SELECT SUM(CASE WHEN isHalfDay  = 1 Then 0.5 Else 1 End ) As TotalLeave, "
      "created_by FROM Dates  AS D "
      "WHERE D.LeaveStartDate BETWEEN  '$startDate' And '$lastDateofMonth' "
      ") AS TL on TL.created_by =TA.created_by "
      "LEFT JOIN ( "
      "Select Count(DISTINCT Date(A.created_on)) AS TotalAttendance, "
      "A.created_by "
      "From Attendance AS A "
      "Where created_by  =$userId "
      "AND DATE(A.created_on)  Between '$startDate' AND '$endDate'"
      "Group By created_by ) AS AC on AC.created_by = TA.created_by "
      ")AS TMP";

  void uploadImage(List<AttendanceDetails> attendanceDetail,
      int currentPosition, bool isPunchIn) async {
    var file;
    if (isPunchIn) {
      file = File(attendanceDetail[currentPosition].punchInImagePath!);
    } else {
      file = File(attendanceDetail[currentPosition].punchOutImagePath!);
    }
    await apiService.client!
        .uploadPunchImage(ImageModule.attendance, file)
        .then((value) async {
      if (isPunchIn) {
        attendanceDetail[currentPosition].punchInMediaFileId = value.data!.id;
      } else {
        attendanceDetail[currentPosition].punchOutMediaFileId = value.data!.id;
      }
      await dbModule.dbInstance.attendanceDetailDao
          .insertAttendanceDetailData(attendanceDetail[currentPosition])
          .then((value) {
        UploadImageLoopCall(currentPosition, attendanceDetail);
      });
    }).catchError((e) {
      emit(const ImageUploadFailedState(msg: 'Something went wrong'));
      emit(const LoadingState(isLoading: false));
    });
  }

  void UploadImageLoopCall(
      int currentPosition, List<AttendanceDetails> attendanceDetail) {
    if (attendanceDetail[currentPosition].punchInMediaFileId == null &&
        attendanceDetail[currentPosition].punchInImagePath != null) {
      uploadImage(attendanceDetail, currentPosition, true);
    } else if (attendanceDetail[currentPosition].punchOutMediaFileId == null &&
        attendanceDetail[currentPosition].punchOutImagePath != null) {
      uploadImage(attendanceDetail, currentPosition, false);
    } else {
      if (attendanceDetail.length > currentPosition + 1) {
        UploadImageLoopCall(currentPosition + 1, attendanceDetail);
      } else {
        GetAttendanceItemAndUpload(attendanceDetail);
        emit(const ImageUploadSuccessState());
        emit(const LoadingState(isLoading: false));
      }
    }
  }

  void GetAttendanceItemAndUpload(
      List<AttendanceDetails> attendanceDetail) async {
    await dbModule.dbInstance.attendanceDao
        .getUnSyncAttendance()
        .then((value) async {
      if (value.isNotEmpty && attendanceDetail.isNotEmpty) {
        for (int i = 0; i < value.length; i++) {
          List<AttendanceDetails> list = [];
          for (AttendanceDetails attendanceDetails in attendanceDetail) {
            if (value[i].id == attendanceDetails.attendanceId) {
              if (attendanceDetails.id! < 0 &&
                  attendanceDetails.attendanceId! < 0) {
                attendanceDetails.attendanceId = 0;
                attendanceDetails.id = 0;
              } else if (attendanceDetails.attendanceId! > 0 &&
                  attendanceDetails.id! < 0) {
                attendanceDetails.id = 0;
              }
              list.add(attendanceDetails);
            }
          }
          value[i].attendanceDetails = list;
          if (value[i].id! < 0) {
            value[i].id = 0;
          }
        }
        await apiService.client!
            .uploadAttendance(UploadAttendanceRequest(data: value))
            .then((value) async {
          await dbModule.dbInstance.attendanceDao
              .deleteUnSyncData()
              .then((value) async {
            await dbModule.dbInstance.attendanceDetailDao
                .deleteUnSyncData()
                .then((value) => GetLatestAttendance(1));
          });
        }).catchError((e) {
          emit(const AttendanceUploadFailedState(msg: 'Something went wrong'));
          emit(const LoadingState(isLoading: false));
        });
      }
    });
  }

  void GetLatestAttendance(int pageIndex) async {
    await dbModule.dbInstance.database
        .rawQuery(
            "select max(d) from (select created_on d from Attendance union select modified_on d from Attendance)")
        .then((value) async {
      String? syncDateTime;
      if (value[0]["max(d)"] != null) {
        syncDateTime = value[0]["max(d)"].toString();
      }
      await apiService.client!
          .getAttendance(SchemeListRequest(
              fromTimeStamp: syncDateTime, pageIndex: pageIndex))
          .then((value) {
        _saveAttendanceIntoDatabase(value.data!.items);
        if (value.data!.hasNextPage == true) {
          GetLatestAttendance(pageIndex + 1);
        } else {
          emit(AttendanceUploadSuccessState(data: value));
          emit(const LoadingState(isLoading: false));
        }
      });
    });
  }

  Future<void> _saveAttendanceIntoDatabase(
          List<AttendanceItem>? attendance) async =>
      await dbModule.dbInstance.attendanceDao
          .insertAllData(attendance ?? [])
          .then((value) {
        attendance?.forEach((element) async {
          await dbModule.dbInstance.attendanceDetailDao
              .insertAllData(element.attendanceDetails ?? [])
              .then((value) {});
        });
      });
}
