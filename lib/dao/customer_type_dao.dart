import 'package:floor/floor.dart';

import '../data/models/customer_type/customer_type_data_response.dart';

@dao
abstract class CustomerTypeDao{
  @Query('Select * From CustomerType')
  Future<List<CustomerTypeDataResponse>?> getCustomerData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCustomerData(CustomerTypeDataResponse customerData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<CustomerTypeDataResponse> customerDataList);

  @Query("delete from CustomerType where id = :id")
  Future<void> deleteData(int id);
}