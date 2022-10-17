import 'package:floor/floor.dart';

import '../data/models/district/district_items_response.dart';


@dao
abstract class DistrictDao{

  @Query('Select * From district')
  Future<DistrictItems?> getAllData();

  @Query('Select * From district where state_id = :id')
  Future<List<DistrictItems>?> getDistrictBasedOnStateId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertDistrictData(DistrictItems districtData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<DistrictItems> districtDataList);

  @Query("delete from district where id = :id")
  Future<void> deleteData(int id);

}