import 'package:floor/floor.dart';

import '../data/models/closing_balance/closing_balance.dart';

@dao
abstract class ClosingBalanceDao {
  @Query('Select * From ClosingBalance')
  Future<List<ClosingBalance>?> getAllData();

  @Query(
      'select *  from ClosingBalance where customerId =:customerId and fyId=:fyId')
  Future<List<ClosingBalance>?> getCurrentFinancialYearOpeningBalance(
      int customerId, int fyId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertClosingBalanceData(ClosingBalance data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<ClosingBalance> data);

  @Query("delete from ClosingBalance where id = :id")
  Future<void> deleteData(int id);
}
