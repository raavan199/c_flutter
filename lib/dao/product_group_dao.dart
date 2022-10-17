import 'package:floor/floor.dart';

import '../exports/models.dart';

@dao
abstract class ProductGroupDao{
  @Query('Select * From ProductGroup')
  Future<List<ProductGroupItems>?> getAllData();

  @Query('Select * From ProductGroup where group_id is null')
  Future<List<ProductGroupItems>?> getParentGroupData();

  @Query('Select * From ProductGroup where group_id = :id')
  Future<List<ProductGroupItems>?> getSubGroupData(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductGroupData(ProductGroupItems productGroupData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ProductGroupItems> productGroupList);

  @Query("delete from ProductGroup where id = :id")
  Future<void> deleteData(int id);
}