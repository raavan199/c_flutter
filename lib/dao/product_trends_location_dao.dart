import 'package:cygneto/data/models/product_trends/product_trends_item.dart';
import 'package:cygneto/data/models/product_trends/product_trends_location_item.dart';
import 'package:floor/floor.dart';

@dao
abstract class ProductTrendsLocationDao{
  @Query('Select * From ProductTrendsLocation')
  Future<List<ProductTrendsLocationItem>?> getProductTrendsLocation();


  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductTrendsLocation(ProductTrendsLocationItem productSchemeData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ProductTrendsLocationItem> producTrendsLocation);

  @Query("delete from ProductTrendsLocation where id = :id")
  Future<void> deleteData(int id);
}