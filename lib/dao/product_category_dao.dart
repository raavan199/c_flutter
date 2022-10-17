import 'package:floor/floor.dart';

import '../data/models/product_category_list/product_category_list_data_items_response.dart';

@dao
abstract class ProductCategoryDao{
  @Query('Select * From ProductCategory')
  Future<List<ProductCategoryListDataItemsResponse>> getAllData();

  @Query('Select * From ProductCategory where category_id is null')
  Future<List<ProductCategoryListDataItemsResponse>?> getParentCategoryData();

  @Query('Select * From ProductCategory where category_id = :id')
  Future<List<ProductCategoryListDataItemsResponse>?> getSubCategoryData(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductCategoryData(ProductCategoryListDataItemsResponse productCategoryData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ProductCategoryListDataItemsResponse> productCategoryList);

  @Query("delete from ProductCategory where id = :id")
  Future<void> deleteData(int id);
}