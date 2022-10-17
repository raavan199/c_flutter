import 'package:floor/floor.dart';

import '../data/models/warehouse/warehouse_data_items_response.dart';

@dao
abstract class WarehouseDao{
  @Query('Select * From Warehouse')
  Future<List<WarehouseDataItemsResponse>> getWarehouseData();

  @Query('Select * From Warehouse where distributor_id = :distributorId')
  Future <List<WarehouseDataItemsResponse>> getWarehouseDataBasedOnDistributor(int distributorId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertWarehouseData(WarehouseDataItemsResponse warehouseData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<WarehouseDataItemsResponse> warehouseList);

  @Query("delete from Warehouse where id = :id")
  Future<void> deleteData(int id);
}
