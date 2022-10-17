import 'package:cygneto/exports/models.dart';
import 'package:floor/floor.dart';


@dao
abstract class CustomerImageDao {
  @Query('Select * From CustomerImage')
  Future<List<CustomerImageItemResponse>> getAllData();

  @Query('select * from CustomerImage where customer_id = :customerId and folder_id = :folderId')
  Future<List<CustomerImageItemResponse>> getImageIdData(int customerId, int folderId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCustomerImageData(CustomerImageItemResponse customerImageData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<CustomerImageItemResponse> customerImageList);

  @Query("delete from CustomerImage where id = :id")
  Future<void> deleteData(int id);
}
