import 'package:floor/floor.dart';

import '../data/models/product_list/product_list_data_items_response.dart';

@dao
abstract class ProductDao{
  @Query('Select * From productList')
  Future<List<ProductListDataItemsResponse>> getAllData();

  @Query('Select * From productList where id =:id')
  Future<ProductListDataItemsResponse?> getProductBasedOnId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductData(ProductListDataItemsResponse productData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ProductListDataItemsResponse> productList);

  @Query("delete from productList where id = :id")
  Future<void> deleteData(int id);
}