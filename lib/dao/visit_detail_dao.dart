import 'package:floor/floor.dart';

import '../data/models/visit/visit_data_items_response.dart';

@dao
abstract class VisitDetailDao {
  // Get Data
  @Query('Select * From VisitDetail')
  Future<List<VisitDataItemsResponse>> getVisitDetailData();

  @Query('Select * From VisitDetail where isSync = 0')
  Future<List<VisitDataItemsResponse>> getUnSyncPunchVisit();

  @Query('Select * From VisitDetail where customer_id = :id ORDER BY created_on DESC Limit 1')
  Future<VisitDataItemsResponse?> getVisitBasedOnCustomerId(int id);

  @Query('Select * From VisitDetail where scopeId = :id')
  Future<VisitDataItemsResponse?> getVisitIDByScopeId(int id);

  // Insert Data
  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertVisitDetailData(VisitDataItemsResponse visitDetailData);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<VisitDataItemsResponse> visitDetailList);

  // Update Data
  @Query('Update VisitDetail set end_time = :endTime, isSync = :isSync, modified_by = :modifiedBy, modified_on = :endTime, scopeId = :scopeId where id = :visitId')
  Future<VisitDataItemsResponse?> updateVisitPunchOut(int scopeId, String endTime, int isSync, int modifiedBy, int visitId);

  // Delete Data
  @Query("delete from VisitDetail where id = :id")
  Future<void> deleteData(int id);

  @Query("delete from VisitDetail where isSync = 0")
  Future<bool?> deleteUnSyncData();
}
