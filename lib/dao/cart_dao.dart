import 'package:floor/floor.dart';

import '../data/models/product_list/product_with_price_model.dart';

@dao
abstract class CartDao {
  @Query('select * from cart')
  Future<List<ProductWithPriceModel>?> getAllData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertProductIntoCart(ProductWithPriceModel productWithPriceModel);

  @Query("delete from cart where id = :id")
  Future<bool?> deleteData(int id);

  @Query("delete from cart")
  Future<bool?> deleteAllData();
}
