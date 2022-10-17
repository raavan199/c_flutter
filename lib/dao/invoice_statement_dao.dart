import 'package:floor/floor.dart';

import '../constants/app_constants.dart';
import '../data/models/invoice/invoice_statement_item.dart';

@dao
abstract class InvoiceStatementDao {
  @Query('select * from InvoiceStatement')
  Future<List<InvoiceStatementItem>?> getAllData();

  @Query('select * from InvoiceStatement where invoiceId = :id')
  Future<List<InvoiceStatementItem>?> getAllDataBasedOnInvoice(int id);

  @Query('select * from InvoiceStatement  WHERE invoiceId IN (:ids)')
  Future<List<InvoiceStatementItem>?> getInvoiceStatementBasedOnInvoices(
      List<int> ids);

  @Query('select * from InvoiceStatement where id = :id')
  Future<InvoiceStatementItem?> getStatementBasedOnId(int id);

  @Query(
      'select * from InvoiceStatement where invoiceId = :id and (created_on = (select max(d) from (select created_on d from InvoiceStatement union select modified_on d from InvoiceStatement)) or modified_on=(select max(d) from (select created_on d from InvoiceStatement union select modified_on d from InvoiceStatement)))')
  Future<InvoiceStatementItem?> getLatestStatementBasedOnInvoiceId(int id);

  @Query('select * from InvoiceStatement where isSync = ${SyncStatus.unSync}')
  Future<List<InvoiceStatementItem>?> getUnSyncedStatements();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertInvoiceStatement(InvoiceStatementItem data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertInvoiceStatements(List<InvoiceStatementItem> data);

  @Query("delete from InvoiceStatement where id = :id")
  Future<bool?> deleteData(int id);

  @Query("delete from InvoiceStatement where isSync = ${SyncStatus.unSync}")
  Future<bool?> deleteUnSyncedData();

  @Query("delete from InvoiceStatement")
  Future<bool?> deleteAllData();
}
