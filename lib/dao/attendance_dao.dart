import 'package:cygneto/data/models/no_order/no_order_type_data.dart';
import 'package:floor/floor.dart';

import '../exports/models.dart';

@dao
abstract class AttendanceDao{
  @Query('select * from Attendance')
  Future<List<AttendanceItem>> getAttendance();

  @Query('select * from Attendance where isSync = 0')
  Future<List<AttendanceItem>> getUnSyncAttendance();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int?> insertAttendance(AttendanceItem attendanceData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<AttendanceItem> attendanceList);

  @Query('Update Attendance set modified_by= :modifiedBy, modified_on = :endTime, isSync = :isSync where id = :id')
  Future<AttendanceItem?> updatePunchOut(int id, String endTime, int isSync, int modifiedBy);

  @Query("delete from Attendance where isSync = 0")
  Future<bool?> deleteUnSyncData();

}