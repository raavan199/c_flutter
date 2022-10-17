import 'package:floor/floor.dart';

import '../data/models/customer/customer_data_items_response.dart';

@dao
abstract class CustomerDao{
  @Query('Select * From customer')
  Future<List<CustomerDataItemsResponse>> getCustomerData();

  @Query('Select * From customer where route_id = :id')
  Future<List<CustomerDataItemsResponse>> getCustomerDataBasedOnRouteId(int id);

  @Query('Select * From customer where id = :id')
  Future<CustomerDataItemsResponse?> getCustomerDataBasedOnId(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCustomerData(CustomerDataItemsResponse customerData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<CustomerDataItemsResponse> customerDataList);

  @Query("delete from customer where id = :id")
  Future<void> deleteData(int id);

  @Query("select COUNT(*) from customer")
  Future<int?> getCountOfTotalCustomers();
}