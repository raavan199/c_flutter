import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../dao/activity_register_type_dao.dart';
import '../dao/activity_registered_dao.dart';
import '../dao/attendance_dao.dart';
import '../dao/attendance_detail_dao.dart';
import '../dao/cart_dao.dart';
import '../dao/closing_balance_dao.dart';
import '../dao/country_dao.dart';
import '../dao/customer_address_dao.dart';
import '../dao/customer_category_dao.dart';
import '../dao/customer_dao.dart';
import '../dao/customer_image_dao.dart';
import '../dao/customer_type_dao.dart';
import '../dao/distribution_dao.dart';
import '../dao/district_dao.dart';
import '../dao/financial_year_dao.dart';
import '../dao/image_folder_dao.dart';
import '../dao/invoice_item_dao.dart';
import '../dao/invoice_mapping_dao.dart';
import '../dao/invoice_statement_dao.dart';
import '../dao/journey_cycle_dao.dart';
import '../dao/leave_dao.dart';
import '../dao/location_dao.dart';
import '../dao/login_dao.dart';
import '../dao/no_order_dao.dart';
import '../dao/no_order_type_dao.dart';
import '../dao/order_item_dao.dart';
import '../dao/order_record_dao.dart';
import '../dao/product_category_dao.dart';
import '../dao/product_dao.dart';
import '../dao/product_group_dao.dart';
import '../dao/product_pricing_dao.dart';
import '../dao/product_scheme_dao.dart';
import '../dao/product_trend_dao.dart';
import '../dao/product_trends_location_dao.dart';
import '../dao/route_dao.dart';
import '../dao/sales_return_dao.dart';
import '../dao/sales_return_reason_dao.dart';
import '../dao/scheme_dao.dart';
import '../dao/state_dao.dart';
import '../dao/uom_dao.dart';
import '../dao/user_role_rights_dao.dart';
import '../dao/visit_detail_dao.dart';
import '../dao/visit_order_mapping_dao.dart';
import '../dao/visit_partner_dao.dart';
import '../dao/warehouse_dao.dart';
import '../data/models/cart/cart_model.dart';
import '../data/models/closing_balance/closing_balance.dart';
import '../data/models/financial_year/financial_year_data.dart';
import '../data/models/invoice/invoice_statement_item.dart';
import '../data/models/journey_cycle/journey_cycle_data.dart';
import '../data/models/order_item/order_item_data_response.dart';
import '../data/models/product_trends/product_trends_item.dart';
import '../data/models/product_trends/product_trends_location_item.dart';
import '../data/models/route/get_route_by_user_items.dart';
import '../data/models/user_role_rights/user_role_rights_response.dart';
import '../data/models/visit_order_mapping/visit_order_item.dart';
import '../exports/models.dart';

part 'app_database.g.dart'; // the generated code will be there

/// Created by Dev 1051 on 12/6/2021
/// Modified by Dev 1051 on 12/6/2021
/// Purpose : This is a database class which will used to manage, DB version,
/// entities and dao. Here, you need to define 'part' to make generator class.
@Database(version: 1, entities: [
  LoginDataResponse,
  CustomerDataItemsResponse,
  CustomerAddressResponse,
  CustomerTypeDataResponse,
  StateDataItemResponse,
  RouteItems,
  DistrictItems,
  ProductListDataItemsResponse,
  DistributionData,
  UOMDataResponse,
  WarehouseDataItemsResponse,
  VisitPartnersDataResponse,
  ProductGroupItems,
  ProductPricingItems,
  ProductCategoryListDataItemsResponse,
  SchemeListDataResponse,
  UserRoleRightsResponse,
  VisitDataItemsResponse,
  ProductSchemaData,
  ImageFolderDataResponse,
  ProductWithPriceModel,
  CartModel,
  OrderRecordDataResponse,
  OrderItemDataResponse,
  VisitOrderItem,
  ProductTrendsItem,
  ProductTrendsLocationItem,
  CustomerCategoryDataResponse,
  LocationDataItems,
  CountryData,
  CustomerImageItemResponse,
  NoOrderTypeData,
  NoOrderRequest,
  SalesReturnItem,
  OrderInvoiceMapping,
  InvoiceItem,
  SalesReturnReason,
  LeaveItem,
  AttendanceItem,
  AttendanceDetails,
  ActivityRegisterTypeData,
  ActivityRegisteredItem,
  SalesReturnReason,
  InvoiceStatementItem,
  JourneyCycleData,
  FinancialYearData,
  ClosingBalance
])
abstract class AppDatabase extends FloorDatabase {
  LoginDao get loginDao;

  CustomerDao get customerDao;

  CustomerAddressDao get customerAddressDao;

  CustomerTypeDao get customerTypeDao;

  StateDao get stateDao;

  RouteDao get routeDao;

  ProductDao get productDao;

  DistrictDao get districtDao;

  DistributionDao get distributionDao;

  UoMDao get uomDao;

  WarehouseDao get warehouseDao;

  VisitPartnerDao get visitPartnerDao;

  ProductGroupDao get productGroupDao;

  ProductPricingDao get productPricingDao;

  ProductCategoryDao get productCategoryDao;

  SchemeDao get schemeDao;

  UserRoleRightsDao get userRoleRightsDao;

  VisitDetailDao get visitDetailDao;

  ProductSchemeDao get productSchemeDao;

  ImageFolderDao get imageFolderDao;

  CartDao get cartDao;

  OrderRecordDao get orderRecordDao;

  OrderItemDao get orderItemDao;

  VisitOrderMappingDao get visitOrderMappingDao;

  ProductTrendDao get productTrendsDao;

  ProductTrendsLocationDao get productTrendsLocationDao;

  CustomerCategoryDao get customerCategoryDao;

  LocationDao get locationDao;

  CountryDao get countryDao;

  CustomerImageDao get customerImageDao;

  NoOrderTypeDao get noOrderTypeDio;

  NoOrderDao get noOrderDao;

  SalesReturnDao get salesReturnDao;

  InvoiceMappingDao get invoiceMappingDao;

  InvoiceItemDao get invoiceItemDao;

  SalesReturnReasonDao get salesReturnReasonDao;

  LeaveDao get leaveDao;

  AttendanceDao get attendanceDao;

  AttendanceDetailDao get attendanceDetailDao;

  ActivityRegisterTypeDao get activityRegisterTypeDao;

  ActivityRegisteredDao get activityRegisteredDao;

  InvoiceStatementDao get invoiceStatementDao;

  JourneyCycleDao get journeyCycleDao;

  FinancialYearDao get financialYearDao;

  ClosingBalanceDao get closingBalanceDao;
}
