import 'package:floor/floor.dart';

import '../exports/models.dart';

@dao
abstract class OrderRecordDao{
  @Query('Select * From OrderRecord where customer_id = :customerId')
  Future<List<OrderRecordDataResponse>> getOrderRecordData(int customerId);

  @Query('select * from OrderRecord where customer_id = :customerId order by created_on desc limit 1')
  Future<OrderRecordDao?> getLastOrderByCustomerId(int customerId);

  @Query('select* from OrderRecord where isSync = 0 ')
  Future<List<OrderRecordDataResponse>> getUnSyncOrder();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<int?> insertOrderRecordData(OrderRecordDataResponse orderRecordData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<OrderRecordDataResponse> orderRecordList);

  @Query("delete from OrderRecord where id = :id")
  Future<void> deleteData(int id);

  @Query("delete from OrderRecord where isSync = 0")
  Future<bool?> deleteUnSyncData();
}