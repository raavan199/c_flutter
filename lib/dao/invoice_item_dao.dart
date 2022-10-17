import 'package:floor/floor.dart';

import '../data/models/invoice/invoice_item.dart';
import '../data/models/invoice/order_invoice_mapping.dart';

@dao
abstract class InvoiceItemDao {
  @Query('select * from InvoiceItem')
  Future<List<InvoiceItem>?> getAllData();

  @Query('select * from InvoiceItem where customerId=:id')
  Future<List<InvoiceItem>?> getInvoiceListBasedOnCustomer(int id);

  @Query('select * from InvoiceItem  WHERE secondaryInvoiceId IN (:ids)')
  Future<List<InvoiceItem>?> getInvoiceListBasedOnInvoice(List<int> ids);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertInvoiceMapping(InvoiceItem productWithPriceModel);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<InvoiceItem> productWithPriceModel);

  @Query("delete from InvoiceItem where id = :id")
  Future<bool?> deleteData(int id);

  @Query("delete from InvoiceItem")
  Future<bool?> deleteAllData();
}
