import 'package:cygneto/blocs/add_sales_return/add_sales_return_bloc.dart';
import 'package:cygneto/blocs/analysis/analysis_bloc.dart';
import 'package:cygneto/blocs/order_item/order_item_bloc.dart';
import 'package:cygneto/blocs/timeline/timeline_bloc.dart';
import 'package:cygneto/blocs/add_new_order/add_new_order_bloc.dart';
import 'package:cygneto/blocs/address/address_bloc.dart';
import 'package:cygneto/blocs/apply_leave/apply_leave_bloc.dart';
import 'package:cygneto/blocs/apply_miss_punch/apply_miss_punch_bloc.dart';
import 'package:cygneto/blocs/cart/cart_bloc.dart';
import 'package:cygneto/blocs/customer/customer_bloc.dart';
import 'package:cygneto/blocs/leave/leave_bloc.dart';
import 'package:cygneto/blocs/miss_punch/miss_punch_bloc.dart';
import 'package:cygneto/blocs/modify_outlets/modify_outlet_bloc.dart';
import 'package:cygneto/blocs/image_file/image_file_bloc.dart';
import 'package:cygneto/blocs/order_history/order_history_bloc.dart';
import 'package:cygneto/blocs/outlet_info/outlet_info_bloc.dart';
import 'package:cygneto/blocs/product/product_bloc.dart';
import 'package:cygneto/blocs/filter/filter_bloc.dart';
import 'package:cygneto/blocs/route/route_bloc.dart';
import 'package:cygneto/blocs/select_supplier/select_supplier_bloc.dart';
import 'package:cygneto/blocs/warehouse/warehouse_bloc.dart';
import 'package:cygneto/blocs/image_folder/image_folder_bloc.dart';
import 'package:cygneto/database/db_module.dart';
import 'package:cygneto/blocs/no_order_type/no_order_type_bloc.dart';
import 'package:get_it/get_it.dart';

import '../blocs/accounts/account_bloc.dart';
import '../blocs/actitivy_history/activity_history_bloc.dart';
import '../blocs/activity_register/activity_register_bloc.dart';
import '../blocs/add_new_order/add_new_order_bloc.dart';
import '../blocs/address/address_bloc.dart';
import '../blocs/attendance/attendance_bloc.dart';
import '../blocs/base/base_bloc.dart';
import '../blocs/cart/cart_bloc.dart';
import '../blocs/customer/customer_bloc.dart';
import '../blocs/filter/filter_bloc.dart';
import '../blocs/forgot_pin/forgot_pin_bloc.dart';
import '../blocs/image_file/image_file_bloc.dart';
import '../blocs/image_folder/image_folder_bloc.dart';
import '../blocs/login/login_bloc.dart';
import '../blocs/modify_outlets/modify_outlet_bloc.dart';
import '../blocs/no_order_type/no_order_type_bloc.dart';
import '../blocs/order_history/order_history_bloc.dart';
import '../blocs/outlet_info/outlet_info_bloc.dart';
import '../blocs/payment_collection/payment_collection_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../blocs/reset_pin/reset_pin_bloc.dart';
import '../blocs/route/route_bloc.dart';
import '../blocs/sales_return_history/sales_return_history_bloc.dart';
import '../blocs/select_supplier/select_supplier_bloc.dart';
import '../blocs/sync/sync_bloc.dart';
import '../blocs/view_invoice/view_invoice_bloc.dart';
import '../blocs/visit_punch/visit_punch_bloc.dart';
import '../blocs/warehouse/warehouse_bloc.dart';
import '../database/db_module.dart';
import '../ui/router/app_router.dart';
import 'api/api_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator
    ..registerLazySingleton(() => AppRouter())

    // Services
    ..registerLazySingleton(() => ApiService())

    // Repos
    ..registerLazySingleton(() => LoginBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ForgotPinBloc())
    ..registerLazySingleton(() => ResetPinBloc())
    ..registerLazySingleton(() => SyncBloc(locator<DBModule>()))
    ..registerLazySingleton(() => DBModule())
    ..registerLazySingleton(() => RouteBloc(locator<DBModule>()))
    ..registerLazySingleton(() => CustomerBloc(locator<DBModule>()))
    ..registerLazySingleton(() => SelectSupplierBloc(locator<DBModule>()))
    ..registerLazySingleton(() => WarehouseBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ProductBloc(locator<DBModule>()))
    ..registerLazySingleton(() => AddNewOrderBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ImageFolderBloc(locator<DBModule>()))
    ..registerLazySingleton(() => FilterBloc(locator<DBModule>()))
    ..registerLazySingleton(() => CartBloc(locator<DBModule>()))
    ..registerLazySingleton(() => VisitPunchBloc(locator<DBModule>()))
    ..registerLazySingleton(() => OutletInfoBloc(locator<DBModule>()))
    ..registerLazySingleton(() => OrderHistoryBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ModifyOutletBloc(locator<DBModule>()))
    ..registerLazySingleton(() => AddressBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ImageFileBloc(locator<DBModule>()))
    ..registerLazySingleton(() => NoOrderTypeBloc(locator<DBModule>()))
    ..registerLazySingleton(() => OrderItemBloc(locator<DBModule>()))
    ..registerLazySingleton(() => SalesReturnHistoryBloc(locator<DBModule>()))
    ..registerLazySingleton(() => AddSalesReturnBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ApplyLeaveBloc(locator<DBModule>()))
    ..registerLazySingleton(() => LeaveBloc(locator<DBModule>()))
    ..registerLazySingleton(() => MissPunchBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ApplyMissPunchBloc(locator<DBModule>()))
    ..registerLazySingleton(() => AttendanceBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ActivityRegisterBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ActivityHistoryBloc(locator<DBModule>()))
    ..registerLazySingleton(() => AccountBloc(locator<DBModule>()))
    ..registerLazySingleton(() => PaymentCollectionBloc(locator<DBModule>()))
    ..registerLazySingleton(() => TimelineBloc(locator<DBModule>()))
    ..registerLazySingleton(() => AnalysisBloc(locator<DBModule>()))
    ..registerLazySingleton(() => ViewInvoiceBloc(locator<DBModule>()))
    ..registerLazySingleton(() => BaseBloc());

}
