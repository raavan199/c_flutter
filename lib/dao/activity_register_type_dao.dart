import 'package:floor/floor.dart';

import '../exports/models.dart';

@dao
abstract class ActivityRegisterTypeDao{
  @Query('Select * From ActivityRegisterType')
  Future<List<ActivityRegisterTypeData>> getAllData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ActivityRegisterTypeData> activityTypeList);

}