import 'package:floor/floor.dart';

import '../data/models/state/state_data_item_response.dart';

@dao
abstract class StateDao{
  @Query('Select * From StateData')
  Future<StateDataItemResponse?> getStateData();

  @Query('Select * From StateData where country_id = :id')
  Future<List<StateDataItemResponse>?> getStatesBasedOnCountryId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertStateData(StateDataItemResponse stateData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<StateDataItemResponse> stateList);

  @Query("delete from StateData where id = :id")
  Future<void> deleteData(int id);
}