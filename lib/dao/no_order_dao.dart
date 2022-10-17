import 'package:cygneto/data/models/no_order/no_order_request.dart';
import 'package:floor/floor.dart';

@dao
abstract class NoOrderDao{
  @Query('Select * From NoOrder')
  Future<List<NoOrderRequest>> getNoOrder();

  @Query('select* from NoOrder where isSync = 0 ')
  Future<List<NoOrderRequest>> getUnSyncNoOrder();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertOrderItemData(NoOrderRequest noOrderData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<NoOrderRequest> noOrderList);

  @Query("delete from NoOrder where id = :id")
  Future<void> deleteData(int id);

  @Query("delete from NoOrder where isSync = 0")
  Future<bool?> deleteUnSyncData();

}