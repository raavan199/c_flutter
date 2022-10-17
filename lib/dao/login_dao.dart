import 'package:floor/floor.dart';

import '../data/models/login/login_data_response.dart';

@dao
abstract class LoginDao {
  @Query('Select * From LoginDataResponse')
  Future<LoginDataResponse?> getLoginData();

  @Query('Select pin_hash From LoginDataResponse')
  Future<LoginDataResponse?> getPinHashData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLoginData(LoginDataResponse loginUserData);

  @Query("delete from LoginDataResponse where id = :id")
  Future<void> deleteData(int id);

  

}
