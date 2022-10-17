import 'package:floor/floor.dart';

import '../data/models/visit_order_mapping/visit_order_item.dart';

@dao
abstract class VisitOrderMappingDao {
  @Query('Select * From VisitOrderMapping')
  Future<List<VisitOrderItem>> getOrderItemData();

   @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVisitOrderMappingData(VisitOrderItem orderItemData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<VisitOrderItem> orderItemList);

  @Query("delete from VisitOrderMapping where id = :id")
  Future<void> deleteData(int id);
}
