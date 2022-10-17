import 'package:floor/floor.dart';

import '../exports/models.dart';

@dao
abstract class ProductPricingDao{
  @Query('Select * From productPricing')
  Future<List<ProductPricingItems>> getAllData();

  @Query('Select * From productPricing where product_id = :id')
  Future<List<ProductPricingItems>> getAllDataBasedOnProductId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductGroupData(ProductPricingItems productPricingData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ProductPricingItems> productPricingList);

  @Query("delete from productPricing where id = :id")
  Future<void> deleteData(int id);
}