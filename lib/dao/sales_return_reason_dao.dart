import 'package:floor/floor.dart';

import '../data/models/sales_return/sales_return_item.dart';
import '../data/models/sales_return/sales_return_reason.dart';

@dao
abstract class SalesReturnReasonDao {
  @Query('Select * From SalesReturnReason')
  Future<List<SalesReturnReason>?> getAllData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertData(SalesReturnReason data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<SalesReturnReason> salesReturnList);

  @Query("delete from SalesReturnReason where id = :id")
  Future<void> deleteData(int id);
}
