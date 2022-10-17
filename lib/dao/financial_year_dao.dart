
import 'package:floor/floor.dart';

import '../data/models/financial_year/financial_year_data.dart';

@dao
abstract class FinancialYearDao {
  @Query('Select * From FinancialYear')
  Future<List<FinancialYearData>?> getAllData();
  @Query('select * from FinancialYear where isCurrentYear=1')
  Future<List<FinancialYearData>> getCurrentFinancialYear();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertFinancialYearData(FinancialYearData data);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<FinancialYearData> financialYearList);

  @Query("delete from FinancialYear where id = :id")
  Future<void> deleteData(int id);
}
