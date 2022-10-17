import 'package:floor/floor.dart';

import '../data/models/country/country_data_response.dart';

@dao
abstract class CountryDao{
  @Query('Select * From Country')
  Future<List<CountryData>?> getCountryData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertCountryData(CountryData countryData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<CountryData> countryList);

  @Query("delete from Country where id = :id")
  Future<void> deleteData(int id);
}