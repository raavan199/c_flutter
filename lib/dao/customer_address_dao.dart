import 'package:floor/floor.dart';

import '../data/models/customer/customer_address_response.dart';

@dao
abstract class CustomerAddressDao {
  @Query('Select * From CustomerAddress where customerId = :id')
  Future<List<CustomerAddressResponse>?> getAllData(
      int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCustomerAddressData(
      List<CustomerAddressResponse> customerAddressData);

  @Query("delete from CustomerAddress where id = :id")
  Future<void> deleteData(int id);
}
