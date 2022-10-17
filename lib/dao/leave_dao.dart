import 'package:cygneto/exports/models.dart';
import 'package:floor/floor.dart';

@dao
abstract class LeaveDao {
  @Query('Select * From Leave')
  Future<List<LeaveItem>> getLeaveData();

  @Query('select* from Leave where isSync = 0 ')
  Future<List<LeaveItem>> getUnSyncOrder();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int?> insertLeaveData(LeaveItem leaveData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<LeaveItem> leaveList);

  @Query("delete from Leave where id = :id")
  Future<void> deleteData(int id);

  @Query("delete from Leave where isSync = 0")
  Future<bool?> deleteUnSyncData();
}
