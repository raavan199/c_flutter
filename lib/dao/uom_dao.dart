import 'package:floor/floor.dart';

import '../data/models/unitofmeasurement/unit_of_measurement_data_response.dart';

@dao
abstract class UoMDao{
  @Query('Select * From UnitOfMeasure')
  Future <List<UOMDataResponse>> getUoMData();

  @Query('Select * From UnitOfMeasure where id = :id')
  Future <UOMDataResponse?> getUoMBasedOnId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertUoMData(UOMDataResponse uoMData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<UOMDataResponse> uoMList);

  @Query("delete from UnitOfMeasure where id = :id")
  Future<void> deleteData(int id);
}