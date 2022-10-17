import 'package:cygneto/data/models/no_order/no_order_type_data.dart';
import 'package:floor/floor.dart';

@dao
abstract class NoOrderTypeDao{
  @Query('Select * From NoOrderType')
  Future<List<NoOrderTypeData>> getNoOrderType();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAllData(List<NoOrderTypeData> noOrderTypeList);

}