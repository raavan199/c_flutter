import 'package:floor/floor.dart';

import '../dao/customer_dao.dart';
import '../data/models/login/login_data_response.dart';
import 'app_database.dart';

class DBModule {
  DBModule() {
    initDB(getMigration());
  }

  late AppDatabase _database;

  AppDatabase get dbInstance => _database;

  Future<void> initDB(List<Migration> migration) async {
    _database =
        await $FloorAppDatabase.databaseBuilder('fsm_database.db').addMigrations(
            migration).build();
  }

  List<Migration> getMigration() {
    final migrations = <Migration>[];

    return migrations;

  }

  void deleteDatabase() {
    _database.database.delete('ActivityRegisterType');
    _database.database.delete('ActivityRegistered');
    _database.database.delete('Attendance');
    _database.database.delete('AttendanceDetail');
    _database.database.delete('Country');
    _database.database.delete('CustomerAddress');
    _database.database.delete('CustomerCategory');
    _database.database.delete('CustomerImage');
    _database.database.delete('CustomerType');
    _database.database.delete('Distribution');
    _database.database.delete('FinancialYear');
    _database.database.delete('ImageFolder');
    _database.database.delete('InvoiceItem');
    _database.database.delete('InvoiceStatement');
    _database.database.delete('JourneyCycle');
    _database.database.delete('Leave');
    _database.database.delete('Location');
    _database.database.delete('LoginDataResponse');
    _database.database.delete('NoOrder');
    _database.database.delete('NoOrderType');
    _database.database.delete('OrderInvoiceMapping');
    _database.database.delete('OrderItem');
    _database.database.delete('OrderRecord');
    _database.database.delete('ProductCategory');
    _database.database.delete('ProductGroup');
    _database.database.delete('ProductScheme');
    _database.database.delete('ProductTrends');
    _database.database.delete('ProductTrendsLocation');
    _database.database.delete('SalesReturn');
    _database.database.delete('SalesReturnReason');
    _database.database.delete('Scheme');
    _database.database.delete('StateData');
    _database.database.delete('UnitOfMeasure');
    _database.database.delete('UserRoleRightsResponse');
    _database.database.delete('VisitDetail');
    _database.database.delete('VisitDetailMapping');
    _database.database.delete('VisitPartner');
    _database.database.delete('Warehouse');
    _database.database.delete('cart');
    _database.database.delete('customer');
    _database.database.delete('district');
    _database.database.delete('productList');
    _database.database.delete('productPricing');
    _database.database.delete('route');
    _database.database.delete('ClosingBalance');
  }
}
