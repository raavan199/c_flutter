import 'package:floor/floor.dart';

import '../data/models/user_role_rights/user_role_rights_response.dart';

@dao
abstract class UserRoleRightsDao {

  @Query('Select * From UserRoleRightsResponse')
  Future<UserRoleRightsResponse?> getUserRoleData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertLoginData(UserRoleRightsResponse userRoleData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<UserRoleRightsResponse> userRoleList);

  @Query("delete from UserRoleRightsResponse where id = :id")
  Future<void> deleteData(int id);
}