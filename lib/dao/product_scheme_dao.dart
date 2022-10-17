import 'package:floor/floor.dart';

import '../exports/models.dart';

@dao
abstract class ProductSchemeDao{
  @Query('Select * From ProductScheme')
  Future<List<ProductSchemaData>?> getProductSchemeData();


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductSchemeData(ProductSchemaData productSchemeData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ProductSchemaData> productSchemeList);

  @Query("delete from ProductScheme where id = :id")
  Future<void> deleteData(int id);
}