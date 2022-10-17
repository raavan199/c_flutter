import 'package:floor/floor.dart';

import '../data/models/journey_cycle/journey_cycle_data.dart';

@dao
abstract class JourneyCycleDao {
  @Query('Select * From JourneyCycle')
  Future<List<JourneyCycleData>?> getAllData();

  @Query(
      'select * from JourneyCycle where financialYearId = :financialYearId and DATE(\'now\') between DATE(startDate) and DATE(endDate)')
  Future<List<JourneyCycleData>?> getCurrentJourneyCycle(int financialYearId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertJourneyCycleData(JourneyCycleData data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<JourneyCycleData> journeyCycleList);

  @Query("delete from JourneyCycle where id = :id")
  Future<void> deleteData(int id);
}
