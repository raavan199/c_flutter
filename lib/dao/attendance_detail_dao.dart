import 'package:floor/floor.dart';

import '../data/models/attendance/attendance_detail.dart';
import '../data/models/user_role_rights/user_role_rights_response.dart';

@dao
abstract class AttendanceDetailDao {

  @Query('Select * From AttendanceDetail')
  Future<AttendanceDetails?> getAttendanceDetailData();

  @Query('Select * From AttendanceDetail where isSync = 0')
  Future<List<AttendanceDetails>> getUnSyncAttendanceDetailData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int> insertAttendanceDetailData(AttendanceDetails attendanceDetailData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<AttendanceDetails> attendanceDetailList);

  @Query("delete from AttendanceDetail where id = :id")
  Future<void> deleteData(int id);

  @Query('Update AttendanceDetail set punchOutTime = :endTime, modified_by= :modifiedBy, modified_on = :endTime, punchOutImagePath = :punchOutImagePath, isSync = :isSync where attendanceId = :id')
  Future<AttendanceDetails?> updatePunchOutDetail(int id, String endTime, int isSync, int modifiedBy, String punchOutImagePath);


  @Query("delete from AttendanceDetail where isSync = 0")
  Future<bool?> deleteUnSyncData();

}