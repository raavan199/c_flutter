import 'package:floor/floor.dart';

import '../exports/models.dart';

@dao
abstract class ActivityRegisteredDao{
  @Query('Select * From ActivityRegistered where DATE(created_on) between DATE(":startDate") and DATE(":endDate")')
  Future<List<ActivityRegisteredItem>> getActivity(String startDate, String endDate);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ActivityRegisteredItem> activityList);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertActivityRegisterData(ActivityRegisteredItem activityRegisteredData);


  @Query('select* from ActivityRegistered where isSync = 0 ')
  Future<List<ActivityRegisteredItem>> getUnSyncActivity();

  @Query("delete from ActivityRegistered where isSync = 0")
  Future<bool?> deleteUnSyncData();

  @Query("delete from ActivityRegistered where id = :id")
  Future<bool?> deleteActivityById(int id);


}