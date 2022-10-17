import 'package:floor/floor.dart';

import '../data/models/location/location_data_items_response.dart';

@dao
abstract class LocationDao{
  @Query('Select * From Location')
  Future<List<LocationDataItems?>> getLocationData();

  @Query('Select * From Location where district_id = :id')
  Future<List<LocationDataItems>?> getLocationBasedOnDistrictId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLocationData(LocationDataItems locationData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<LocationDataItems> locationList);

  @Query("delete from Location where id = :id")
  Future<void> deleteData(int id);
}