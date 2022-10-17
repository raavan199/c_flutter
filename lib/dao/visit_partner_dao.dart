import 'package:floor/floor.dart';

import '../data/models/visit_partners/visit_partners_data_response.dart';

@dao
abstract class VisitPartnerDao{
  @Query('Select * From VisitPartner')
  Future<List<VisitPartnersDataResponse>> getAllData();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVisitPartnerData(VisitPartnersDataResponse visitPartnerData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<VisitPartnersDataResponse> visitPartnerList);

  @Query("delete from VisitPartner where id = :id")
  Future<void> deleteData(int id);
}