import 'package:floor/floor.dart';

import '../data/models/sacheme_list/scheme_list_data_response.dart';

@dao
abstract class SchemeDao{
  @Query('Select * From Scheme')
  Future<SchemeListDataResponse?> getAllData();

  @Query('select * from Scheme where id = (select scheme_id from ProductScheme WHERE product_id = :pId)')
  Future<List<SchemeListDataResponse>?> getSchemaList(int pId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSchemeData(SchemeListDataResponse schemeData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<SchemeListDataResponse> schemeList);

  @Query("delete from Scheme where id = :id")
  Future<void> deleteData(int id);
}