import 'package:floor/floor.dart';

import '../constants/app_constants.dart';
import '../data/models/sales_return/sales_return_item.dart';

@dao
abstract class SalesReturnDao {
  @Query('Select * From SalesReturn')
  Future<List<SalesReturnItem>?> getAllData();

  @Query('Select * From SalesReturn where isSync = ${SyncStatus.unSync}')
  Future<List<SalesReturnItem>> getAllUnSyncData();

  @Query('select * from SalesReturn where secondaryInvoiceId = :id and isApprove = 1')
  Future<List<SalesReturnItem>?> getApprovedSalesReturnForInvoice(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertSalesReturnData(SalesReturnItem data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<SalesReturnItem> salesReturnList);

  @Query("delete from SalesReturn where id = :id")
  Future<void> deleteData(int id);

  @Query("delete from SalesReturn where isSync = ${SyncStatus.unSync}")
  Future<void> deleteUnSyncedData();
}
