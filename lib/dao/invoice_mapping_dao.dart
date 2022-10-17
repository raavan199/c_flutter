import 'package:floor/floor.dart';

import '../data/models/invoice/order_invoice_mapping.dart';

@dao
abstract class InvoiceMappingDao {
  @Query('select * from OrderInvoiceMapping')
  Future<List<OrderInvoiceMapping>?> getAllData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertData(OrderInvoiceMapping productWithPriceModel);

  @Query('select * from OrderInvoiceMapping where customerId=:id')
  Future<List<OrderInvoiceMapping>?> getInvoiceListBasedOnCustomer(int id);

  @Query(
      'select * from OrderInvoiceMapping where customerId=:id and strftime("%Y-%m-%d",:startDate )<=strftime("%Y-%m-%d",date) and strftime("%Y-%m-%d",:endDate )>=strftime("%Y-%m-%d",date)')
  Future<List<OrderInvoiceMapping>?> getInvoiceListBasedOnCustomerAndDate(
      int id, String startDate, String endDate);

  @Query(
      'select * from OrderInvoiceMapping where customerId=:id and orderId=:orderId')
  Future<List<OrderInvoiceMapping>?> getInvoiceListBasedOnCustomerAndOrderId(
      int id, int orderId);

  @Query(
      'select * from OrderInvoiceMapping where customerId=:id and strftime("%Y-%m-%d",:startDate )>strftime("%Y-%m-%d",date)')
  Future<List<OrderInvoiceMapping>?> getInvoiceListForOpeningBalance(
      int id, String startDate);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<OrderInvoiceMapping> productWithPriceModel);

  @Query("delete from OrderInvoiceMapping where id = :id")
  Future<bool?> deleteData(int id);

  @Query("delete from OrderInvoiceMapping")
  Future<bool?> deleteAllData();
}
