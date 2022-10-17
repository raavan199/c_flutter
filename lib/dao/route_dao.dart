import 'package:floor/floor.dart';

import '../data/models/LatestDate.dart';
import '../data/models/route/get_route_by_user_items.dart';

@dao
abstract class RouteDao {
  @Query('Select * From route')
  Future<List<RouteItems>> getAllData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertRouteData(RouteItems routeData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<RouteItems> routeDataList);

  @Query("delete from route where id = :id")
  Future<void> deleteData(int id);
}
