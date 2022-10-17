import 'package:floor/floor.dart';

import '../exports/models.dart';

@dao
abstract class DistributionDao {
  @Query('Select * From Distribution')
  Future<List<DistributionData>> getDistributionData();

  @Query('Select * From Distribution where id = :id')
  Future<DistributionData?> getDistributionObject(int id);

  @Query('Select * From Distribution where id in (:id1, :id2, :id3)')
  Future<DistributionData?> getMultipleDistributionObject(
      int id1, int id2, int id3);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStateData(DistributionData distributionData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<DistributionData> distributionList);

  @Query("delete from Distribution where id = :id")
  Future<void> deleteData(int id);
}
