import 'package:cygneto/data/models/outlet/customer_category_data_response.dart';
import 'package:floor/floor.dart';

@dao
abstract class CustomerCategoryDao{
  @Query("Select * From CustomerCategory")
  Future<List<CustomerCategoryDataResponse>> getCustomerCategoryData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<CustomerCategoryDataResponse> customerCategoryList);

  @Query("delete from CustomerCategory where id = :id")
  Future<void> deleteData(int id);
}