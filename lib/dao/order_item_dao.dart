import 'package:floor/floor.dart';

import '../data/models/order_item/order_item_data_response.dart';

@dao
abstract class OrderItemDao{
  @Query('Select * From OrderItem')
  Future<List<OrderItemDataResponse>> getOrderItemData();

  @Query('select* from OrderItem where isSync = 0 ')
  Future<List<OrderItemDataResponse>> getUnSyncOrder();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrderItemData(OrderItemDataResponse orderItemData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<OrderItemDataResponse> orderItemList);

  @Query("delete from OrderItem where id = :id")
  Future<void> deleteData(int id);

  @Query("delete from OrderItem where isSync = 0")
  Future<bool?> deleteUnSyncData();
}