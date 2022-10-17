import 'package:cygneto/data/models/product_trends/product_trends_item.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProductTrendDao{
  @Query('Select * From ProductTrends')
  Future<List<ProductTrendsItem>?> getProductSchemeData();


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductSchemeData(ProductTrendsItem productSchemeData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ProductTrendsItem> productSchemeList);

  @Query("delete from ProductTrends where id = :id")
  Future<void> deleteData(int id);
}