// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  LoginDao? _loginDaoInstance;

  CustomerDao? _customerDaoInstance;

  CustomerAddressDao? _customerAddressDaoInstance;

  CustomerTypeDao? _customerTypeDaoInstance;

  StateDao? _stateDaoInstance;

  RouteDao? _routeDaoInstance;

  ProductDao? _productDaoInstance;

  DistrictDao? _districtDaoInstance;

  DistributionDao? _distributionDaoInstance;

  UoMDao? _uomDaoInstance;

  WarehouseDao? _warehouseDaoInstance;

  VisitPartnerDao? _visitPartnerDaoInstance;

  ProductGroupDao? _productGroupDaoInstance;

  ProductPricingDao? _productPricingDaoInstance;

  ProductCategoryDao? _productCategoryDaoInstance;

  SchemeDao? _schemeDaoInstance;

  UserRoleRightsDao? _userRoleRightsDaoInstance;

  VisitDetailDao? _visitDetailDaoInstance;

  ProductSchemeDao? _productSchemeDaoInstance;

  ImageFolderDao? _imageFolderDaoInstance;

  CartDao? _cartDaoInstance;

  OrderRecordDao? _orderRecordDaoInstance;

  OrderItemDao? _orderItemDaoInstance;

  VisitOrderMappingDao? _visitOrderMappingDaoInstance;

  ProductTrendDao? _productTrendsDaoInstance;

  ProductTrendsLocationDao? _productTrendsLocationDaoInstance;

  CustomerCategoryDao? _customerCategoryDaoInstance;

  LocationDao? _locationDaoInstance;

  CountryDao? _countryDaoInstance;

  CustomerImageDao? _customerImageDaoInstance;

  NoOrderTypeDao? _noOrderTypeDioInstance;

  NoOrderDao? _noOrderDaoInstance;

  SalesReturnDao? _salesReturnDaoInstance;

  InvoiceMappingDao? _invoiceMappingDaoInstance;

  InvoiceItemDao? _invoiceItemDaoInstance;

  SalesReturnReasonDao? _salesReturnReasonDaoInstance;

  LeaveDao? _leaveDaoInstance;

  AttendanceDao? _attendanceDaoInstance;

  AttendanceDetailDao? _attendanceDetailDaoInstance;

  ActivityRegisterTypeDao? _activityRegisterTypeDaoInstance;

  ActivityRegisteredDao? _activityRegisteredDaoInstance;

  InvoiceStatementDao? _invoiceStatementDaoInstance;

  JourneyCycleDao? _journeyCycleDaoInstance;

  FinancialYearDao? _financialYearDaoInstance;

  ClosingBalanceDao? _closingBalanceDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `LoginDataResponse` (`full_name` TEXT, `email` TEXT, `jwtToken` TEXT, `refreshToken` TEXT, `image` TEXT, `user_id` INTEGER, `isAdmin` INTEGER, `userRoleName` TEXT, `pin_hash` TEXT, PRIMARY KEY (`user_id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `customer` (`id` INTEGER, `isSync` INTEGER, `contact_person_name` TEXT, `business_name` TEXT, `mobile_number` TEXT, `email_address` TEXT, `pin_code` INTEGER, `gst_in` TEXT, `route_id` INTEGER, `route_name` TEXT, `customer_type` INTEGER, `customer_type_name` TEXT, `is_active` INTEGER, `distributorId_1` INTEGER, `distributorId_2` INTEGER, `distributorId_3` INTEGER, `customer_category` INTEGER, `customer_category_name` TEXT, `created_by` INTEGER, `created_on` TEXT, `is_system_generated` INTEGER, `modified_on` TEXT, `modified_by` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CustomerAddress` (`id` INTEGER, `customerId` INTEGER, `pincode` TEXT, `contactPersonName` TEXT, `countryId` INTEGER, `stateId` INTEGER, `districtId` INTEGER, `locationId` INTEGER, `fullAddress` TEXT, `isDefaultAddress` INTEGER, `latitude` TEXT, `longitude` TEXT, `isActive` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_On` TEXT, FOREIGN KEY (`customerId`) REFERENCES `customer` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CustomerType` (`id` INTEGER, `subscriber_id` INTEGER, `type_name` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `StateData` (`id` INTEGER, `code` TEXT, `name` TEXT, `country_id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `route` (`id` INTEGER, `name` TEXT, `status` INTEGER, `subscriber_id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `district` (`id` INTEGER, `name` TEXT, `state_id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `productList` (`id` INTEGER, `name` TEXT, `product_code` TEXT, `group_id` INTEGER, `sub_group_id` INTEGER, `category_id` INTEGER, `sub_category_id` INTEGER, `uom` INTEGER, `uom_1` INTEGER, `uom_2` INTEGER, `uom_3` INTEGER, `uom_4` INTEGER, `subscriber_id` INTEGER, `uom_2_value` INTEGER, `uom_3_value` INTEGER, `is_sellable_uom1` INTEGER, `is_sellable_uom2` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Distribution` (`business_name` TEXT, `contact_person_name` TEXT, `mobile_number` TEXT, `email_id` TEXT, `gst_number` TEXT, `location_id` INTEGER, `state_id` INTEGER, `tenant_id` INTEGER, `type` INTEGER, `full_address` TEXT, `pin_code` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UnitOfMeasure` (`id` INTEGER, `uom_name` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Warehouse` (`id` INTEGER NOT NULL, `name` TEXT, `location_id` INTEGER, `distributor_id` INTEGER, `subscriber_id` INTEGER, `last_damage_updated_on` TEXT, `last_expiry_updated_on` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VisitPartner` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `created_on` TEXT, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductGroup` (`name` TEXT, `group_id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `productPricing` (`subscriber_id` INTEGER, `product_id` INTEGER, `pricing_type` INTEGER, `hsn` TEXT, `cgst` REAL, `sgst` REAL, `igst` REAL, `mrp` REAL, `min_base_price` REAL, `max_base_price` REAL, `state_id` INTEGER, `distributor_id` INTEGER, `distributor_type` INTEGER, `customer_id` INTEGER, `customer_type` INTEGER, `customer_category` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, `uoM` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductCategory` (`name` TEXT, `category_id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Scheme` (`subscriberId` INTEGER, `name` TEXT, `schemeType` INTEGER, `distributorId` INTEGER, `distributorType` INTEGER, `customerId` INTEGER, `customerType` INTEGER, `customerCategory` INTEGER, `stateId` INTEGER, `fyId` INTEGER, `startDate` TEXT, `endDate` TEXT, `minTotalValue` REAL, `maxTotalValue` REAL, `minOrderQnty` REAL, `maxOrderQnty` REAL, `orderUOM` INTEGER, `complementaryQntyPercent` REAL, `complementaryUOM` INTEGER, `freeProductId` INTEGER, `additionalDiscountPercent` REAL, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `UserRoleRightsResponse` (`id` INTEGER, `user_role_id` INTEGER, `moduleName` TEXT, `functionName` TEXT, `interfaceName` TEXT, `create` INTEGER, `modify` INTEGER, `delete` INTEGER, `cancel` INTEGER, `selectPreview` INTEGER, `print` INTEGER, `export` INTEGER, `approve` INTEGER, `rejectDiscard` INTEGER, `transfer` INTEGER, `returnData` INTEGER, `search` INTEGER, `createdBy` INTEGER, `createdOn` TEXT, `modifiedBy` INTEGER, `modifiedOn` TEXT, `user_id` INTEGER, FOREIGN KEY (`user_id`) REFERENCES `LoginDataResponse` (`user_id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VisitDetail` (`visit_type` INTEGER, `partner_id` INTEGER, `make_owner` INTEGER, `customer_id` INTEGER, `start_time` TEXT, `end_time` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, `isSync` INTEGER, `scopeId` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductScheme` (`product_id` INTEGER, `scheme_id` INTEGER, `is_active` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ImageFolder` (`id` INTEGER NOT NULL, `name` TEXT NOT NULL, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `cart` (`id` INTEGER, `name` TEXT, `product_code` TEXT, `group_id` INTEGER, `sub_group_id` INTEGER, `category_id` INTEGER, `sub_category_id` INTEGER, `scheme_id` INTEGER, `hsn` TEXT, `cgst` REAL, `sgst` REAL, `igst` REAL, `uom_1` INTEGER, `uom_2` INTEGER, `uom_3` INTEGER, `uom_4` INTEGER, `uom_2_value` INTEGER, `uom_3_value` INTEGER, `is_sellable_uom1` INTEGER, `is_sellable_uom2` INTEGER, `stockiest_base_price` REAL, `distributor_base_price` REAL, `secondary_base_price` REAL, `retail_base_price` REAL, `subscriber_id` INTEGER, `product_id` INTEGER, `pricing_type` INTEGER, `mrp` REAL, `min_base_price` REAL, `max_base_price` REAL, `state_id` INTEGER, `distributor_id` INTEGER, `distributor_type` INTEGER, `customer_id` INTEGER, `customer_type` INTEGER, `customer_category` INTEGER, `availableStock` REAL, `selected_scheme_id` INTEGER, `scheme_name` TEXT, `quantity` REAL, `discount` REAL, `entered_price` REAL, `selected_uom_id` INTEGER, `selected_uom` TEXT, `free_product_name` TEXT, `free_product_quantity` INTEGER, `free_product_uom` INTEGER, `free_product_uom_name` TEXT, `free_product_hsn` TEXT, `free_product_id` INTEGER, `scheme_discount` REAL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderRecord` (`id` INTEGER, `order_date` TEXT, `order_serial_number` TEXT, `warehouse_id` INTEGER, `distributor_id` INTEGER, `customer_id` INTEGER, `order_type` INTEGER, `fsmOrderType` INTEGER, `total_balance_due` REAL, `total_amount` REAL, `payment_mode` INTEGER, `payment_status` INTEGER, `received_amount` REAL, `pick_adn_pack_status` INTEGER, `bill_status` INTEGER, `subscriber_id` INTEGER, `fy_id` INTEGER, `jc_id` INTEGER, `shipping_address` INTEGER, `billing_address` INTEGER, `scheme_id` INTEGER, `reference_number` TEXT, `added_discount` REAL, `visit_id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `isSync` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderItem` (`id` INTEGER, `order_id` INTEGER, `storage_id` INTEGER, `grn_id` INTEGER, `r_id` INTEGER, `product_id` INTEGER, `hsn_code` TEXT, `cgst` REAL, `sgst` REAL, `igst` REAL, `vat` REAL, `uoM` INTEGER, `pick_and_pack_status` INTEGER, `available_quantity` REAL, `base_price` REAL, `discount` REAL, `order_quantity` REAL, `scheme_id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `isSync` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `VisitOrderMapping` (`order_id` INTEGER, `visit_id` INTEGER, `isActive` INTEGER, `paymentCollectionId` INTEGER, `salesReturnRegisterId` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductTrends` (`id` INTEGER, `productId` INTEGER, `isFocus` INTEGER, `isNew` INTEGER, `isMustSell` INTEGER, `isOutletTrend` INTEGER, `startDate` TEXT, `endDate` TEXT, `isActive` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ProductTrendsLocation` (`id` INTEGER, `product_trend_id` INTEGER, `location_id` INTEGER, `isActive` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CustomerCategory` (`id` INTEGER, `subscriber_id` INTEGER, `category_name` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Location` (`id` INTEGER, `code` TEXT, `name` TEXT, `country_id` INTEGER, `state_id` INTEGER, `district_id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Country` (`id` INTEGER, `code` TEXT, `name` TEXT, `timezone` TEXT, `isDefault` INTEGER, `isActive` INTEGER, `currency` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `CustomerImage` (`file_name` TEXT, `folder_id` INTEGER, `media_file_id` INTEGER, `customer_id` INTEGER, `is_cover` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoOrderType` (`type_name` TEXT, `is_active` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `NoOrder` (`id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `customer_id` INTEGER, `no_order_type_id` INTEGER, `remarks` TEXT, `is_active` INTEGER, `visitId` INTEGER, `isSync` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SalesReturn` (`created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, `returnDate` TEXT, `warehouseId` INTEGER, `customerId` INTEGER, `productId` INTEGER, `secondaryInvoiceId` INTEGER, `rate` REAL, `storageId` INTEGER, `sellableQuantity` REAL, `damagedQuantity` REAL, `uoM` INTEGER, `reasonId` INTEGER, `fyId` INTEGER, `jcId` INTEGER, `remark` TEXT, `grnId` INTEGER, `rId` INTEGER, `subscriberId` INTEGER, `distributorId` INTEGER, `batchNumber` TEXT, `cgst` REAL, `sgst` REAL, `igst` REAL, `isApprove` INTEGER, `isCancel` INTEGER, `isSync` INTEGER, `visitId` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `OrderInvoiceMapping` (`id` INTEGER NOT NULL, `orderId` INTEGER NOT NULL, `date` TEXT NOT NULL, `secondaryInvoiceSerialNumber` TEXT NOT NULL, `distributorId` INTEGER NOT NULL, `fyId` INTEGER NOT NULL, `jcId` INTEGER NOT NULL, `customerId` INTEGER NOT NULL, `vehicleId` INTEGER, `deliveryStatus` INTEGER NOT NULL, `subscriberId` INTEGER NOT NULL, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `InvoiceItem` (`secondaryInvoiceId` INTEGER, `productId` INTEGER, `hsnCode` TEXT, `cgst` REAL, `sgst` REAL, `igst` REAL, `billQuantity` INTEGER, `schemeId` INTEGER, `weight` REAL, `basePrice` REAL, `discount` REAL, `deliveryStatus` INTEGER, `batchNumber` TEXT, `expiryDate` TEXT, `uoM` INTEGER, `grnId` INTEGER, `receivedId` INTEGER, `orderItemId` INTEGER, `pickAndPackRegisterId` INTEGER, `id` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `partnerId` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SalesReturnReason` (`created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, `subscriberId` INTEGER, `distributorId` INTEGER, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Leave` (`id` INTEGER, `fromDate` TEXT, `toDate` TEXT, `isHalfDay` INTEGER, `isFirstHalf` INTEGER, `leaveTypeId` INTEGER, `remarks` TEXT, `approverRemark` TEXT, `leaveStatus` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Attendance` (`status` INTEGER, `attendanceStatus` INTEGER, `approverRemark` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, `isSync` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AttendanceDetail` (`attendanceId` INTEGER, `punchInTime` TEXT, `punchOutTime` TEXT, `punchInMediaFileId` INTEGER, `punchOutMediaFileId` INTEGER, `status` INTEGER, `punchInImagePath` TEXT, `punchOutImagePath` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, `isSync` INTEGER, FOREIGN KEY (`attendanceId`) REFERENCES `Attendance` (`id`) ON UPDATE NO ACTION ON DELETE CASCADE, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ActivityRegisterType` (`name` TEXT, `status` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ActivityRegistered` (`date` TEXT, `details` TEXT, `startTime` TEXT, `endTime` TEXT, `activityTypeId` INTEGER, `activityRegisterStatus` INTEGER, `status` INTEGER, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, `isSync` INTEGER NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `SalesReturnReason` (`created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, `subscriberId` INTEGER, `distributorId` INTEGER, `name` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `InvoiceStatement` (`customerId` INTEGER NOT NULL, `invoiceId` INTEGER NOT NULL, `paidBy` INTEGER NOT NULL, `referenceNumber` TEXT, `amount` REAL, `distributorId` INTEGER NOT NULL, `subscriberId` INTEGER, `fyId` INTEGER NOT NULL, `jcId` INTEGER NOT NULL, `isSync` INTEGER, `visitId` INTEGER, `id` INTEGER NOT NULL, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `JourneyCycle` (`financialYearId` INTEGER, `name` TEXT, `startDate` TEXT, `endDate` TEXT, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `FinancialYear` (`name` TEXT, `startDate` TEXT, `endDate` TEXT, `isCurrentYear` INTEGER NOT NULL, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, `id` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ClosingBalance` (`id` INTEGER, `customerId` INTEGER, `fyId` INTEGER, `obAmount` REAL, `cbAmount` REAL, `created_by` INTEGER, `created_on` TEXT, `modified_by` INTEGER, `modified_on` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  LoginDao get loginDao {
    return _loginDaoInstance ??= _$LoginDao(database, changeListener);
  }

  @override
  CustomerDao get customerDao {
    return _customerDaoInstance ??= _$CustomerDao(database, changeListener);
  }

  @override
  CustomerAddressDao get customerAddressDao {
    return _customerAddressDaoInstance ??=
        _$CustomerAddressDao(database, changeListener);
  }

  @override
  CustomerTypeDao get customerTypeDao {
    return _customerTypeDaoInstance ??=
        _$CustomerTypeDao(database, changeListener);
  }

  @override
  StateDao get stateDao {
    return _stateDaoInstance ??= _$StateDao(database, changeListener);
  }

  @override
  RouteDao get routeDao {
    return _routeDaoInstance ??= _$RouteDao(database, changeListener);
  }

  @override
  ProductDao get productDao {
    return _productDaoInstance ??= _$ProductDao(database, changeListener);
  }

  @override
  DistrictDao get districtDao {
    return _districtDaoInstance ??= _$DistrictDao(database, changeListener);
  }

  @override
  DistributionDao get distributionDao {
    return _distributionDaoInstance ??=
        _$DistributionDao(database, changeListener);
  }

  @override
  UoMDao get uomDao {
    return _uomDaoInstance ??= _$UoMDao(database, changeListener);
  }

  @override
  WarehouseDao get warehouseDao {
    return _warehouseDaoInstance ??= _$WarehouseDao(database, changeListener);
  }

  @override
  VisitPartnerDao get visitPartnerDao {
    return _visitPartnerDaoInstance ??=
        _$VisitPartnerDao(database, changeListener);
  }

  @override
  ProductGroupDao get productGroupDao {
    return _productGroupDaoInstance ??=
        _$ProductGroupDao(database, changeListener);
  }

  @override
  ProductPricingDao get productPricingDao {
    return _productPricingDaoInstance ??=
        _$ProductPricingDao(database, changeListener);
  }

  @override
  ProductCategoryDao get productCategoryDao {
    return _productCategoryDaoInstance ??=
        _$ProductCategoryDao(database, changeListener);
  }

  @override
  SchemeDao get schemeDao {
    return _schemeDaoInstance ??= _$SchemeDao(database, changeListener);
  }

  @override
  UserRoleRightsDao get userRoleRightsDao {
    return _userRoleRightsDaoInstance ??=
        _$UserRoleRightsDao(database, changeListener);
  }

  @override
  VisitDetailDao get visitDetailDao {
    return _visitDetailDaoInstance ??=
        _$VisitDetailDao(database, changeListener);
  }

  @override
  ProductSchemeDao get productSchemeDao {
    return _productSchemeDaoInstance ??=
        _$ProductSchemeDao(database, changeListener);
  }

  @override
  ImageFolderDao get imageFolderDao {
    return _imageFolderDaoInstance ??=
        _$ImageFolderDao(database, changeListener);
  }

  @override
  CartDao get cartDao {
    return _cartDaoInstance ??= _$CartDao(database, changeListener);
  }

  @override
  OrderRecordDao get orderRecordDao {
    return _orderRecordDaoInstance ??=
        _$OrderRecordDao(database, changeListener);
  }

  @override
  OrderItemDao get orderItemDao {
    return _orderItemDaoInstance ??= _$OrderItemDao(database, changeListener);
  }

  @override
  VisitOrderMappingDao get visitOrderMappingDao {
    return _visitOrderMappingDaoInstance ??=
        _$VisitOrderMappingDao(database, changeListener);
  }

  @override
  ProductTrendDao get productTrendsDao {
    return _productTrendsDaoInstance ??=
        _$ProductTrendDao(database, changeListener);
  }

  @override
  ProductTrendsLocationDao get productTrendsLocationDao {
    return _productTrendsLocationDaoInstance ??=
        _$ProductTrendsLocationDao(database, changeListener);
  }

  @override
  CustomerCategoryDao get customerCategoryDao {
    return _customerCategoryDaoInstance ??=
        _$CustomerCategoryDao(database, changeListener);
  }

  @override
  LocationDao get locationDao {
    return _locationDaoInstance ??= _$LocationDao(database, changeListener);
  }

  @override
  CountryDao get countryDao {
    return _countryDaoInstance ??= _$CountryDao(database, changeListener);
  }

  @override
  CustomerImageDao get customerImageDao {
    return _customerImageDaoInstance ??=
        _$CustomerImageDao(database, changeListener);
  }

  @override
  NoOrderTypeDao get noOrderTypeDio {
    return _noOrderTypeDioInstance ??=
        _$NoOrderTypeDao(database, changeListener);
  }

  @override
  NoOrderDao get noOrderDao {
    return _noOrderDaoInstance ??= _$NoOrderDao(database, changeListener);
  }

  @override
  SalesReturnDao get salesReturnDao {
    return _salesReturnDaoInstance ??=
        _$SalesReturnDao(database, changeListener);
  }

  @override
  InvoiceMappingDao get invoiceMappingDao {
    return _invoiceMappingDaoInstance ??=
        _$InvoiceMappingDao(database, changeListener);
  }

  @override
  InvoiceItemDao get invoiceItemDao {
    return _invoiceItemDaoInstance ??=
        _$InvoiceItemDao(database, changeListener);
  }

  @override
  SalesReturnReasonDao get salesReturnReasonDao {
    return _salesReturnReasonDaoInstance ??=
        _$SalesReturnReasonDao(database, changeListener);
  }

  @override
  LeaveDao get leaveDao {
    return _leaveDaoInstance ??= _$LeaveDao(database, changeListener);
  }

  @override
  AttendanceDao get attendanceDao {
    return _attendanceDaoInstance ??= _$AttendanceDao(database, changeListener);
  }

  @override
  AttendanceDetailDao get attendanceDetailDao {
    return _attendanceDetailDaoInstance ??=
        _$AttendanceDetailDao(database, changeListener);
  }

  @override
  ActivityRegisterTypeDao get activityRegisterTypeDao {
    return _activityRegisterTypeDaoInstance ??=
        _$ActivityRegisterTypeDao(database, changeListener);
  }

  @override
  ActivityRegisteredDao get activityRegisteredDao {
    return _activityRegisteredDaoInstance ??=
        _$ActivityRegisteredDao(database, changeListener);
  }

  @override
  InvoiceStatementDao get invoiceStatementDao {
    return _invoiceStatementDaoInstance ??=
        _$InvoiceStatementDao(database, changeListener);
  }

  @override
  JourneyCycleDao get journeyCycleDao {
    return _journeyCycleDaoInstance ??=
        _$JourneyCycleDao(database, changeListener);
  }

  @override
  FinancialYearDao get financialYearDao {
    return _financialYearDaoInstance ??=
        _$FinancialYearDao(database, changeListener);
  }

  @override
  ClosingBalanceDao get closingBalanceDao {
    return _closingBalanceDaoInstance ??=
        _$ClosingBalanceDao(database, changeListener);
  }
}

class _$LoginDao extends LoginDao {
  _$LoginDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _loginDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'LoginDataResponse',
            (LoginDataResponse item) => <String, Object?>{
                  'full_name': item.fullName,
                  'email': item.email,
                  'jwtToken': item.jwtToken,
                  'refreshToken': item.refreshToken,
                  'image': item.image,
                  'user_id': item.userId,
                  'isAdmin':
                      item.isAdmin == null ? null : (item.isAdmin! ? 1 : 0),
                  'userRoleName': item.userRoleName,
                  'pin_hash': item.pinHash
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LoginDataResponse> _loginDataResponseInsertionAdapter;

  @override
  Future<LoginDataResponse?> getLoginData() async {
    return _queryAdapter.query('Select * From LoginDataResponse',
        mapper: (Map<String, Object?> row) => LoginDataResponse(
            fullName: row['full_name'] as String?,
            email: row['email'] as String?,
            jwtToken: row['jwtToken'] as String?,
            refreshToken: row['refreshToken'] as String?,
            image: row['image'] as String?,
            userId: row['user_id'] as int?,
            isAdmin:
                row['isAdmin'] == null ? null : (row['isAdmin'] as int) != 0,
            userRoleName: row['userRoleName'] as String?,
            pinHash: row['pin_hash'] as String?));
  }

  @override
  Future<LoginDataResponse?> getPinHashData() async {
    return _queryAdapter.query('Select pin_hash From LoginDataResponse',
        mapper: (Map<String, Object?> row) => LoginDataResponse(
            fullName: row['full_name'] as String?,
            email: row['email'] as String?,
            jwtToken: row['jwtToken'] as String?,
            refreshToken: row['refreshToken'] as String?,
            image: row['image'] as String?,
            userId: row['user_id'] as int?,
            isAdmin:
                row['isAdmin'] == null ? null : (row['isAdmin'] as int) != 0,
            userRoleName: row['userRoleName'] as String?,
            pinHash: row['pin_hash'] as String?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from LoginDataResponse where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertLoginData(LoginDataResponse loginUserData) async {
    await _loginDataResponseInsertionAdapter.insert(
        loginUserData, OnConflictStrategy.replace);
  }
}

class _$CustomerDao extends CustomerDao {
  _$CustomerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _customerDataItemsResponseInsertionAdapter = InsertionAdapter(
            database,
            'customer',
            (CustomerDataItemsResponse item) => <String, Object?>{
                  'id': item.id,
                  'isSync': item.isSync,
                  'contact_person_name': item.contactPersonName,
                  'business_name': item.businessName,
                  'mobile_number': item.mobileNumber,
                  'email_address': item.emailAddress,
                  'pin_code': item.pincode,
                  'gst_in': item.gstin,
                  'route_id': item.routeId,
                  'route_name': item.routeName,
                  'customer_type': item.customerType,
                  'customer_type_name': item.customerTypeName,
                  'is_active':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0),
                  'distributorId_1': item.distributorId_1,
                  'distributorId_2': item.distributorId_2,
                  'distributorId_3': item.distributorId_3,
                  'customer_category': item.customerCategory,
                  'customer_category_name': item.customerCategoryName,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'is_system_generated': item.isSystemGenerated == null
                      ? null
                      : (item.isSystemGenerated! ? 1 : 0),
                  'modified_on': item.modifiedOn,
                  'modified_by': item.modifiedBy
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CustomerDataItemsResponse>
      _customerDataItemsResponseInsertionAdapter;

  @override
  Future<List<CustomerDataItemsResponse>> getCustomerData() async {
    return _queryAdapter.queryList('Select * From customer',
        mapper: (Map<String, Object?> row) => CustomerDataItemsResponse(
            id: row['id'] as int?,
            isSync: row['isSync'] as int?,
            contactPersonName: row['contact_person_name'] as String?,
            businessName: row['business_name'] as String?,
            mobileNumber: row['mobile_number'] as String?,
            emailAddress: row['email_address'] as String?,
            pincode: row['pin_code'] as int?,
            gstin: row['gst_in'] as String?,
            routeId: row['route_id'] as int?,
            routeName: row['route_name'] as String?,
            customerType: row['customer_type'] as int?,
            customerTypeName: row['customer_type_name'] as String?,
            isActive: row['is_active'] == null
                ? null
                : (row['is_active'] as int) != 0,
            distributorId_1: row['distributorId_1'] as int?,
            distributorId_2: row['distributorId_2'] as int?,
            distributorId_3: row['distributorId_3'] as int?,
            customerCategory: row['customer_category'] as int?,
            customerCategoryName: row['customer_category_name'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            isSystemGenerated: row['is_system_generated'] == null
                ? null
                : (row['is_system_generated'] as int) != 0,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<List<CustomerDataItemsResponse>> getCustomerDataBasedOnRouteId(
      int id) async {
    return _queryAdapter.queryList('Select * From customer where route_id = ?1',
        mapper: (Map<String, Object?> row) => CustomerDataItemsResponse(
            id: row['id'] as int?,
            isSync: row['isSync'] as int?,
            contactPersonName: row['contact_person_name'] as String?,
            businessName: row['business_name'] as String?,
            mobileNumber: row['mobile_number'] as String?,
            emailAddress: row['email_address'] as String?,
            pincode: row['pin_code'] as int?,
            gstin: row['gst_in'] as String?,
            routeId: row['route_id'] as int?,
            routeName: row['route_name'] as String?,
            customerType: row['customer_type'] as int?,
            customerTypeName: row['customer_type_name'] as String?,
            isActive: row['is_active'] == null
                ? null
                : (row['is_active'] as int) != 0,
            distributorId_1: row['distributorId_1'] as int?,
            distributorId_2: row['distributorId_2'] as int?,
            distributorId_3: row['distributorId_3'] as int?,
            customerCategory: row['customer_category'] as int?,
            customerCategoryName: row['customer_category_name'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            isSystemGenerated: row['is_system_generated'] == null
                ? null
                : (row['is_system_generated'] as int) != 0,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?),
        arguments: [id]);
  }

  @override
  Future<CustomerDataItemsResponse?> getCustomerDataBasedOnId(int id) async {
    return _queryAdapter.query('Select * From customer where id = ?1',
        mapper: (Map<String, Object?> row) => CustomerDataItemsResponse(
            id: row['id'] as int?,
            isSync: row['isSync'] as int?,
            contactPersonName: row['contact_person_name'] as String?,
            businessName: row['business_name'] as String?,
            mobileNumber: row['mobile_number'] as String?,
            emailAddress: row['email_address'] as String?,
            pincode: row['pin_code'] as int?,
            gstin: row['gst_in'] as String?,
            routeId: row['route_id'] as int?,
            routeName: row['route_name'] as String?,
            customerType: row['customer_type'] as int?,
            customerTypeName: row['customer_type_name'] as String?,
            isActive: row['is_active'] == null
                ? null
                : (row['is_active'] as int) != 0,
            distributorId_1: row['distributorId_1'] as int?,
            distributorId_2: row['distributorId_2'] as int?,
            distributorId_3: row['distributorId_3'] as int?,
            customerCategory: row['customer_category'] as int?,
            customerCategoryName: row['customer_category_name'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            isSystemGenerated: row['is_system_generated'] == null
                ? null
                : (row['is_system_generated'] as int) != 0,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from customer where id = ?1', arguments: [id]);
  }

  @override
  Future<int?> getCountOfTotalCustomers() async {
    await _queryAdapter.queryNoReturn('select COUNT(*) from customer');
  }

  @override
  Future<void> insertCustomerData(
      CustomerDataItemsResponse customerData) async {
    await _customerDataItemsResponseInsertionAdapter.insert(
        customerData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<CustomerDataItemsResponse> customerDataList) async {
    await _customerDataItemsResponseInsertionAdapter.insertList(
        customerDataList, OnConflictStrategy.replace);
  }
}

class _$CustomerAddressDao extends CustomerAddressDao {
  _$CustomerAddressDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _customerAddressResponseInsertionAdapter = InsertionAdapter(
            database,
            'CustomerAddress',
            (CustomerAddressResponse item) => <String, Object?>{
                  'id': item.id,
                  'customerId': item.customerId,
                  'pincode': item.pincode,
                  'contactPersonName': item.contactPersonName,
                  'countryId': item.countryId,
                  'stateId': item.stateId,
                  'districtId': item.districtId,
                  'locationId': item.locationId,
                  'fullAddress': item.fullAddress,
                  'isDefaultAddress': item.isDefaultAddress == null
                      ? null
                      : (item.isDefaultAddress! ? 1 : 0),
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'isActive':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0),
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_On': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CustomerAddressResponse>
      _customerAddressResponseInsertionAdapter;

  @override
  Future<List<CustomerAddressResponse>?> getAllData(int id) async {
    return _queryAdapter.queryList(
        'Select * From CustomerAddress where customerId = ?1',
        mapper: (Map<String, Object?> row) => CustomerAddressResponse(
            id: row['id'] as int?,
            customerId: row['customerId'] as int?,
            pincode: row['pincode'] as String?,
            contactPersonName: row['contactPersonName'] as String?,
            countryId: row['countryId'] as int?,
            stateId: row['stateId'] as int?,
            districtId: row['districtId'] as int?,
            locationId: row['locationId'] as int?,
            fullAddress: row['fullAddress'] as String?,
            isDefaultAddress: row['isDefaultAddress'] == null
                ? null
                : (row['isDefaultAddress'] as int) != 0,
            latitude: row['latitude'] as String?,
            isActive:
                row['isActive'] == null ? null : (row['isActive'] as int) != 0,
            longitude: row['longitude'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_On'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from CustomerAddress where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertCustomerAddressData(
      List<CustomerAddressResponse> customerAddressData) async {
    await _customerAddressResponseInsertionAdapter.insertList(
        customerAddressData, OnConflictStrategy.replace);
  }
}

class _$CustomerTypeDao extends CustomerTypeDao {
  _$CustomerTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _customerTypeDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'CustomerType',
            (CustomerTypeDataResponse item) => <String, Object?>{
                  'id': item.id,
                  'subscriber_id': item.subscriberId,
                  'type_name': item.typeName,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CustomerTypeDataResponse>
      _customerTypeDataResponseInsertionAdapter;

  @override
  Future<List<CustomerTypeDataResponse>?> getCustomerData() async {
    return _queryAdapter.queryList('Select * From CustomerType',
        mapper: (Map<String, Object?> row) => CustomerTypeDataResponse(
            row['id'] as int?,
            row['subscriber_id'] as int?,
            row['type_name'] as String?,
            row['created_by'] as int?,
            row['created_on'] as String?,
            row['modified_by'] as int?,
            row['modified_on'] as String?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from CustomerType where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertCustomerData(CustomerTypeDataResponse customerData) async {
    await _customerTypeDataResponseInsertionAdapter.insert(
        customerData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<CustomerTypeDataResponse> customerDataList) async {
    await _customerTypeDataResponseInsertionAdapter.insertList(
        customerDataList, OnConflictStrategy.replace);
  }
}

class _$StateDao extends StateDao {
  _$StateDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _stateDataItemResponseInsertionAdapter = InsertionAdapter(
            database,
            'StateData',
            (StateDataItemResponse item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'name': item.name,
                  'country_id': item.countryId,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<StateDataItemResponse>
      _stateDataItemResponseInsertionAdapter;

  @override
  Future<StateDataItemResponse?> getStateData() async {
    return _queryAdapter.query('Select * From StateData',
        mapper: (Map<String, Object?> row) => StateDataItemResponse(
            row['id'] as int?,
            row['code'] as String?,
            row['name'] as String?,
            row['country_id'] as int?,
            row['created_by'] as int?,
            row['created_on'] as String?,
            row['modified_by'] as int?,
            row['modified_on'] as String?));
  }

  @override
  Future<List<StateDataItemResponse>?> getStatesBasedOnCountryId(int id) async {
    return _queryAdapter.queryList(
        'Select * From StateData where country_id = ?1',
        mapper: (Map<String, Object?> row) => StateDataItemResponse(
            row['id'] as int?,
            row['code'] as String?,
            row['name'] as String?,
            row['country_id'] as int?,
            row['created_by'] as int?,
            row['created_on'] as String?,
            row['modified_by'] as int?,
            row['modified_on'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from StateData where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertStateData(StateDataItemResponse stateData) async {
    await _stateDataItemResponseInsertionAdapter.insert(
        stateData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<StateDataItemResponse> stateList) async {
    await _stateDataItemResponseInsertionAdapter.insertList(
        stateList, OnConflictStrategy.replace);
  }
}

class _$RouteDao extends RouteDao {
  _$RouteDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _routeItemsInsertionAdapter = InsertionAdapter(
            database,
            'route',
            (RouteItems item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'subscriber_id': item.subscriberId,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RouteItems> _routeItemsInsertionAdapter;

  @override
  Future<List<RouteItems>> getAllData() async {
    return _queryAdapter.queryList('Select * From route',
        mapper: (Map<String, Object?> row) => RouteItems(
            id: row['id'] as int?,
            name: row['name'] as String?,
            status: row['status'] as int?,
            subscriberId: row['subscriber_id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from route where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertRouteData(RouteItems routeData) async {
    await _routeItemsInsertionAdapter.insert(
        routeData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<RouteItems> routeDataList) async {
    await _routeItemsInsertionAdapter.insertList(
        routeDataList, OnConflictStrategy.replace);
  }
}

class _$ProductDao extends ProductDao {
  _$ProductDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productListDataItemsResponseInsertionAdapter = InsertionAdapter(
            database,
            'productList',
            (ProductListDataItemsResponse item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'product_code': item.productCode,
                  'group_id': item.groupId,
                  'sub_group_id': item.subGroupId,
                  'category_id': item.categoryId,
                  'sub_category_id': item.subCategoryId,
                  'uom': item.uom,
                  'uom_1': item.uoM1,
                  'uom_2': item.uoM2,
                  'uom_3': item.uoM3,
                  'uom_4': item.uoM4,
                  'subscriber_id': item.subscriberId,
                  'uom_2_value': item.uoM2Value,
                  'uom_3_value': item.uoM3Value,
                  'is_sellable_uom1': item.isSellableUoM1 == null
                      ? null
                      : (item.isSellableUoM1! ? 1 : 0),
                  'is_sellable_uom2': item.isSellableUoM2 == null
                      ? null
                      : (item.isSellableUoM2! ? 1 : 0),
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductListDataItemsResponse>
      _productListDataItemsResponseInsertionAdapter;

  @override
  Future<List<ProductListDataItemsResponse>> getAllData() async {
    return _queryAdapter.queryList('Select * From productList',
        mapper: (Map<String, Object?> row) => ProductListDataItemsResponse(
            id: row['id'] as int?,
            name: row['name'] as String?,
            productCode: row['product_code'] as String?,
            groupId: row['group_id'] as int?,
            subGroupId: row['sub_group_id'] as int?,
            categoryId: row['category_id'] as int?,
            subCategoryId: row['sub_category_id'] as int?,
            uom: row['uom'] as int?,
            uoM1: row['uom_1'] as int?,
            uoM2: row['uom_2'] as int?,
            uoM3: row['uom_3'] as int?,
            uoM4: row['uom_4'] as int?,
            subscriberId: row['subscriber_id'] as int?,
            uoM2Value: row['uom_2_value'] as int?,
            uoM3Value: row['uom_3_value'] as int?,
            isSellableUoM1: row['is_sellable_uom1'] == null
                ? null
                : (row['is_sellable_uom1'] as int) != 0,
            isSellableUoM2: row['is_sellable_uom2'] == null
                ? null
                : (row['is_sellable_uom2'] as int) != 0,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<ProductListDataItemsResponse?> getProductBasedOnId(int id) async {
    return _queryAdapter.query('Select * From productList where id =?1',
        mapper: (Map<String, Object?> row) => ProductListDataItemsResponse(
            id: row['id'] as int?,
            name: row['name'] as String?,
            productCode: row['product_code'] as String?,
            groupId: row['group_id'] as int?,
            subGroupId: row['sub_group_id'] as int?,
            categoryId: row['category_id'] as int?,
            subCategoryId: row['sub_category_id'] as int?,
            uom: row['uom'] as int?,
            uoM1: row['uom_1'] as int?,
            uoM2: row['uom_2'] as int?,
            uoM3: row['uom_3'] as int?,
            uoM4: row['uom_4'] as int?,
            subscriberId: row['subscriber_id'] as int?,
            uoM2Value: row['uom_2_value'] as int?,
            uoM3Value: row['uom_3_value'] as int?,
            isSellableUoM1: row['is_sellable_uom1'] == null
                ? null
                : (row['is_sellable_uom1'] as int) != 0,
            isSellableUoM2: row['is_sellable_uom2'] == null
                ? null
                : (row['is_sellable_uom2'] as int) != 0,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from productList where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertProductData(
      ProductListDataItemsResponse productData) async {
    await _productListDataItemsResponseInsertionAdapter.insert(
        productData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<ProductListDataItemsResponse> productList) async {
    await _productListDataItemsResponseInsertionAdapter.insertList(
        productList, OnConflictStrategy.replace);
  }
}

class _$DistrictDao extends DistrictDao {
  _$DistrictDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _districtItemsInsertionAdapter = InsertionAdapter(
            database,
            'district',
            (DistrictItems item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'state_id': item.stateId,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DistrictItems> _districtItemsInsertionAdapter;

  @override
  Future<DistrictItems?> getAllData() async {
    return _queryAdapter.query('Select * From district',
        mapper: (Map<String, Object?> row) => DistrictItems(
            name: row['name'] as String?,
            stateId: row['state_id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<List<DistrictItems>?> getDistrictBasedOnStateId(int id) async {
    return _queryAdapter.queryList('Select * From district where state_id = ?1',
        mapper: (Map<String, Object?> row) => DistrictItems(
            name: row['name'] as String?,
            stateId: row['state_id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from district where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertDistrictData(DistrictItems districtData) async {
    await _districtItemsInsertionAdapter.insert(
        districtData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<DistrictItems> districtDataList) async {
    await _districtItemsInsertionAdapter.insertList(
        districtDataList, OnConflictStrategy.replace);
  }
}

class _$DistributionDao extends DistributionDao {
  _$DistributionDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _distributionDataInsertionAdapter = InsertionAdapter(
            database,
            'Distribution',
            (DistributionData item) => <String, Object?>{
                  'business_name': item.businessName,
                  'contact_person_name': item.contactPersonName,
                  'mobile_number': item.mobileNumber,
                  'email_id': item.emailId,
                  'gst_number': item.gstNumber,
                  'location_id': item.locationId,
                  'state_id': item.stateId,
                  'tenant_id': item.tenantId,
                  'type': item.type,
                  'full_address': item.fullAddress,
                  'pin_code': item.pincode,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DistributionData> _distributionDataInsertionAdapter;

  @override
  Future<List<DistributionData>> getDistributionData() async {
    return _queryAdapter.queryList('Select * From Distribution',
        mapper: (Map<String, Object?> row) => DistributionData(
            businessName: row['business_name'] as String?,
            contactPersonName: row['contact_person_name'] as String?,
            mobileNumber: row['mobile_number'] as String?,
            emailId: row['email_id'] as String?,
            gstNumber: row['gst_number'] as String?,
            locationId: row['location_id'] as int?,
            stateId: row['state_id'] as int?,
            tenantId: row['tenant_id'] as int?,
            type: row['type'] as int?,
            fullAddress: row['full_address'] as String?,
            pincode: row['pin_code'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<DistributionData?> getDistributionObject(int id) async {
    return _queryAdapter.query('Select * From Distribution where id = ?1',
        mapper: (Map<String, Object?> row) => DistributionData(
            businessName: row['business_name'] as String?,
            contactPersonName: row['contact_person_name'] as String?,
            mobileNumber: row['mobile_number'] as String?,
            emailId: row['email_id'] as String?,
            gstNumber: row['gst_number'] as String?,
            locationId: row['location_id'] as int?,
            stateId: row['state_id'] as int?,
            tenantId: row['tenant_id'] as int?,
            type: row['type'] as int?,
            fullAddress: row['full_address'] as String?,
            pincode: row['pin_code'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<DistributionData?> getMultipleDistributionObject(
      int id1, int id2, int id3) async {
    return _queryAdapter.query(
        'Select * From Distribution where id in (?1, ?2, ?3)',
        mapper: (Map<String, Object?> row) => DistributionData(
            businessName: row['business_name'] as String?,
            contactPersonName: row['contact_person_name'] as String?,
            mobileNumber: row['mobile_number'] as String?,
            emailId: row['email_id'] as String?,
            gstNumber: row['gst_number'] as String?,
            locationId: row['location_id'] as int?,
            stateId: row['state_id'] as int?,
            tenantId: row['tenant_id'] as int?,
            type: row['type'] as int?,
            fullAddress: row['full_address'] as String?,
            pincode: row['pin_code'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?),
        arguments: [id1, id2, id3]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from Distribution where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertStateData(DistributionData distributionData) async {
    await _distributionDataInsertionAdapter.insert(
        distributionData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<DistributionData> distributionList) async {
    await _distributionDataInsertionAdapter.insertList(
        distributionList, OnConflictStrategy.replace);
  }
}

class _$UoMDao extends UoMDao {
  _$UoMDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _uOMDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'UnitOfMeasure',
            (UOMDataResponse item) => <String, Object?>{
                  'id': item.id,
                  'uom_name': item.uoMName,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UOMDataResponse> _uOMDataResponseInsertionAdapter;

  @override
  Future<List<UOMDataResponse>> getUoMData() async {
    return _queryAdapter.queryList('Select * From UnitOfMeasure',
        mapper: (Map<String, Object?> row) => UOMDataResponse(
            id: row['id'] as int?,
            uoMName: row['uom_name'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<UOMDataResponse?> getUoMBasedOnId(int id) async {
    return _queryAdapter.query('Select * From UnitOfMeasure where id = ?1',
        mapper: (Map<String, Object?> row) => UOMDataResponse(
            id: row['id'] as int?,
            uoMName: row['uom_name'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from UnitOfMeasure where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertUoMData(UOMDataResponse uoMData) async {
    await _uOMDataResponseInsertionAdapter.insert(
        uoMData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<UOMDataResponse> uoMList) async {
    await _uOMDataResponseInsertionAdapter.insertList(
        uoMList, OnConflictStrategy.replace);
  }
}

class _$WarehouseDao extends WarehouseDao {
  _$WarehouseDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _warehouseDataItemsResponseInsertionAdapter = InsertionAdapter(
            database,
            'Warehouse',
            (WarehouseDataItemsResponse item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'location_id': item.locationId,
                  'distributor_id': item.distributorId,
                  'subscriber_id': item.subscriberId,
                  'last_damage_updated_on': item.lastDamageUpdatedOn,
                  'last_expiry_updated_on': item.lastExpiryUpdatedOn,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<WarehouseDataItemsResponse>
      _warehouseDataItemsResponseInsertionAdapter;

  @override
  Future<List<WarehouseDataItemsResponse>> getWarehouseData() async {
    return _queryAdapter.queryList('Select * From Warehouse',
        mapper: (Map<String, Object?> row) => WarehouseDataItemsResponse(
            id: row['id'] as int,
            name: row['name'] as String?,
            locationId: row['location_id'] as int?,
            distributorId: row['distributor_id'] as int?,
            subscriberId: row['subscriber_id'] as int?,
            lastDamageUpdatedOn: row['last_damage_updated_on'] as String?,
            lastExpiryUpdatedOn: row['last_expiry_updated_on'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<List<WarehouseDataItemsResponse>> getWarehouseDataBasedOnDistributor(
      int distributorId) async {
    return _queryAdapter.queryList(
        'Select * From Warehouse where distributor_id = ?1',
        mapper: (Map<String, Object?> row) => WarehouseDataItemsResponse(
            id: row['id'] as int,
            name: row['name'] as String?,
            locationId: row['location_id'] as int?,
            distributorId: row['distributor_id'] as int?,
            subscriberId: row['subscriber_id'] as int?,
            lastDamageUpdatedOn: row['last_damage_updated_on'] as String?,
            lastExpiryUpdatedOn: row['last_expiry_updated_on'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?),
        arguments: [distributorId]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from Warehouse where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertWarehouseData(
      WarehouseDataItemsResponse warehouseData) async {
    await _warehouseDataItemsResponseInsertionAdapter.insert(
        warehouseData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<WarehouseDataItemsResponse> warehouseList) async {
    await _warehouseDataItemsResponseInsertionAdapter.insertList(
        warehouseList, OnConflictStrategy.replace);
  }
}

class _$VisitPartnerDao extends VisitPartnerDao {
  _$VisitPartnerDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _visitPartnersDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'VisitPartner',
            (VisitPartnersDataResponse item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'created_on': item.createdOn,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VisitPartnersDataResponse>
      _visitPartnersDataResponseInsertionAdapter;

  @override
  Future<List<VisitPartnersDataResponse>> getAllData() async {
    return _queryAdapter.queryList('Select * From VisitPartner',
        mapper: (Map<String, Object?> row) => VisitPartnersDataResponse(
            id: row['id'] as int,
            name: row['name'] as String,
            createdOn: row['created_on'] as String?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from VisitPartner where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertVisitPartnerData(
      VisitPartnersDataResponse visitPartnerData) async {
    await _visitPartnersDataResponseInsertionAdapter.insert(
        visitPartnerData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<VisitPartnersDataResponse> visitPartnerList) async {
    await _visitPartnersDataResponseInsertionAdapter.insertList(
        visitPartnerList, OnConflictStrategy.replace);
  }
}

class _$ProductGroupDao extends ProductGroupDao {
  _$ProductGroupDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productGroupItemsInsertionAdapter = InsertionAdapter(
            database,
            'ProductGroup',
            (ProductGroupItems item) => <String, Object?>{
                  'name': item.name,
                  'group_id': item.groupId,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductGroupItems> _productGroupItemsInsertionAdapter;

  @override
  Future<List<ProductGroupItems>?> getAllData() async {
    return _queryAdapter.queryList('Select * From ProductGroup',
        mapper: (Map<String, Object?> row) => ProductGroupItems(
            name: row['name'] as String?,
            groupId: row['group_id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<List<ProductGroupItems>?> getParentGroupData() async {
    return _queryAdapter.queryList(
        'Select * From ProductGroup where group_id is null',
        mapper: (Map<String, Object?> row) => ProductGroupItems(
            name: row['name'] as String?,
            groupId: row['group_id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<List<ProductGroupItems>?> getSubGroupData(int id) async {
    return _queryAdapter.queryList(
        'Select * From ProductGroup where group_id = ?1',
        mapper: (Map<String, Object?> row) => ProductGroupItems(
            name: row['name'] as String?,
            groupId: row['group_id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from ProductGroup where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertProductGroupData(
      ProductGroupItems productGroupData) async {
    await _productGroupItemsInsertionAdapter.insert(
        productGroupData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<ProductGroupItems> productGroupList) async {
    await _productGroupItemsInsertionAdapter.insertList(
        productGroupList, OnConflictStrategy.replace);
  }
}

class _$ProductPricingDao extends ProductPricingDao {
  _$ProductPricingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productPricingItemsInsertionAdapter = InsertionAdapter(
            database,
            'productPricing',
            (ProductPricingItems item) => <String, Object?>{
                  'subscriber_id': item.subscriberId,
                  'product_id': item.productId,
                  'pricing_type': item.pricingType,
                  'hsn': item.hsn,
                  'cgst': item.cgst,
                  'sgst': item.sgst,
                  'igst': item.igst,
                  'mrp': item.mrp,
                  'min_base_price': item.minBasePrice,
                  'max_base_price': item.maxBasePrice,
                  'state_id': item.stateId,
                  'distributor_id': item.distributorId,
                  'distributor_type': item.distributorType,
                  'customer_id': item.customerId,
                  'customer_type': item.customerType,
                  'customer_category': item.customerCategory,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn,
                  'id': item.id,
                  'uoM': item.uoM
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductPricingItems>
      _productPricingItemsInsertionAdapter;

  @override
  Future<List<ProductPricingItems>> getAllData() async {
    return _queryAdapter.queryList('Select * From productPricing',
        mapper: (Map<String, Object?> row) => ProductPricingItems(
            subscriberId: row['subscriber_id'] as int?,
            productId: row['product_id'] as int?,
            pricingType: row['pricing_type'] as int?,
            hsn: row['hsn'] as String?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            cgst: row['cgst'] as double?,
            id: row['id'] as int?,
            mrp: row['mrp'] as double?,
            minBasePrice: row['min_base_price'] as double?,
            maxBasePrice: row['max_base_price'] as double?,
            stateId: row['state_id'] as int?,
            distributorId: row['distributor_id'] as int?,
            distributorType: row['distributor_type'] as int?,
            customerId: row['customer_id'] as int?,
            customerType: row['customer_type'] as int?,
            customerCategory: row['customer_category'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            uoM: row['uoM'] as int?));
  }

  @override
  Future<List<ProductPricingItems>> getAllDataBasedOnProductId(int id) async {
    return _queryAdapter.queryList(
        'Select * From productPricing where product_id = ?1',
        mapper: (Map<String, Object?> row) => ProductPricingItems(
            subscriberId: row['subscriber_id'] as int?,
            productId: row['product_id'] as int?,
            pricingType: row['pricing_type'] as int?,
            hsn: row['hsn'] as String?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            cgst: row['cgst'] as double?,
            id: row['id'] as int?,
            mrp: row['mrp'] as double?,
            minBasePrice: row['min_base_price'] as double?,
            maxBasePrice: row['max_base_price'] as double?,
            stateId: row['state_id'] as int?,
            distributorId: row['distributor_id'] as int?,
            distributorType: row['distributor_type'] as int?,
            customerId: row['customer_id'] as int?,
            customerType: row['customer_type'] as int?,
            customerCategory: row['customer_category'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            uoM: row['uoM'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from productPricing where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertProductGroupData(
      ProductPricingItems productPricingData) async {
    await _productPricingItemsInsertionAdapter.insert(
        productPricingData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<ProductPricingItems> productPricingList) async {
    await _productPricingItemsInsertionAdapter.insertList(
        productPricingList, OnConflictStrategy.replace);
  }
}

class _$ProductCategoryDao extends ProductCategoryDao {
  _$ProductCategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productCategoryListDataItemsResponseInsertionAdapter =
            InsertionAdapter(
                database,
                'ProductCategory',
                (ProductCategoryListDataItemsResponse item) =>
                    <String, Object?>{
                      'name': item.name,
                      'category_id': item.categoryId,
                      'created_by': item.createdBy,
                      'created_on': item.createdOn,
                      'modified_by': item.modifiedBy,
                      'modified_on': item.modifiedOn,
                      'id': item.id
                    });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductCategoryListDataItemsResponse>
      _productCategoryListDataItemsResponseInsertionAdapter;

  @override
  Future<List<ProductCategoryListDataItemsResponse>> getAllData() async {
    return _queryAdapter.queryList('Select * From ProductCategory',
        mapper: (Map<String, Object?> row) =>
            ProductCategoryListDataItemsResponse(
                name: row['name'] as String?,
                categoryId: row['category_id'] as int?,
                createdBy: row['created_by'] as int?,
                createdOn: row['created_on'] as String?,
                modifiedBy: row['modified_by'] as int?,
                modifiedOn: row['modified_on'] as String?,
                id: row['id'] as int?));
  }

  @override
  Future<List<ProductCategoryListDataItemsResponse>?>
      getParentCategoryData() async {
    return _queryAdapter.queryList(
        'Select * From ProductCategory where category_id is null',
        mapper: (Map<String, Object?> row) =>
            ProductCategoryListDataItemsResponse(
                name: row['name'] as String?,
                categoryId: row['category_id'] as int?,
                createdBy: row['created_by'] as int?,
                createdOn: row['created_on'] as String?,
                modifiedBy: row['modified_by'] as int?,
                modifiedOn: row['modified_on'] as String?,
                id: row['id'] as int?));
  }

  @override
  Future<List<ProductCategoryListDataItemsResponse>?> getSubCategoryData(
      int id) async {
    return _queryAdapter.queryList(
        'Select * From ProductCategory where category_id = ?1',
        mapper: (Map<String, Object?> row) =>
            ProductCategoryListDataItemsResponse(
                name: row['name'] as String?,
                categoryId: row['category_id'] as int?,
                createdBy: row['created_by'] as int?,
                createdOn: row['created_on'] as String?,
                modifiedBy: row['modified_by'] as int?,
                modifiedOn: row['modified_on'] as String?,
                id: row['id'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from ProductCategory where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertProductCategoryData(
      ProductCategoryListDataItemsResponse productCategoryData) async {
    await _productCategoryListDataItemsResponseInsertionAdapter.insert(
        productCategoryData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<ProductCategoryListDataItemsResponse> productCategoryList) async {
    await _productCategoryListDataItemsResponseInsertionAdapter.insertList(
        productCategoryList, OnConflictStrategy.replace);
  }
}

class _$SchemeDao extends SchemeDao {
  _$SchemeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _schemeListDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'Scheme',
            (SchemeListDataResponse item) => <String, Object?>{
                  'subscriberId': item.subscriberId,
                  'name': item.name,
                  'schemeType': item.schemeType,
                  'distributorId': item.distributorId,
                  'distributorType': item.distributorType,
                  'customerId': item.customerId,
                  'customerType': item.customerType,
                  'customerCategory': item.customerCategory,
                  'stateId': item.stateId,
                  'fyId': item.fyId,
                  'startDate': item.startDate,
                  'endDate': item.endDate,
                  'minTotalValue': item.minTotalValue,
                  'maxTotalValue': item.maxTotalValue,
                  'minOrderQnty': item.minOrderQnty,
                  'maxOrderQnty': item.maxOrderQnty,
                  'orderUOM': item.orderUOM,
                  'complementaryQntyPercent': item.complementaryQntyPercent,
                  'complementaryUOM': item.complementaryUOM,
                  'freeProductId': item.freeProductId,
                  'additionalDiscountPercent': item.additionalDiscountPercent,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SchemeListDataResponse>
      _schemeListDataResponseInsertionAdapter;

  @override
  Future<SchemeListDataResponse?> getAllData() async {
    return _queryAdapter.query('Select * From Scheme',
        mapper: (Map<String, Object?> row) => SchemeListDataResponse(
            subscriberId: row['subscriberId'] as int?,
            name: row['name'] as String?,
            schemeType: row['schemeType'] as int?,
            distributorId: row['distributorId'] as int?,
            distributorType: row['distributorType'] as int?,
            customerId: row['customerId'] as int?,
            customerType: row['customerType'] as int?,
            customerCategory: row['customerCategory'] as int?,
            stateId: row['stateId'] as int?,
            fyId: row['fyId'] as int?,
            startDate: row['startDate'] as String?,
            endDate: row['endDate'] as String?,
            minTotalValue: row['minTotalValue'] as double?,
            maxTotalValue: row['maxTotalValue'] as double?,
            minOrderQnty: row['minOrderQnty'] as double?,
            maxOrderQnty: row['maxOrderQnty'] as double?,
            orderUOM: row['orderUOM'] as int?,
            complementaryQntyPercent:
                row['complementaryQntyPercent'] as double?,
            complementaryUOM: row['complementaryUOM'] as int?,
            freeProductId: row['freeProductId'] as int?,
            additionalDiscountPercent:
                row['additionalDiscountPercent'] as double?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<List<SchemeListDataResponse>?> getSchemaList(int pId) async {
    return _queryAdapter.queryList(
        'select * from Scheme where id = (select scheme_id from ProductScheme WHERE product_id = ?1)',
        mapper: (Map<String, Object?> row) => SchemeListDataResponse(subscriberId: row['subscriberId'] as int?, name: row['name'] as String?, schemeType: row['schemeType'] as int?, distributorId: row['distributorId'] as int?, distributorType: row['distributorType'] as int?, customerId: row['customerId'] as int?, customerType: row['customerType'] as int?, customerCategory: row['customerCategory'] as int?, stateId: row['stateId'] as int?, fyId: row['fyId'] as int?, startDate: row['startDate'] as String?, endDate: row['endDate'] as String?, minTotalValue: row['minTotalValue'] as double?, maxTotalValue: row['maxTotalValue'] as double?, minOrderQnty: row['minOrderQnty'] as double?, maxOrderQnty: row['maxOrderQnty'] as double?, orderUOM: row['orderUOM'] as int?, complementaryQntyPercent: row['complementaryQntyPercent'] as double?, complementaryUOM: row['complementaryUOM'] as int?, freeProductId: row['freeProductId'] as int?, additionalDiscountPercent: row['additionalDiscountPercent'] as double?, created_by: row['created_by'] as int?, created_on: row['created_on'] as String?, modified_by: row['modified_by'] as int?, modified_on: row['modified_on'] as String?, id: row['id'] as int?),
        arguments: [pId]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from Scheme where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertSchemeData(SchemeListDataResponse schemeData) async {
    await _schemeListDataResponseInsertionAdapter.insert(
        schemeData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<SchemeListDataResponse> schemeList) async {
    await _schemeListDataResponseInsertionAdapter.insertList(
        schemeList, OnConflictStrategy.replace);
  }
}

class _$UserRoleRightsDao extends UserRoleRightsDao {
  _$UserRoleRightsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _userRoleRightsResponseInsertionAdapter = InsertionAdapter(
            database,
            'UserRoleRightsResponse',
            (UserRoleRightsResponse item) => <String, Object?>{
                  'id': item.id,
                  'user_role_id': item.userRoleId,
                  'moduleName': item.moduleName,
                  'functionName': item.functionName,
                  'interfaceName': item.interfaceName,
                  'create': item.create == null ? null : (item.create! ? 1 : 0),
                  'modify': item.modify == null ? null : (item.modify! ? 1 : 0),
                  'delete': item.delete == null ? null : (item.delete! ? 1 : 0),
                  'cancel': item.cancel == null ? null : (item.cancel! ? 1 : 0),
                  'selectPreview': item.selectPreview == null
                      ? null
                      : (item.selectPreview! ? 1 : 0),
                  'print': item.print == null ? null : (item.print! ? 1 : 0),
                  'export': item.export == null ? null : (item.export! ? 1 : 0),
                  'approve':
                      item.approve == null ? null : (item.approve! ? 1 : 0),
                  'rejectDiscard': item.rejectDiscard == null
                      ? null
                      : (item.rejectDiscard! ? 1 : 0),
                  'transfer':
                      item.transfer == null ? null : (item.transfer! ? 1 : 0),
                  'returnData': item.returnData == null
                      ? null
                      : (item.returnData! ? 1 : 0),
                  'search': item.search == null ? null : (item.search! ? 1 : 0),
                  'createdBy': item.createdBy,
                  'createdOn': item.createdOn,
                  'modifiedBy': item.modifiedBy,
                  'modifiedOn': item.modifiedOn,
                  'user_id': item.userId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<UserRoleRightsResponse>
      _userRoleRightsResponseInsertionAdapter;

  @override
  Future<UserRoleRightsResponse?> getUserRoleData() async {
    return _queryAdapter.query('Select * From UserRoleRightsResponse',
        mapper: (Map<String, Object?> row) => UserRoleRightsResponse(
            userRoleId: row['user_role_id'] as int?,
            userId: row['user_id'] as int?,
            moduleName: row['moduleName'] as String?,
            functionName: row['functionName'] as String?,
            interfaceName: row['interfaceName'] as String?,
            create: row['create'] == null ? null : (row['create'] as int) != 0,
            modify: row['modify'] == null ? null : (row['modify'] as int) != 0,
            delete: row['delete'] == null ? null : (row['delete'] as int) != 0,
            cancel: row['cancel'] == null ? null : (row['cancel'] as int) != 0,
            selectPreview: row['selectPreview'] == null
                ? null
                : (row['selectPreview'] as int) != 0,
            print: row['print'] == null ? null : (row['print'] as int) != 0,
            export: row['export'] == null ? null : (row['export'] as int) != 0,
            approve:
                row['approve'] == null ? null : (row['approve'] as int) != 0,
            rejectDiscard: row['rejectDiscard'] == null
                ? null
                : (row['rejectDiscard'] as int) != 0,
            transfer:
                row['transfer'] == null ? null : (row['transfer'] as int) != 0,
            returnData: row['returnData'] == null
                ? null
                : (row['returnData'] as int) != 0,
            search: row['search'] == null ? null : (row['search'] as int) != 0,
            createdBy: row['createdBy'] as int?,
            createdOn: row['createdOn'] as String?,
            modifiedBy: row['modifiedBy'] as int?,
            modifiedOn: row['modifiedOn'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from UserRoleRightsResponse where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertLoginData(UserRoleRightsResponse userRoleData) async {
    await _userRoleRightsResponseInsertionAdapter.insert(
        userRoleData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<UserRoleRightsResponse> userRoleList) async {
    await _userRoleRightsResponseInsertionAdapter.insertList(
        userRoleList, OnConflictStrategy.replace);
  }
}

class _$VisitDetailDao extends VisitDetailDao {
  _$VisitDetailDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _visitDataItemsResponseInsertionAdapter = InsertionAdapter(
            database,
            'VisitDetail',
            (VisitDataItemsResponse item) => <String, Object?>{
                  'visit_type': item.visitType,
                  'partner_id': item.partnerId,
                  'make_owner':
                      item.makeOwner == null ? null : (item.makeOwner! ? 1 : 0),
                  'customer_id': item.customerId,
                  'start_time': item.startTime,
                  'end_time': item.endTime,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn,
                  'id': item.id,
                  'isSync': item.isSync,
                  'scopeId': item.scopeId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VisitDataItemsResponse>
      _visitDataItemsResponseInsertionAdapter;

  @override
  Future<List<VisitDataItemsResponse>> getVisitDetailData() async {
    return _queryAdapter.queryList('Select * From VisitDetail',
        mapper: (Map<String, Object?> row) => VisitDataItemsResponse(
            visitType: row['visit_type'] as int?,
            partnerId: row['partner_id'] as int?,
            makeOwner: row['make_owner'] == null
                ? null
                : (row['make_owner'] as int) != 0,
            customerId: row['customer_id'] as int?,
            startTime: row['start_time'] as String?,
            endTime: row['end_time'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?,
            isSync: row['isSync'] as int?,
            scopeId: row['scopeId'] as int?));
  }

  @override
  Future<List<VisitDataItemsResponse>> getUnSyncPunchVisit() async {
    return _queryAdapter.queryList('Select * From VisitDetail where isSync = 0',
        mapper: (Map<String, Object?> row) => VisitDataItemsResponse(
            visitType: row['visit_type'] as int?,
            partnerId: row['partner_id'] as int?,
            makeOwner: row['make_owner'] == null
                ? null
                : (row['make_owner'] as int) != 0,
            customerId: row['customer_id'] as int?,
            startTime: row['start_time'] as String?,
            endTime: row['end_time'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?,
            isSync: row['isSync'] as int?,
            scopeId: row['scopeId'] as int?));
  }

  @override
  Future<VisitDataItemsResponse?> getVisitBasedOnCustomerId(int id) async {
    return _queryAdapter.query(
        'Select * From VisitDetail where customer_id = ?1 ORDER BY created_on DESC Limit 1',
        mapper: (Map<String, Object?> row) => VisitDataItemsResponse(visitType: row['visit_type'] as int?, partnerId: row['partner_id'] as int?, makeOwner: row['make_owner'] == null ? null : (row['make_owner'] as int) != 0, customerId: row['customer_id'] as int?, startTime: row['start_time'] as String?, endTime: row['end_time'] as String?, createdBy: row['created_by'] as int?, createdOn: row['created_on'] as String?, modifiedBy: row['modified_by'] as int?, modifiedOn: row['modified_on'] as String?, id: row['id'] as int?, isSync: row['isSync'] as int?, scopeId: row['scopeId'] as int?),
        arguments: [id]);
  }

  @override
  Future<VisitDataItemsResponse?> getVisitIDByScopeId(int id) async {
    return _queryAdapter.query('Select * From VisitDetail where scopeId = ?1',
        mapper: (Map<String, Object?> row) => VisitDataItemsResponse(
            visitType: row['visit_type'] as int?,
            partnerId: row['partner_id'] as int?,
            makeOwner: row['make_owner'] == null
                ? null
                : (row['make_owner'] as int) != 0,
            customerId: row['customer_id'] as int?,
            startTime: row['start_time'] as String?,
            endTime: row['end_time'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?,
            isSync: row['isSync'] as int?,
            scopeId: row['scopeId'] as int?),
        arguments: [id]);
  }

  @override
  Future<VisitDataItemsResponse?> updateVisitPunchOut(int scopeId,
      String endTime, int isSync, int modifiedBy, int visitId) async {
    return _queryAdapter.query(
        'Update VisitDetail set end_time = ?2, isSync = ?3, modified_by = ?4, modified_on = ?2, scopeId = ?1 where id = ?5',
        mapper: (Map<String, Object?> row) => VisitDataItemsResponse(visitType: row['visit_type'] as int?, partnerId: row['partner_id'] as int?, makeOwner: row['make_owner'] == null ? null : (row['make_owner'] as int) != 0, customerId: row['customer_id'] as int?, startTime: row['start_time'] as String?, endTime: row['end_time'] as String?, createdBy: row['created_by'] as int?, createdOn: row['created_on'] as String?, modifiedBy: row['modified_by'] as int?, modifiedOn: row['modified_on'] as String?, id: row['id'] as int?, isSync: row['isSync'] as int?, scopeId: row['scopeId'] as int?),
        arguments: [scopeId, endTime, isSync, modifiedBy, visitId]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from VisitDetail where id = ?1',
        arguments: [id]);
  }

  @override
  Future<bool?> deleteUnSyncData() async {
    await _queryAdapter
        .queryNoReturn('delete from VisitDetail where isSync = 0');
  }

  @override
  Future<void> insertVisitDetailData(
      VisitDataItemsResponse visitDetailData) async {
    await _visitDataItemsResponseInsertionAdapter.insert(
        visitDetailData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<VisitDataItemsResponse> visitDetailList) async {
    await _visitDataItemsResponseInsertionAdapter.insertList(
        visitDetailList, OnConflictStrategy.replace);
  }
}

class _$ProductSchemeDao extends ProductSchemeDao {
  _$ProductSchemeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productSchemaDataInsertionAdapter = InsertionAdapter(
            database,
            'ProductScheme',
            (ProductSchemaData item) => <String, Object?>{
                  'product_id': item.product_id,
                  'scheme_id': item.scheme_id,
                  'is_active':
                      item.is_active == null ? null : (item.is_active! ? 1 : 0),
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductSchemaData> _productSchemaDataInsertionAdapter;

  @override
  Future<List<ProductSchemaData>?> getProductSchemeData() async {
    return _queryAdapter.queryList('Select * From ProductScheme',
        mapper: (Map<String, Object?> row) => ProductSchemaData(
            product_id: row['product_id'] as int?,
            scheme_id: row['scheme_id'] as int?,
            is_active: row['is_active'] == null
                ? null
                : (row['is_active'] as int) != 0,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from ProductScheme where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertProductSchemeData(
      ProductSchemaData productSchemeData) async {
    await _productSchemaDataInsertionAdapter.insert(
        productSchemeData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<ProductSchemaData> productSchemeList) async {
    await _productSchemaDataInsertionAdapter.insertList(
        productSchemeList, OnConflictStrategy.replace);
  }
}

class _$ImageFolderDao extends ImageFolderDao {
  _$ImageFolderDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _imageFolderDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'ImageFolder',
            (ImageFolderDataResponse item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ImageFolderDataResponse>
      _imageFolderDataResponseInsertionAdapter;

  @override
  Future<List<ImageFolderDataResponse>> getAllData() async {
    return _queryAdapter.queryList('Select * From ImageFolder',
        mapper: (Map<String, Object?> row) => ImageFolderDataResponse(
            id: row['id'] as int,
            name: row['name'] as String,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from ImageFolder where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertImageFolderData(
      ImageFolderDataResponse imageFolderData) async {
    await _imageFolderDataResponseInsertionAdapter.insert(
        imageFolderData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<ImageFolderDataResponse> imageFolderList) async {
    await _imageFolderDataResponseInsertionAdapter.insertList(
        imageFolderList, OnConflictStrategy.replace);
  }
}

class _$CartDao extends CartDao {
  _$CartDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productWithPriceModelInsertionAdapter = InsertionAdapter(
            database,
            'cart',
            (ProductWithPriceModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'product_code': item.product_code,
                  'group_id': item.group_id,
                  'sub_group_id': item.sub_group_id,
                  'category_id': item.category_id,
                  'sub_category_id': item.sub_category_id,
                  'scheme_id': item.scheme_id,
                  'hsn': item.hsn,
                  'cgst': item.cgst,
                  'sgst': item.sgst,
                  'igst': item.igst,
                  'uom_1': item.uom_1,
                  'uom_2': item.uom_2,
                  'uom_3': item.uom_3,
                  'uom_4': item.uom_4,
                  'uom_2_value': item.uom_2_value,
                  'uom_3_value': item.uom_3_value,
                  'is_sellable_uom1': item.is_sellable_uom1,
                  'is_sellable_uom2': item.is_sellable_uom2,
                  'stockiest_base_price': item.stockiest_base_price,
                  'distributor_base_price': item.distributor_base_price,
                  'secondary_base_price': item.secondary_base_price,
                  'retail_base_price': item.retail_base_price,
                  'subscriber_id': item.subscriber_id,
                  'product_id': item.product_id,
                  'pricing_type': item.pricing_type,
                  'mrp': item.mrp,
                  'min_base_price': item.min_base_price,
                  'max_base_price': item.max_base_price,
                  'state_id': item.state_id,
                  'distributor_id': item.distributor_id,
                  'distributor_type': item.distributor_type,
                  'customer_id': item.customer_id,
                  'customer_type': item.customer_type,
                  'customer_category': item.customer_category,
                  'availableStock': item.availableStock,
                  'selected_scheme_id': item.selected_scheme_id,
                  'scheme_name': item.scheme_name,
                  'quantity': item.quantity,
                  'discount': item.discount,
                  'entered_price': item.entered_price,
                  'selected_uom_id': item.selected_uom_id,
                  'selected_uom': item.selected_uom,
                  'free_product_name': item.free_product_name,
                  'free_product_quantity': item.free_product_quantity,
                  'free_product_uom': item.free_product_uom,
                  'free_product_uom_name': item.free_product_uom_name,
                  'free_product_hsn': item.free_product_hsn,
                  'free_product_id': item.free_product_id,
                  'scheme_discount': item.scheme_discount
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductWithPriceModel>
      _productWithPriceModelInsertionAdapter;

  @override
  Future<List<ProductWithPriceModel>?> getAllData() async {
    return _queryAdapter.queryList('select * from cart',
        mapper: (Map<String, Object?> row) => ProductWithPriceModel(
            id: row['id'] as int?,
            name: row['name'] as String?,
            product_code: row['product_code'] as String?,
            group_id: row['group_id'] as int?,
            sub_group_id: row['sub_group_id'] as int?,
            category_id: row['category_id'] as int?,
            sub_category_id: row['sub_category_id'] as int?,
            scheme_id: row['scheme_id'] as int?,
            hsn: row['hsn'] as String?,
            cgst: row['cgst'] as double?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            uom_1: row['uom_1'] as int?,
            uom_2: row['uom_2'] as int?,
            uom_3: row['uom_3'] as int?,
            uom_4: row['uom_4'] as int?,
            uom_2_value: row['uom_2_value'] as int?,
            uom_3_value: row['uom_3_value'] as int?,
            is_sellable_uom1: row['is_sellable_uom1'] as int?,
            is_sellable_uom2: row['is_sellable_uom2'] as int?,
            product_id: row['product_id'] as int?,
            pricing_type: row['pricing_type'] as int?,
            mrp: row['mrp'] as double?,
            min_base_price: row['min_base_price'] as double?,
            max_base_price: row['max_base_price'] as double?,
            state_id: row['state_id'] as int?,
            distributor_id: row['distributor_id'] as int?,
            distributor_type: row['distributor_type'] as int?,
            customer_id: row['customer_id'] as int?,
            customer_type: row['customer_type'] as int?,
            customer_category: row['customer_category'] as int?,
            availableStock: row['availableStock'] as double?,
            selected_scheme_id: row['selected_scheme_id'] as int?,
            scheme_name: row['scheme_name'] as String?,
            quantity: row['quantity'] as double?,
            discount: row['discount'] as double?,
            entered_price: row['entered_price'] as double?,
            selected_uom_id: row['selected_uom_id'] as int?,
            selected_uom: row['selected_uom'] as String?,
            free_product_name: row['free_product_name'] as String?,
            free_product_quantity: row['free_product_quantity'] as int?,
            free_product_uom: row['free_product_uom'] as int?,
            scheme_discount: row['scheme_discount'] as double?,
            free_product_id: row['free_product_id'] as int?,
            free_product_hsn: row['free_product_hsn'] as String?,
            free_product_uom_name: row['free_product_uom_name'] as String?));
  }

  @override
  Future<bool?> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from cart where id = ?1', arguments: [id]);
  }

  @override
  Future<bool?> deleteAllData() async {
    await _queryAdapter.queryNoReturn('delete from cart');
  }

  @override
  Future<void> insertProductIntoCart(
      ProductWithPriceModel productWithPriceModel) async {
    await _productWithPriceModelInsertionAdapter.insert(
        productWithPriceModel, OnConflictStrategy.replace);
  }
}

class _$OrderRecordDao extends OrderRecordDao {
  _$OrderRecordDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _orderRecordDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'OrderRecord',
            (OrderRecordDataResponse item) => <String, Object?>{
                  'id': item.id,
                  'order_date': item.orderDate,
                  'order_serial_number': item.orderSerialNumber,
                  'warehouse_id': item.warehouseId,
                  'distributor_id': item.distributorId,
                  'customer_id': item.customerId,
                  'order_type': item.orderType,
                  'fsmOrderType': item.fsmOrderType,
                  'total_balance_due': item.totalBalanceDue,
                  'total_amount': item.totalAmount,
                  'payment_mode': item.paymentMode,
                  'payment_status': item.paymentStatus,
                  'received_amount': item.receivedAmount,
                  'pick_adn_pack_status': item.pickAndPackStatus,
                  'bill_status': item.billStatus,
                  'subscriber_id': item.subscriberId,
                  'fy_id': item.fyId,
                  'jc_id': item.jcId,
                  'shipping_address': item.shippingAddress,
                  'billing_address': item.billingAddress,
                  'scheme_id': item.schemeId,
                  'reference_number': item.referenceNumber,
                  'added_discount': item.addedDiscount,
                  'visit_id': item.visitId,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'isSync': item.isSync
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderRecordDataResponse>
      _orderRecordDataResponseInsertionAdapter;

  @override
  Future<List<OrderRecordDataResponse>> getOrderRecordData(
      int customerId) async {
    return _queryAdapter.queryList(
        'Select * From OrderRecord where customer_id = ?1',
        mapper: (Map<String, Object?> row) => OrderRecordDataResponse(
            orderDate: row['order_date'] as String?,
            orderSerialNumber: row['order_serial_number'] as String?,
            warehouseId: row['warehouse_id'] as int?,
            distributorId: row['distributor_id'] as int?,
            customerId: row['customer_id'] as int?,
            orderType: row['order_type'] as int?,
            fsmOrderType: row['fsmOrderType'] as int?,
            totalBalanceDue: row['total_balance_due'] as double?,
            totalAmount: row['total_amount'] as double?,
            paymentMode: row['payment_mode'] as int?,
            paymentStatus: row['payment_status'] as int?,
            receivedAmount: row['received_amount'] as double?,
            pickAndPackStatus: row['pick_adn_pack_status'] as int?,
            billStatus: row['bill_status'] as int?,
            subscriberId: row['subscriber_id'] as int?,
            fyId: row['fy_id'] as int?,
            jcId: row['jc_id'] as int?,
            shippingAddress: row['shipping_address'] as int?,
            billingAddress: row['billing_address'] as int?,
            schemeId: row['scheme_id'] as int?,
            referenceNumber: row['reference_number'] as String?,
            addedDiscount: row['added_discount'] as double?,
            visitId: row['visit_id'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            isSync: row['isSync'] as int,
            id: row['id'] as int?),
        arguments: [customerId]);
  }

  @override
  Future<OrderRecordDao?> getLastOrderByCustomerId(int customerId) async {
    await _queryAdapter.queryNoReturn(
        'select * from OrderRecord where customer_id = ?1 order by created_on desc limit 1',
        arguments: [customerId]);
  }

  @override
  Future<List<OrderRecordDataResponse>> getUnSyncOrder() async {
    return _queryAdapter.queryList('select* from OrderRecord where isSync = 0',
        mapper: (Map<String, Object?> row) => OrderRecordDataResponse(
            orderDate: row['order_date'] as String?,
            orderSerialNumber: row['order_serial_number'] as String?,
            warehouseId: row['warehouse_id'] as int?,
            distributorId: row['distributor_id'] as int?,
            customerId: row['customer_id'] as int?,
            orderType: row['order_type'] as int?,
            fsmOrderType: row['fsmOrderType'] as int?,
            totalBalanceDue: row['total_balance_due'] as double?,
            totalAmount: row['total_amount'] as double?,
            paymentMode: row['payment_mode'] as int?,
            paymentStatus: row['payment_status'] as int?,
            receivedAmount: row['received_amount'] as double?,
            pickAndPackStatus: row['pick_adn_pack_status'] as int?,
            billStatus: row['bill_status'] as int?,
            subscriberId: row['subscriber_id'] as int?,
            fyId: row['fy_id'] as int?,
            jcId: row['jc_id'] as int?,
            shippingAddress: row['shipping_address'] as int?,
            billingAddress: row['billing_address'] as int?,
            schemeId: row['scheme_id'] as int?,
            referenceNumber: row['reference_number'] as String?,
            addedDiscount: row['added_discount'] as double?,
            visitId: row['visit_id'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            isSync: row['isSync'] as int,
            id: row['id'] as int?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from OrderRecord where id = ?1',
        arguments: [id]);
  }

  @override
  Future<bool?> deleteUnSyncData() async {
    await _queryAdapter
        .queryNoReturn('delete from OrderRecord where isSync = 0');
  }

  @override
  Future<int> insertOrderRecordData(OrderRecordDataResponse orderRecordData) {
    return _orderRecordDataResponseInsertionAdapter.insertAndReturnId(
        orderRecordData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<OrderRecordDataResponse> orderRecordList) async {
    await _orderRecordDataResponseInsertionAdapter.insertList(
        orderRecordList, OnConflictStrategy.replace);
  }
}

class _$OrderItemDao extends OrderItemDao {
  _$OrderItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _orderItemDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'OrderItem',
            (OrderItemDataResponse item) => <String, Object?>{
                  'id': item.id,
                  'order_id': item.orderId,
                  'storage_id': item.storageId,
                  'grn_id': item.grnId,
                  'r_id': item.rId,
                  'product_id': item.productId,
                  'hsn_code': item.hsnCode,
                  'cgst': item.cgst,
                  'sgst': item.sgst,
                  'igst': item.igst,
                  'vat': item.vat,
                  'uoM': item.uoM,
                  'pick_and_pack_status': item.pickAndPackStatus,
                  'available_quantity': item.availableQuantity,
                  'base_price': item.basePrice,
                  'discount': item.discount,
                  'order_quantity': item.orderQuantity,
                  'scheme_id': item.schemeId,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'isSync': item.isSync
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderItemDataResponse>
      _orderItemDataResponseInsertionAdapter;

  @override
  Future<List<OrderItemDataResponse>> getOrderItemData() async {
    return _queryAdapter.queryList('Select * From OrderItem',
        mapper: (Map<String, Object?> row) => OrderItemDataResponse(
            orderId: row['order_id'] as int?,
            storageId: row['storage_id'] as int?,
            grnId: row['grn_id'] as int?,
            rId: row['r_id'] as int?,
            productId: row['product_id'] as int?,
            hsnCode: row['hsn_code'] as String?,
            cgst: row['cgst'] as double?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            vat: row['vat'] as double?,
            uoM: row['uoM'] as int?,
            pickAndPackStatus: row['pick_and_pack_status'] as int?,
            availableQuantity: row['available_quantity'] as double?,
            basePrice: row['base_price'] as double?,
            discount: row['discount'] as double?,
            orderQuantity: row['order_quantity'] as double?,
            schemeId: row['scheme_id'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?,
            isSync: row['isSync'] as int));
  }

  @override
  Future<List<OrderItemDataResponse>> getUnSyncOrder() async {
    return _queryAdapter.queryList('select* from OrderItem where isSync = 0',
        mapper: (Map<String, Object?> row) => OrderItemDataResponse(
            orderId: row['order_id'] as int?,
            storageId: row['storage_id'] as int?,
            grnId: row['grn_id'] as int?,
            rId: row['r_id'] as int?,
            productId: row['product_id'] as int?,
            hsnCode: row['hsn_code'] as String?,
            cgst: row['cgst'] as double?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            vat: row['vat'] as double?,
            uoM: row['uoM'] as int?,
            pickAndPackStatus: row['pick_and_pack_status'] as int?,
            availableQuantity: row['available_quantity'] as double?,
            basePrice: row['base_price'] as double?,
            discount: row['discount'] as double?,
            orderQuantity: row['order_quantity'] as double?,
            schemeId: row['scheme_id'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?,
            isSync: row['isSync'] as int));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from OrderItem where id = ?1', arguments: [id]);
  }

  @override
  Future<bool?> deleteUnSyncData() async {
    await _queryAdapter.queryNoReturn('delete from OrderItem where isSync = 0');
  }

  @override
  Future<void> insertOrderItemData(OrderItemDataResponse orderItemData) async {
    await _orderItemDataResponseInsertionAdapter.insert(
        orderItemData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<OrderItemDataResponse> orderItemList) async {
    await _orderItemDataResponseInsertionAdapter.insertList(
        orderItemList, OnConflictStrategy.replace);
  }
}

class _$VisitOrderMappingDao extends VisitOrderMappingDao {
  _$VisitOrderMappingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _visitOrderItemInsertionAdapter = InsertionAdapter(
            database,
            'VisitOrderMapping',
            (VisitOrderItem item) => <String, Object?>{
                  'order_id': item.orderId,
                  'visit_id': item.visitId,
                  'isActive':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0),
                  'paymentCollectionId': item.paymentCollectionId,
                  'salesReturnRegisterId': item.salesReturnRegisterId,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<VisitOrderItem> _visitOrderItemInsertionAdapter;

  @override
  Future<List<VisitOrderItem>> getOrderItemData() async {
    return _queryAdapter.queryList('Select * From VisitOrderMapping',
        mapper: (Map<String, Object?> row) => VisitOrderItem(
            orderId: row['order_id'] as int?,
            visitId: row['visit_id'] as int?,
            isActive:
                row['isActive'] == null ? null : (row['isActive'] as int) != 0,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?,
            paymentCollectionId: row['paymentCollectionId'] as int?,
            salesReturnRegisterId: row['salesReturnRegisterId'] as int?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from VisitOrderMapping where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertVisitOrderMappingData(VisitOrderItem orderItemData) async {
    await _visitOrderItemInsertionAdapter.insert(
        orderItemData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<VisitOrderItem> orderItemList) async {
    await _visitOrderItemInsertionAdapter.insertList(
        orderItemList, OnConflictStrategy.replace);
  }
}

class _$ProductTrendDao extends ProductTrendDao {
  _$ProductTrendDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productTrendsItemInsertionAdapter = InsertionAdapter(
            database,
            'ProductTrends',
            (ProductTrendsItem item) => <String, Object?>{
                  'id': item.id,
                  'productId': item.productId,
                  'isFocus':
                      item.isFocus == null ? null : (item.isFocus! ? 1 : 0),
                  'isNew': item.isNew == null ? null : (item.isNew! ? 1 : 0),
                  'isMustSell': item.isMustSell == null
                      ? null
                      : (item.isMustSell! ? 1 : 0),
                  'isOutletTrend': item.isOutletTrend == null
                      ? null
                      : (item.isOutletTrend! ? 1 : 0),
                  'startDate': item.startDate,
                  'endDate': item.endDate,
                  'isActive':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0),
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductTrendsItem> _productTrendsItemInsertionAdapter;

  @override
  Future<List<ProductTrendsItem>?> getProductSchemeData() async {
    return _queryAdapter.queryList('Select * From ProductTrends',
        mapper: (Map<String, Object?> row) => ProductTrendsItem(
            id: row['id'] as int?,
            productId: row['productId'] as int?,
            isFocus:
                row['isFocus'] == null ? null : (row['isFocus'] as int) != 0,
            isNew: row['isNew'] == null ? null : (row['isNew'] as int) != 0,
            isMustSell: row['isMustSell'] == null
                ? null
                : (row['isMustSell'] as int) != 0,
            isOutletTrend: row['isOutletTrend'] == null
                ? null
                : (row['isOutletTrend'] as int) != 0,
            startDate: row['startDate'] as String?,
            endDate: row['endDate'] as String?,
            isActive:
                row['isActive'] == null ? null : (row['isActive'] as int) != 0,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from ProductTrends where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertProductSchemeData(
      ProductTrendsItem productSchemeData) async {
    await _productTrendsItemInsertionAdapter.insert(
        productSchemeData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<ProductTrendsItem> productSchemeList) async {
    await _productTrendsItemInsertionAdapter.insertList(
        productSchemeList, OnConflictStrategy.replace);
  }
}

class _$ProductTrendsLocationDao extends ProductTrendsLocationDao {
  _$ProductTrendsLocationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _productTrendsLocationItemInsertionAdapter = InsertionAdapter(
            database,
            'ProductTrendsLocation',
            (ProductTrendsLocationItem item) => <String, Object?>{
                  'id': item.id,
                  'product_trend_id': item.productTrendId,
                  'location_id': item.locationId,
                  'isActive':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ProductTrendsLocationItem>
      _productTrendsLocationItemInsertionAdapter;

  @override
  Future<List<ProductTrendsLocationItem>?> getProductTrendsLocation() async {
    return _queryAdapter.queryList('Select * From ProductTrendsLocation',
        mapper: (Map<String, Object?> row) => ProductTrendsLocationItem(
            id: row['id'] as int?,
            productTrendId: row['product_trend_id'] as int?,
            locationId: row['location_id'] as int?,
            isActive: row['isActive'] == null
                ? null
                : (row['isActive'] as int) != 0));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from ProductTrendsLocation where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertProductTrendsLocation(
      ProductTrendsLocationItem productSchemeData) async {
    await _productTrendsLocationItemInsertionAdapter.insert(
        productSchemeData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<ProductTrendsLocationItem> producTrendsLocation) async {
    await _productTrendsLocationItemInsertionAdapter.insertList(
        producTrendsLocation, OnConflictStrategy.replace);
  }
}

class _$CustomerCategoryDao extends CustomerCategoryDao {
  _$CustomerCategoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _customerCategoryDataResponseInsertionAdapter = InsertionAdapter(
            database,
            'CustomerCategory',
            (CustomerCategoryDataResponse item) => <String, Object?>{
                  'id': item.id,
                  'subscriber_id': item.subscriberId,
                  'category_name': item.categoryName,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CustomerCategoryDataResponse>
      _customerCategoryDataResponseInsertionAdapter;

  @override
  Future<List<CustomerCategoryDataResponse>> getCustomerCategoryData() async {
    return _queryAdapter.queryList('Select * From CustomerCategory',
        mapper: (Map<String, Object?> row) => CustomerCategoryDataResponse(
            subscriberId: row['subscriber_id'] as int?,
            categoryName: row['category_name'] as String?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from CustomerCategory where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertAllData(
      List<CustomerCategoryDataResponse> customerCategoryList) async {
    await _customerCategoryDataResponseInsertionAdapter.insertList(
        customerCategoryList, OnConflictStrategy.replace);
  }
}

class _$LocationDao extends LocationDao {
  _$LocationDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _locationDataItemsInsertionAdapter = InsertionAdapter(
            database,
            'Location',
            (LocationDataItems item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'name': item.name,
                  'country_id': item.countryId,
                  'state_id': item.stateId,
                  'district_id': item.districtId,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LocationDataItems> _locationDataItemsInsertionAdapter;

  @override
  Future<List<LocationDataItems?>> getLocationData() async {
    return _queryAdapter.queryList('Select * From Location',
        mapper: (Map<String, Object?> row) => LocationDataItems(
            id: row['id'] as int?,
            code: row['code'] as String?,
            name: row['name'] as String?,
            countryId: row['country_id'] as int?,
            stateId: row['state_id'] as int?,
            districtId: row['district_id'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?));
  }

  @override
  Future<List<LocationDataItems>?> getLocationBasedOnDistrictId(int id) async {
    return _queryAdapter.queryList(
        'Select * From Location where district_id = ?1',
        mapper: (Map<String, Object?> row) => LocationDataItems(
            id: row['id'] as int?,
            code: row['code'] as String?,
            name: row['name'] as String?,
            countryId: row['country_id'] as int?,
            stateId: row['state_id'] as int?,
            districtId: row['district_id'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from Location where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertLocationData(LocationDataItems locationData) async {
    await _locationDataItemsInsertionAdapter.insert(
        locationData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<LocationDataItems> locationList) async {
    await _locationDataItemsInsertionAdapter.insertList(
        locationList, OnConflictStrategy.replace);
  }
}

class _$CountryDao extends CountryDao {
  _$CountryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _countryDataInsertionAdapter = InsertionAdapter(
            database,
            'Country',
            (CountryData item) => <String, Object?>{
                  'id': item.id,
                  'code': item.code,
                  'name': item.name,
                  'timezone': item.timeZone,
                  'isDefault':
                      item.isDefault == null ? null : (item.isDefault! ? 1 : 0),
                  'isActive':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0),
                  'currency': item.currency,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CountryData> _countryDataInsertionAdapter;

  @override
  Future<List<CountryData>?> getCountryData() async {
    return _queryAdapter.queryList('Select * From Country',
        mapper: (Map<String, Object?> row) => CountryData(
            id: row['id'] as int?,
            code: row['code'] as String?,
            name: row['name'] as String?,
            timeZone: row['timezone'] as String?,
            currency: row['currency'] as String?,
            isDefault: row['isDefault'] == null
                ? null
                : (row['isDefault'] as int) != 0,
            isActive:
                row['isActive'] == null ? null : (row['isActive'] as int) != 0,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from Country where id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertCountryData(CountryData countryData) async {
    await _countryDataInsertionAdapter.insert(
        countryData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<CountryData> countryList) async {
    await _countryDataInsertionAdapter.insertList(
        countryList, OnConflictStrategy.replace);
  }
}

class _$CustomerImageDao extends CustomerImageDao {
  _$CustomerImageDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _customerImageItemResponseInsertionAdapter = InsertionAdapter(
            database,
            'CustomerImage',
            (CustomerImageItemResponse item) => <String, Object?>{
                  'file_name': item.fileName,
                  'folder_id': item.folderId,
                  'media_file_id': item.mediaFileId,
                  'customer_id': item.customerId,
                  'is_cover':
                      item.isCover == null ? null : (item.isCover! ? 1 : 0),
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CustomerImageItemResponse>
      _customerImageItemResponseInsertionAdapter;

  @override
  Future<List<CustomerImageItemResponse>> getAllData() async {
    return _queryAdapter.queryList('Select * From CustomerImage',
        mapper: (Map<String, Object?> row) => CustomerImageItemResponse(
            fileName: row['file_name'] as String?,
            folderId: row['folder_id'] as int?,
            mediaFileId: row['media_file_id'] as int?,
            customerId: row['customer_id'] as int?,
            isCover:
                row['is_cover'] == null ? null : (row['is_cover'] as int) != 0,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<List<CustomerImageItemResponse>> getImageIdData(
      int customerId, int folderId) async {
    return _queryAdapter.queryList(
        'select * from CustomerImage where customer_id = ?1 and folder_id = ?2',
        mapper: (Map<String, Object?> row) => CustomerImageItemResponse(
            fileName: row['file_name'] as String?,
            folderId: row['folder_id'] as int?,
            mediaFileId: row['media_file_id'] as int?,
            customerId: row['customer_id'] as int?,
            isCover:
                row['is_cover'] == null ? null : (row['is_cover'] as int) != 0,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?),
        arguments: [customerId, folderId]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from CustomerImage where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertCustomerImageData(
      CustomerImageItemResponse customerImageData) async {
    await _customerImageItemResponseInsertionAdapter.insert(
        customerImageData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<CustomerImageItemResponse> customerImageList) async {
    await _customerImageItemResponseInsertionAdapter.insertList(
        customerImageList, OnConflictStrategy.replace);
  }
}

class _$NoOrderTypeDao extends NoOrderTypeDao {
  _$NoOrderTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noOrderTypeDataInsertionAdapter = InsertionAdapter(
            database,
            'NoOrderType',
            (NoOrderTypeData item) => <String, Object?>{
                  'type_name': item.typeName,
                  'is_active':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0),
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoOrderTypeData> _noOrderTypeDataInsertionAdapter;

  @override
  Future<List<NoOrderTypeData>> getNoOrderType() async {
    return _queryAdapter.queryList('Select * From NoOrderType',
        mapper: (Map<String, Object?> row) => NoOrderTypeData(
            typeName: row['type_name'] as String?,
            isActive: row['is_active'] == null
                ? null
                : (row['is_active'] as int) != 0,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<void> insertAllData(List<NoOrderTypeData> noOrderTypeList) async {
    await _noOrderTypeDataInsertionAdapter.insertList(
        noOrderTypeList, OnConflictStrategy.replace);
  }
}

class _$NoOrderDao extends NoOrderDao {
  _$NoOrderDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _noOrderRequestInsertionAdapter = InsertionAdapter(
            database,
            'NoOrder',
            (NoOrderRequest item) => <String, Object?>{
                  'id': item.id,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'customer_id': item.customerId,
                  'no_order_type_id': item.noOrderTypeId,
                  'remarks': item.remarks,
                  'is_active':
                      item.isActive == null ? null : (item.isActive! ? 1 : 0),
                  'visitId': item.visitId,
                  'isSync': item.isSync
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NoOrderRequest> _noOrderRequestInsertionAdapter;

  @override
  Future<List<NoOrderRequest>> getNoOrder() async {
    return _queryAdapter.queryList('Select * From NoOrder',
        mapper: (Map<String, Object?> row) => NoOrderRequest(
            id: row['id'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            customerId: row['customer_id'] as int?,
            noOrderTypeId: row['no_order_type_id'] as int?,
            remarks: row['remarks'] as String?,
            isActive: row['is_active'] == null
                ? null
                : (row['is_active'] as int) != 0,
            visitId: row['visitId'] as int?,
            isSync: row['isSync'] as int));
  }

  @override
  Future<List<NoOrderRequest>> getUnSyncNoOrder() async {
    return _queryAdapter.queryList('select* from NoOrder where isSync = 0',
        mapper: (Map<String, Object?> row) => NoOrderRequest(
            id: row['id'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            customerId: row['customer_id'] as int?,
            noOrderTypeId: row['no_order_type_id'] as int?,
            remarks: row['remarks'] as String?,
            isActive: row['is_active'] == null
                ? null
                : (row['is_active'] as int) != 0,
            visitId: row['visitId'] as int?,
            isSync: row['isSync'] as int));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from NoOrder where id = ?1', arguments: [id]);
  }

  @override
  Future<bool?> deleteUnSyncData() async {
    await _queryAdapter.queryNoReturn('delete from NoOrder where isSync = 0');
  }

  @override
  Future<void> insertOrderItemData(NoOrderRequest noOrderData) async {
    await _noOrderRequestInsertionAdapter.insert(
        noOrderData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<NoOrderRequest> noOrderList) async {
    await _noOrderRequestInsertionAdapter.insertList(
        noOrderList, OnConflictStrategy.replace);
  }
}

class _$SalesReturnDao extends SalesReturnDao {
  _$SalesReturnDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _salesReturnItemInsertionAdapter = InsertionAdapter(
            database,
            'SalesReturn',
            (SalesReturnItem item) => <String, Object?>{
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id,
                  'returnDate': item.returnDate,
                  'warehouseId': item.warehouseId,
                  'customerId': item.customerId,
                  'productId': item.productId,
                  'secondaryInvoiceId': item.secondaryInvoiceId,
                  'rate': item.rate,
                  'storageId': item.storageId,
                  'sellableQuantity': item.sellableQuantity,
                  'damagedQuantity': item.damagedQuantity,
                  'uoM': item.uoM,
                  'reasonId': item.reasonId,
                  'fyId': item.fyId,
                  'jcId': item.jcId,
                  'remark': item.remark,
                  'grnId': item.grnId,
                  'rId': item.rId,
                  'subscriberId': item.subscriberId,
                  'distributorId': item.distributorId,
                  'batchNumber': item.batchNumber,
                  'cgst': item.cgst,
                  'sgst': item.sgst,
                  'igst': item.igst,
                  'isApprove':
                      item.isApprove == null ? null : (item.isApprove! ? 1 : 0),
                  'isCancel':
                      item.isCancel == null ? null : (item.isCancel! ? 1 : 0),
                  'isSync': item.isSync,
                  'visitId': item.visitId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SalesReturnItem> _salesReturnItemInsertionAdapter;

  @override
  Future<List<SalesReturnItem>?> getAllData() async {
    return _queryAdapter.queryList('Select * From SalesReturn',
        mapper: (Map<String, Object?> row) => SalesReturnItem(
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?,
            returnDate: row['returnDate'] as String?,
            warehouseId: row['warehouseId'] as int?,
            customerId: row['customerId'] as int?,
            productId: row['productId'] as int?,
            secondaryInvoiceId: row['secondaryInvoiceId'] as int?,
            rate: row['rate'] as double?,
            storageId: row['storageId'] as int?,
            sellableQuantity: row['sellableQuantity'] as double?,
            damagedQuantity: row['damagedQuantity'] as double?,
            uoM: row['uoM'] as int?,
            reasonId: row['reasonId'] as int?,
            fyId: row['fyId'] as int?,
            jcId: row['jcId'] as int?,
            remark: row['remark'] as String?,
            grnId: row['grnId'] as int?,
            rId: row['rId'] as int?,
            subscriberId: row['subscriberId'] as int?,
            distributorId: row['distributorId'] as int?,
            batchNumber: row['batchNumber'] as String?,
            cgst: row['cgst'] as double?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            isApprove: row['isApprove'] == null
                ? null
                : (row['isApprove'] as int) != 0,
            isCancel:
                row['isCancel'] == null ? null : (row['isCancel'] as int) != 0,
            isSync: row['isSync'] as int?,
            visitId: row['visitId'] as int?));
  }

  @override
  Future<List<SalesReturnItem>> getAllUnSyncData() async {
    return _queryAdapter.queryList('Select * From SalesReturn where isSync = 0',
        mapper: (Map<String, Object?> row) => SalesReturnItem(
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?,
            returnDate: row['returnDate'] as String?,
            warehouseId: row['warehouseId'] as int?,
            customerId: row['customerId'] as int?,
            productId: row['productId'] as int?,
            secondaryInvoiceId: row['secondaryInvoiceId'] as int?,
            rate: row['rate'] as double?,
            storageId: row['storageId'] as int?,
            sellableQuantity: row['sellableQuantity'] as double?,
            damagedQuantity: row['damagedQuantity'] as double?,
            uoM: row['uoM'] as int?,
            reasonId: row['reasonId'] as int?,
            fyId: row['fyId'] as int?,
            jcId: row['jcId'] as int?,
            remark: row['remark'] as String?,
            grnId: row['grnId'] as int?,
            rId: row['rId'] as int?,
            subscriberId: row['subscriberId'] as int?,
            distributorId: row['distributorId'] as int?,
            batchNumber: row['batchNumber'] as String?,
            cgst: row['cgst'] as double?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            isApprove: row['isApprove'] == null
                ? null
                : (row['isApprove'] as int) != 0,
            isCancel:
                row['isCancel'] == null ? null : (row['isCancel'] as int) != 0,
            isSync: row['isSync'] as int?,
            visitId: row['visitId'] as int?));
  }

  @override
  Future<List<SalesReturnItem>?> getApprovedSalesReturnForInvoice(
      int id) async {
    return _queryAdapter.queryList(
        'select * from SalesReturn where secondaryInvoiceId = ?1 and isApprove = 1',
        mapper: (Map<String, Object?> row) => SalesReturnItem(created_by: row['created_by'] as int?, created_on: row['created_on'] as String?, modified_by: row['modified_by'] as int?, modified_on: row['modified_on'] as String?, id: row['id'] as int?, returnDate: row['returnDate'] as String?, warehouseId: row['warehouseId'] as int?, customerId: row['customerId'] as int?, productId: row['productId'] as int?, secondaryInvoiceId: row['secondaryInvoiceId'] as int?, rate: row['rate'] as double?, storageId: row['storageId'] as int?, sellableQuantity: row['sellableQuantity'] as double?, damagedQuantity: row['damagedQuantity'] as double?, uoM: row['uoM'] as int?, reasonId: row['reasonId'] as int?, fyId: row['fyId'] as int?, jcId: row['jcId'] as int?, remark: row['remark'] as String?, grnId: row['grnId'] as int?, rId: row['rId'] as int?, subscriberId: row['subscriberId'] as int?, distributorId: row['distributorId'] as int?, batchNumber: row['batchNumber'] as String?, cgst: row['cgst'] as double?, sgst: row['sgst'] as double?, igst: row['igst'] as double?, isApprove: row['isApprove'] == null ? null : (row['isApprove'] as int) != 0, isCancel: row['isCancel'] == null ? null : (row['isCancel'] as int) != 0, isSync: row['isSync'] as int?, visitId: row['visitId'] as int?),
        arguments: [id]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from SalesReturn where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> deleteUnSyncedData() async {
    await _queryAdapter
        .queryNoReturn('delete from SalesReturn where isSync = 0');
  }

  @override
  Future<void> insertSalesReturnData(SalesReturnItem data) async {
    await _salesReturnItemInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<SalesReturnItem> salesReturnList) async {
    await _salesReturnItemInsertionAdapter.insertList(
        salesReturnList, OnConflictStrategy.replace);
  }
}

class _$InvoiceMappingDao extends InvoiceMappingDao {
  _$InvoiceMappingDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _orderInvoiceMappingInsertionAdapter = InsertionAdapter(
            database,
            'OrderInvoiceMapping',
            (OrderInvoiceMapping item) => <String, Object?>{
                  'id': item.id,
                  'orderId': item.orderId,
                  'date': item.date,
                  'secondaryInvoiceSerialNumber':
                      item.secondaryInvoiceSerialNumber,
                  'distributorId': item.distributorId,
                  'fyId': item.fyId,
                  'jcId': item.jcId,
                  'customerId': item.customerId,
                  'vehicleId': item.vehicleId,
                  'deliveryStatus': item.deliveryStatus,
                  'subscriberId': item.subscriberId,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<OrderInvoiceMapping>
      _orderInvoiceMappingInsertionAdapter;

  @override
  Future<List<OrderInvoiceMapping>?> getAllData() async {
    return _queryAdapter.queryList('select * from OrderInvoiceMapping',
        mapper: (Map<String, Object?> row) => OrderInvoiceMapping(
            id: row['id'] as int,
            orderId: row['orderId'] as int,
            date: row['date'] as String,
            secondaryInvoiceSerialNumber:
                row['secondaryInvoiceSerialNumber'] as String,
            distributorId: row['distributorId'] as int,
            fyId: row['fyId'] as int,
            jcId: row['jcId'] as int,
            customerId: row['customerId'] as int,
            deliveryStatus: row['deliveryStatus'] as int,
            subscriberId: row['subscriberId'] as int,
            vehicleId: row['vehicleId'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?));
  }

  @override
  Future<List<OrderInvoiceMapping>?> getInvoiceListBasedOnCustomer(
      int id) async {
    return _queryAdapter.queryList(
        'select * from OrderInvoiceMapping where customerId=?1',
        mapper: (Map<String, Object?> row) => OrderInvoiceMapping(
            id: row['id'] as int,
            orderId: row['orderId'] as int,
            date: row['date'] as String,
            secondaryInvoiceSerialNumber:
                row['secondaryInvoiceSerialNumber'] as String,
            distributorId: row['distributorId'] as int,
            fyId: row['fyId'] as int,
            jcId: row['jcId'] as int,
            customerId: row['customerId'] as int,
            deliveryStatus: row['deliveryStatus'] as int,
            subscriberId: row['subscriberId'] as int,
            vehicleId: row['vehicleId'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?),
        arguments: [id]);
  }

  @override
  Future<List<OrderInvoiceMapping>?> getInvoiceListBasedOnCustomerAndDate(
      int id, String startDate, String endDate) async {
    return _queryAdapter.queryList(
        'select * from OrderInvoiceMapping where customerId=?1 and strftime(\"%Y-%m-%d\",?2 )<=strftime(\"%Y-%m-%d\",date) and strftime(\"%Y-%m-%d\",?3 )>=strftime(\"%Y-%m-%d\",date)',
        mapper: (Map<String, Object?> row) => OrderInvoiceMapping(id: row['id'] as int, orderId: row['orderId'] as int, date: row['date'] as String, secondaryInvoiceSerialNumber: row['secondaryInvoiceSerialNumber'] as String, distributorId: row['distributorId'] as int, fyId: row['fyId'] as int, jcId: row['jcId'] as int, customerId: row['customerId'] as int, deliveryStatus: row['deliveryStatus'] as int, subscriberId: row['subscriberId'] as int, vehicleId: row['vehicleId'] as int?, createdBy: row['created_by'] as int?, createdOn: row['created_on'] as String?, modifiedBy: row['modified_by'] as int?, modifiedOn: row['modified_on'] as String?),
        arguments: [id, startDate, endDate]);
  }

  @override
  Future<List<OrderInvoiceMapping>?> getInvoiceListBasedOnCustomerAndOrderId(
      int id, int orderId) async {
    return _queryAdapter.queryList(
        'select * from OrderInvoiceMapping where customerId=?1 and orderId=?2',
        mapper: (Map<String, Object?> row) => OrderInvoiceMapping(
            id: row['id'] as int,
            orderId: row['orderId'] as int,
            date: row['date'] as String,
            secondaryInvoiceSerialNumber:
                row['secondaryInvoiceSerialNumber'] as String,
            distributorId: row['distributorId'] as int,
            fyId: row['fyId'] as int,
            jcId: row['jcId'] as int,
            customerId: row['customerId'] as int,
            deliveryStatus: row['deliveryStatus'] as int,
            subscriberId: row['subscriberId'] as int,
            vehicleId: row['vehicleId'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?),
        arguments: [id, orderId]);
  }

  @override
  Future<List<OrderInvoiceMapping>?> getInvoiceListForOpeningBalance(
      int id, String startDate) async {
    return _queryAdapter.queryList(
        'select * from OrderInvoiceMapping where customerId=?1 and strftime(\"%Y-%m-%d\",?2 )>strftime(\"%Y-%m-%d\",date)',
        mapper: (Map<String, Object?> row) => OrderInvoiceMapping(id: row['id'] as int, orderId: row['orderId'] as int, date: row['date'] as String, secondaryInvoiceSerialNumber: row['secondaryInvoiceSerialNumber'] as String, distributorId: row['distributorId'] as int, fyId: row['fyId'] as int, jcId: row['jcId'] as int, customerId: row['customerId'] as int, deliveryStatus: row['deliveryStatus'] as int, subscriberId: row['subscriberId'] as int, vehicleId: row['vehicleId'] as int?, createdBy: row['created_by'] as int?, createdOn: row['created_on'] as String?, modifiedBy: row['modified_by'] as int?, modifiedOn: row['modified_on'] as String?),
        arguments: [id, startDate]);
  }

  @override
  Future<bool?> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from OrderInvoiceMapping where id = ?1',
        arguments: [id]);
  }

  @override
  Future<bool?> deleteAllData() async {
    await _queryAdapter.queryNoReturn('delete from OrderInvoiceMapping');
  }

  @override
  Future<void> insertData(OrderInvoiceMapping productWithPriceModel) async {
    await _orderInvoiceMappingInsertionAdapter.insert(
        productWithPriceModel, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<OrderInvoiceMapping> productWithPriceModel) async {
    await _orderInvoiceMappingInsertionAdapter.insertList(
        productWithPriceModel, OnConflictStrategy.replace);
  }
}

class _$InvoiceItemDao extends InvoiceItemDao {
  _$InvoiceItemDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _invoiceItemInsertionAdapter = InsertionAdapter(
            database,
            'InvoiceItem',
            (InvoiceItem item) => <String, Object?>{
                  'secondaryInvoiceId': item.secondaryInvoiceId,
                  'productId': item.productId,
                  'hsnCode': item.hsnCode,
                  'cgst': item.cgst,
                  'sgst': item.sgst,
                  'igst': item.igst,
                  'billQuantity': item.billQuantity,
                  'schemeId': item.schemeId,
                  'weight': item.weight,
                  'basePrice': item.basePrice,
                  'discount': item.discount,
                  'deliveryStatus': item.deliveryStatus,
                  'batchNumber': item.batchNumber,
                  'expiryDate': item.expiryDate,
                  'uoM': item.uoM,
                  'grnId': item.grnId,
                  'receivedId': item.receivedId,
                  'orderItemId': item.orderItemId,
                  'pickAndPackRegisterId': item.pickAndPackRegisterId,
                  'id': item.id,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn,
                  'partnerId': item.partnerId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<InvoiceItem> _invoiceItemInsertionAdapter;

  @override
  Future<List<InvoiceItem>?> getAllData() async {
    return _queryAdapter.queryList('select * from InvoiceItem',
        mapper: (Map<String, Object?> row) => InvoiceItem(
            id: row['id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            secondaryInvoiceId: row['secondaryInvoiceId'] as int?,
            productId: row['productId'] as int?,
            hsnCode: row['hsnCode'] as String?,
            cgst: row['cgst'] as double?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            billQuantity: row['billQuantity'] as int?,
            schemeId: row['schemeId'] as int?,
            weight: row['weight'] as double?,
            basePrice: row['basePrice'] as double?,
            discount: row['discount'] as double?,
            deliveryStatus: row['deliveryStatus'] as int?,
            batchNumber: row['batchNumber'] as String?,
            expiryDate: row['expiryDate'] as String?,
            uoM: row['uoM'] as int?,
            grnId: row['grnId'] as int?,
            receivedId: row['receivedId'] as int?,
            orderItemId: row['orderItemId'] as int?,
            pickAndPackRegisterId: row['pickAndPackRegisterId'] as int?,
            partnerId: row['partnerId'] as int?));
  }

  @override
  Future<List<InvoiceItem>?> getInvoiceListBasedOnCustomer(int id) async {
    return _queryAdapter.queryList(
        'select * from InvoiceItem where customerId=?1',
        mapper: (Map<String, Object?> row) => InvoiceItem(
            id: row['id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            secondaryInvoiceId: row['secondaryInvoiceId'] as int?,
            productId: row['productId'] as int?,
            hsnCode: row['hsnCode'] as String?,
            cgst: row['cgst'] as double?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            billQuantity: row['billQuantity'] as int?,
            schemeId: row['schemeId'] as int?,
            weight: row['weight'] as double?,
            basePrice: row['basePrice'] as double?,
            discount: row['discount'] as double?,
            deliveryStatus: row['deliveryStatus'] as int?,
            batchNumber: row['batchNumber'] as String?,
            expiryDate: row['expiryDate'] as String?,
            uoM: row['uoM'] as int?,
            grnId: row['grnId'] as int?,
            receivedId: row['receivedId'] as int?,
            orderItemId: row['orderItemId'] as int?,
            pickAndPackRegisterId: row['pickAndPackRegisterId'] as int?,
            partnerId: row['partnerId'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<InvoiceItem>?> getInvoiceListBasedOnInvoice(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from InvoiceItem  WHERE secondaryInvoiceId IN (' +
            _sqliteVariablesForIds +
            ')',
        mapper: (Map<String, Object?> row) => InvoiceItem(
            id: row['id'] as int?,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            secondaryInvoiceId: row['secondaryInvoiceId'] as int?,
            productId: row['productId'] as int?,
            hsnCode: row['hsnCode'] as String?,
            cgst: row['cgst'] as double?,
            sgst: row['sgst'] as double?,
            igst: row['igst'] as double?,
            billQuantity: row['billQuantity'] as int?,
            schemeId: row['schemeId'] as int?,
            weight: row['weight'] as double?,
            basePrice: row['basePrice'] as double?,
            discount: row['discount'] as double?,
            deliveryStatus: row['deliveryStatus'] as int?,
            batchNumber: row['batchNumber'] as String?,
            expiryDate: row['expiryDate'] as String?,
            uoM: row['uoM'] as int?,
            grnId: row['grnId'] as int?,
            receivedId: row['receivedId'] as int?,
            orderItemId: row['orderItemId'] as int?,
            pickAndPackRegisterId: row['pickAndPackRegisterId'] as int?,
            partnerId: row['partnerId'] as int?),
        arguments: [...ids]);
  }

  @override
  Future<bool?> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from InvoiceItem where id = ?1',
        arguments: [id]);
  }

  @override
  Future<bool?> deleteAllData() async {
    await _queryAdapter.queryNoReturn('delete from InvoiceItem');
  }

  @override
  Future<void> insertInvoiceMapping(InvoiceItem productWithPriceModel) async {
    await _invoiceItemInsertionAdapter.insert(
        productWithPriceModel, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<InvoiceItem> productWithPriceModel) async {
    await _invoiceItemInsertionAdapter.insertList(
        productWithPriceModel, OnConflictStrategy.replace);
  }
}

class _$SalesReturnReasonDao extends SalesReturnReasonDao {
  _$SalesReturnReasonDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _salesReturnReasonInsertionAdapter = InsertionAdapter(
            database,
            'SalesReturnReason',
            (SalesReturnReason item) => <String, Object?>{
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id,
                  'subscriberId': item.subscriberId,
                  'distributorId': item.distributorId,
                  'name': item.name
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SalesReturnReason> _salesReturnReasonInsertionAdapter;

  @override
  Future<List<SalesReturnReason>?> getAllData() async {
    return _queryAdapter.queryList('Select * From SalesReturnReason',
        mapper: (Map<String, Object?> row) => SalesReturnReason(
            row['created_by'] as int?,
            row['created_on'] as String?,
            row['modified_by'] as int?,
            row['modified_on'] as String?,
            row['subscriberId'] as int?,
            row['distributorId'] as int?,
            row['name'] as String,
            row['id'] as int?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from SalesReturnReason where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertData(SalesReturnReason data) async {
    await _salesReturnReasonInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<SalesReturnReason> salesReturnList) async {
    await _salesReturnReasonInsertionAdapter.insertList(
        salesReturnList, OnConflictStrategy.replace);
  }
}

class _$LeaveDao extends LeaveDao {
  _$LeaveDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _leaveItemInsertionAdapter = InsertionAdapter(
            database,
            'Leave',
            (LeaveItem item) => <String, Object?>{
                  'id': item.id,
                  'fromDate': item.fromDate,
                  'toDate': item.toDate,
                  'isHalfDay':
                      item.isHalfDay == null ? null : (item.isHalfDay! ? 1 : 0),
                  'isFirstHalf': item.isFirstHalf == null
                      ? null
                      : (item.isFirstHalf! ? 1 : 0),
                  'leaveTypeId': item.leaveTypeId,
                  'remarks': item.remarks,
                  'approverRemark': item.approverRemark,
                  'leaveStatus': item.leaveStatus,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LeaveItem> _leaveItemInsertionAdapter;

  @override
  Future<List<LeaveItem>> getLeaveData() async {
    return _queryAdapter.queryList('Select * From Leave',
        mapper: (Map<String, Object?> row) => LeaveItem(
            id: row['id'] as int?,
            fromDate: row['fromDate'] as String?,
            toDate: row['toDate'] as String?,
            isHalfDay: row['isHalfDay'] == null
                ? null
                : (row['isHalfDay'] as int) != 0,
            isFirstHalf: row['isFirstHalf'] == null
                ? null
                : (row['isFirstHalf'] as int) != 0,
            leaveTypeId: row['leaveTypeId'] as int?,
            remarks: row['remarks'] as String?,
            approverRemark: row['approverRemark'] as String?,
            leaveStatus: row['leaveStatus'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?));
  }

  @override
  Future<List<LeaveItem>> getUnSyncOrder() async {
    return _queryAdapter.queryList('select* from Leave where isSync = 0',
        mapper: (Map<String, Object?> row) => LeaveItem(
            id: row['id'] as int?,
            fromDate: row['fromDate'] as String?,
            toDate: row['toDate'] as String?,
            isHalfDay: row['isHalfDay'] == null
                ? null
                : (row['isHalfDay'] as int) != 0,
            isFirstHalf: row['isFirstHalf'] == null
                ? null
                : (row['isFirstHalf'] as int) != 0,
            leaveTypeId: row['leaveTypeId'] as int?,
            remarks: row['remarks'] as String?,
            approverRemark: row['approverRemark'] as String?,
            leaveStatus: row['leaveStatus'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter
        .queryNoReturn('delete from Leave where id = ?1', arguments: [id]);
  }

  @override
  Future<bool?> deleteUnSyncData() async {
    await _queryAdapter.queryNoReturn('delete from Leave where isSync = 0');
  }

  @override
  Future<int> insertLeaveData(LeaveItem leaveData) {
    return _leaveItemInsertionAdapter.insertAndReturnId(
        leaveData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<LeaveItem> leaveList) async {
    await _leaveItemInsertionAdapter.insertList(
        leaveList, OnConflictStrategy.replace);
  }
}

class _$AttendanceDao extends AttendanceDao {
  _$AttendanceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _attendanceItemInsertionAdapter = InsertionAdapter(
            database,
            'Attendance',
            (AttendanceItem item) => <String, Object?>{
                  'status': item.status,
                  'attendanceStatus': item.attendanceStatus,
                  'approverRemark': item.approverRemark,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id,
                  'isSync': item.isSync
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AttendanceItem> _attendanceItemInsertionAdapter;

  @override
  Future<List<AttendanceItem>> getAttendance() async {
    return _queryAdapter.queryList('select * from Attendance',
        mapper: (Map<String, Object?> row) => AttendanceItem(
            status: row['status'] as int?,
            attendanceStatus: row['attendanceStatus'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?,
            approverRemark: row['approverRemark'] as String?,
            isSync: row['isSync'] as int?));
  }

  @override
  Future<List<AttendanceItem>> getUnSyncAttendance() async {
    return _queryAdapter.queryList('select * from Attendance where isSync = 0',
        mapper: (Map<String, Object?> row) => AttendanceItem(
            status: row['status'] as int?,
            attendanceStatus: row['attendanceStatus'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?,
            approverRemark: row['approverRemark'] as String?,
            isSync: row['isSync'] as int?));
  }

  @override
  Future<AttendanceItem?> updatePunchOut(
      int id, String endTime, int isSync, int modifiedBy) async {
    return _queryAdapter.query(
        'Update Attendance set modified_by= ?4, modified_on = ?2, isSync = ?3 where id = ?1',
        mapper: (Map<String, Object?> row) => AttendanceItem(status: row['status'] as int?, attendanceStatus: row['attendanceStatus'] as int?, created_by: row['created_by'] as int?, created_on: row['created_on'] as String?, modified_by: row['modified_by'] as int?, modified_on: row['modified_on'] as String?, id: row['id'] as int?, approverRemark: row['approverRemark'] as String?, isSync: row['isSync'] as int?),
        arguments: [id, endTime, isSync, modifiedBy]);
  }

  @override
  Future<bool?> deleteUnSyncData() async {
    await _queryAdapter
        .queryNoReturn('delete from Attendance where isSync = 0');
  }

  @override
  Future<int> insertAttendance(AttendanceItem attendanceData) {
    return _attendanceItemInsertionAdapter.insertAndReturnId(
        attendanceData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<AttendanceItem> attendanceList) async {
    await _attendanceItemInsertionAdapter.insertList(
        attendanceList, OnConflictStrategy.replace);
  }
}

class _$AttendanceDetailDao extends AttendanceDetailDao {
  _$AttendanceDetailDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _attendanceDetailsInsertionAdapter = InsertionAdapter(
            database,
            'AttendanceDetail',
            (AttendanceDetails item) => <String, Object?>{
                  'attendanceId': item.attendanceId,
                  'punchInTime': item.punchInTime,
                  'punchOutTime': item.punchOutTime,
                  'punchInMediaFileId': item.punchInMediaFileId,
                  'punchOutMediaFileId': item.punchOutMediaFileId,
                  'status': item.status,
                  'punchInImagePath': item.punchInImagePath,
                  'punchOutImagePath': item.punchOutImagePath,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id,
                  'isSync': item.isSync
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AttendanceDetails> _attendanceDetailsInsertionAdapter;

  @override
  Future<AttendanceDetails?> getAttendanceDetailData() async {
    return _queryAdapter.query('Select * From AttendanceDetail',
        mapper: (Map<String, Object?> row) => AttendanceDetails(
            attendanceId: row['attendanceId'] as int?,
            punchInTime: row['punchInTime'] as String?,
            punchOutTime: row['punchOutTime'] as String?,
            punchInMediaFileId: row['punchInMediaFileId'] as int?,
            punchOutMediaFileId: row['punchOutMediaFileId'] as int?,
            status: row['status'] as int?,
            punchInImagePath: row['punchInImagePath'] as String?,
            punchOutImagePath: row['punchOutImagePath'] as String?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            isSync: row['isSync'] as int?,
            id: row['id'] as int?));
  }

  @override
  Future<List<AttendanceDetails>> getUnSyncAttendanceDetailData() async {
    return _queryAdapter.queryList(
        'Select * From AttendanceDetail where isSync = 0',
        mapper: (Map<String, Object?> row) => AttendanceDetails(
            attendanceId: row['attendanceId'] as int?,
            punchInTime: row['punchInTime'] as String?,
            punchOutTime: row['punchOutTime'] as String?,
            punchInMediaFileId: row['punchInMediaFileId'] as int?,
            punchOutMediaFileId: row['punchOutMediaFileId'] as int?,
            status: row['status'] as int?,
            punchInImagePath: row['punchInImagePath'] as String?,
            punchOutImagePath: row['punchOutImagePath'] as String?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            isSync: row['isSync'] as int?,
            id: row['id'] as int?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from AttendanceDetail where id = ?1',
        arguments: [id]);
  }

  @override
  Future<AttendanceDetails?> updatePunchOutDetail(int id, String endTime,
      int isSync, int modifiedBy, String punchOutImagePath) async {
    return _queryAdapter.query(
        'Update AttendanceDetail set punchOutTime = ?2, modified_by= ?4, modified_on = ?2, punchOutImagePath = ?5, isSync = ?3 where attendanceId = ?1',
        mapper: (Map<String, Object?> row) => AttendanceDetails(attendanceId: row['attendanceId'] as int?, punchInTime: row['punchInTime'] as String?, punchOutTime: row['punchOutTime'] as String?, punchInMediaFileId: row['punchInMediaFileId'] as int?, punchOutMediaFileId: row['punchOutMediaFileId'] as int?, status: row['status'] as int?, punchInImagePath: row['punchInImagePath'] as String?, punchOutImagePath: row['punchOutImagePath'] as String?, created_by: row['created_by'] as int?, created_on: row['created_on'] as String?, modified_by: row['modified_by'] as int?, modified_on: row['modified_on'] as String?, isSync: row['isSync'] as int?, id: row['id'] as int?),
        arguments: [id, endTime, isSync, modifiedBy, punchOutImagePath]);
  }

  @override
  Future<bool?> deleteUnSyncData() async {
    await _queryAdapter
        .queryNoReturn('delete from AttendanceDetail where isSync = 0');
  }

  @override
  Future<int> insertAttendanceDetailData(
      AttendanceDetails attendanceDetailData) {
    return _attendanceDetailsInsertionAdapter.insertAndReturnId(
        attendanceDetailData, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(
      List<AttendanceDetails> attendanceDetailList) async {
    await _attendanceDetailsInsertionAdapter.insertList(
        attendanceDetailList, OnConflictStrategy.replace);
  }
}

class _$ActivityRegisterTypeDao extends ActivityRegisterTypeDao {
  _$ActivityRegisterTypeDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _activityRegisterTypeDataInsertionAdapter = InsertionAdapter(
            database,
            'ActivityRegisterType',
            (ActivityRegisterTypeData item) => <String, Object?>{
                  'name': item.name,
                  'status': item.status,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActivityRegisterTypeData>
      _activityRegisterTypeDataInsertionAdapter;

  @override
  Future<List<ActivityRegisterTypeData>> getAllData() async {
    return _queryAdapter.queryList('Select * From ActivityRegisterType',
        mapper: (Map<String, Object?> row) => ActivityRegisterTypeData(
            name: row['name'] as String?,
            status: row['status'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?));
  }

  @override
  Future<void> insertAllData(
      List<ActivityRegisterTypeData> activityTypeList) async {
    await _activityRegisterTypeDataInsertionAdapter.insertList(
        activityTypeList, OnConflictStrategy.replace);
  }
}

class _$ActivityRegisteredDao extends ActivityRegisteredDao {
  _$ActivityRegisteredDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _activityRegisteredItemInsertionAdapter = InsertionAdapter(
            database,
            'ActivityRegistered',
            (ActivityRegisteredItem item) => <String, Object?>{
                  'date': item.date,
                  'details': item.details,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'activityTypeId': item.activityTypeId,
                  'activityRegisterStatus': item.activityRegisterStatus,
                  'status': item.status,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on,
                  'id': item.id,
                  'isSync': item.isSync
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ActivityRegisteredItem>
      _activityRegisteredItemInsertionAdapter;

  @override
  Future<List<ActivityRegisteredItem>> getActivity(
      String startDate, String endDate) async {
    return _queryAdapter.queryList(
        'Select * From ActivityRegistered where DATE(created_on) between DATE(\"?1\") and DATE(\"?2\")',
        mapper: (Map<String, Object?> row) => ActivityRegisteredItem(date: row['date'] as String?, details: row['details'] as String?, startTime: row['startTime'] as String?, endTime: row['endTime'] as String?, activityTypeId: row['activityTypeId'] as int?, activityRegisterStatus: row['activityRegisterStatus'] as int?, status: row['status'] as int?, created_by: row['created_by'] as int?, created_on: row['created_on'] as String?, modified_by: row['modified_by'] as int?, modified_on: row['modified_on'] as String?, id: row['id'] as int?, isSync: row['isSync'] as int),
        arguments: [startDate, endDate]);
  }

  @override
  Future<List<ActivityRegisteredItem>> getUnSyncActivity() async {
    return _queryAdapter.queryList(
        'select* from ActivityRegistered where isSync = 0',
        mapper: (Map<String, Object?> row) => ActivityRegisteredItem(
            date: row['date'] as String?,
            details: row['details'] as String?,
            startTime: row['startTime'] as String?,
            endTime: row['endTime'] as String?,
            activityTypeId: row['activityTypeId'] as int?,
            activityRegisterStatus: row['activityRegisterStatus'] as int?,
            status: row['status'] as int?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?,
            id: row['id'] as int?,
            isSync: row['isSync'] as int));
  }

  @override
  Future<bool?> deleteUnSyncData() async {
    await _queryAdapter
        .queryNoReturn('delete from ActivityRegistered where isSync = 0');
  }

  @override
  Future<bool?> deleteActivityById(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from ActivityRegistered where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertAllData(List<ActivityRegisteredItem> activityList) async {
    await _activityRegisteredItemInsertionAdapter.insertList(
        activityList, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertActivityRegisterData(
      ActivityRegisteredItem activityRegisteredData) async {
    await _activityRegisteredItemInsertionAdapter.insert(
        activityRegisteredData, OnConflictStrategy.replace);
  }
}

class _$InvoiceStatementDao extends InvoiceStatementDao {
  _$InvoiceStatementDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _invoiceStatementItemInsertionAdapter = InsertionAdapter(
            database,
            'InvoiceStatement',
            (InvoiceStatementItem item) => <String, Object?>{
                  'customerId': item.customerId,
                  'invoiceId': item.invoiceId,
                  'paidBy': item.paidBy,
                  'referenceNumber': item.referenceNumber,
                  'amount': item.amount,
                  'distributorId': item.distributorId,
                  'subscriberId': item.subscriberId,
                  'fyId': item.fyId,
                  'jcId': item.jcId,
                  'isSync': item.isSync,
                  'visitId': item.visitId,
                  'id': item.id,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<InvoiceStatementItem>
      _invoiceStatementItemInsertionAdapter;

  @override
  Future<List<InvoiceStatementItem>?> getAllData() async {
    return _queryAdapter.queryList('select * from InvoiceStatement',
        mapper: (Map<String, Object?> row) => InvoiceStatementItem(
            id: row['id'] as int,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            customerId: row['customerId'] as int,
            invoiceId: row['invoiceId'] as int,
            paidBy: row['paidBy'] as int,
            referenceNumber: row['referenceNumber'] as String?,
            amount: row['amount'] as double?,
            distributorId: row['distributorId'] as int,
            subscriberId: row['subscriberId'] as int?,
            fyId: row['fyId'] as int,
            jcId: row['jcId'] as int,
            isSync: row['isSync'] as int?,
            visitId: row['visitId'] as int?));
  }

  @override
  Future<List<InvoiceStatementItem>?> getAllDataBasedOnInvoice(int id) async {
    return _queryAdapter.queryList(
        'select * from InvoiceStatement where invoiceId = ?1',
        mapper: (Map<String, Object?> row) => InvoiceStatementItem(
            id: row['id'] as int,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            customerId: row['customerId'] as int,
            invoiceId: row['invoiceId'] as int,
            paidBy: row['paidBy'] as int,
            referenceNumber: row['referenceNumber'] as String?,
            amount: row['amount'] as double?,
            distributorId: row['distributorId'] as int,
            subscriberId: row['subscriberId'] as int?,
            fyId: row['fyId'] as int,
            jcId: row['jcId'] as int,
            isSync: row['isSync'] as int?,
            visitId: row['visitId'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<InvoiceStatementItem>?> getInvoiceStatementBasedOnInvoices(
      List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    return _queryAdapter.queryList(
        'select * from InvoiceStatement  WHERE invoiceId IN (' +
            _sqliteVariablesForIds +
            ')',
        mapper: (Map<String, Object?> row) => InvoiceStatementItem(
            id: row['id'] as int,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            customerId: row['customerId'] as int,
            invoiceId: row['invoiceId'] as int,
            paidBy: row['paidBy'] as int,
            referenceNumber: row['referenceNumber'] as String?,
            amount: row['amount'] as double?,
            distributorId: row['distributorId'] as int,
            subscriberId: row['subscriberId'] as int?,
            fyId: row['fyId'] as int,
            jcId: row['jcId'] as int,
            isSync: row['isSync'] as int?,
            visitId: row['visitId'] as int?),
        arguments: [...ids]);
  }

  @override
  Future<InvoiceStatementItem?> getStatementBasedOnId(int id) async {
    return _queryAdapter.query('select * from InvoiceStatement where id = ?1',
        mapper: (Map<String, Object?> row) => InvoiceStatementItem(
            id: row['id'] as int,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            customerId: row['customerId'] as int,
            invoiceId: row['invoiceId'] as int,
            paidBy: row['paidBy'] as int,
            referenceNumber: row['referenceNumber'] as String?,
            amount: row['amount'] as double?,
            distributorId: row['distributorId'] as int,
            subscriberId: row['subscriberId'] as int?,
            fyId: row['fyId'] as int,
            jcId: row['jcId'] as int,
            isSync: row['isSync'] as int?,
            visitId: row['visitId'] as int?),
        arguments: [id]);
  }

  @override
  Future<InvoiceStatementItem?> getLatestStatementBasedOnInvoiceId(
      int id) async {
    return _queryAdapter.query(
        'select * from InvoiceStatement where invoiceId = ?1 and (created_on = (select max(d) from (select created_on d from InvoiceStatement union select modified_on d from InvoiceStatement)) or modified_on=(select max(d) from (select created_on d from InvoiceStatement union select modified_on d from InvoiceStatement)))',
        mapper: (Map<String, Object?> row) => InvoiceStatementItem(id: row['id'] as int, createdBy: row['created_by'] as int?, createdOn: row['created_on'] as String?, modifiedBy: row['modified_by'] as int?, modifiedOn: row['modified_on'] as String?, customerId: row['customerId'] as int, invoiceId: row['invoiceId'] as int, paidBy: row['paidBy'] as int, referenceNumber: row['referenceNumber'] as String?, amount: row['amount'] as double?, distributorId: row['distributorId'] as int, subscriberId: row['subscriberId'] as int?, fyId: row['fyId'] as int, jcId: row['jcId'] as int, isSync: row['isSync'] as int?, visitId: row['visitId'] as int?),
        arguments: [id]);
  }

  @override
  Future<List<InvoiceStatementItem>?> getUnSyncedStatements() async {
    return _queryAdapter.queryList(
        'select * from InvoiceStatement where isSync = 0',
        mapper: (Map<String, Object?> row) => InvoiceStatementItem(
            id: row['id'] as int,
            createdBy: row['created_by'] as int?,
            createdOn: row['created_on'] as String?,
            modifiedBy: row['modified_by'] as int?,
            modifiedOn: row['modified_on'] as String?,
            customerId: row['customerId'] as int,
            invoiceId: row['invoiceId'] as int,
            paidBy: row['paidBy'] as int,
            referenceNumber: row['referenceNumber'] as String?,
            amount: row['amount'] as double?,
            distributorId: row['distributorId'] as int,
            subscriberId: row['subscriberId'] as int?,
            fyId: row['fyId'] as int,
            jcId: row['jcId'] as int,
            isSync: row['isSync'] as int?,
            visitId: row['visitId'] as int?));
  }

  @override
  Future<bool?> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from InvoiceStatement where id = ?1',
        arguments: [id]);
  }

  @override
  Future<bool?> deleteUnSyncedData() async {
    await _queryAdapter
        .queryNoReturn('delete from InvoiceStatement where isSync = 0');
  }

  @override
  Future<bool?> deleteAllData() async {
    await _queryAdapter.queryNoReturn('delete from InvoiceStatement');
  }

  @override
  Future<void> insertInvoiceStatement(InvoiceStatementItem data) async {
    await _invoiceStatementItemInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertInvoiceStatements(List<InvoiceStatementItem> data) async {
    await _invoiceStatementItemInsertionAdapter.insertList(
        data, OnConflictStrategy.replace);
  }
}

class _$JourneyCycleDao extends JourneyCycleDao {
  _$JourneyCycleDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _journeyCycleDataInsertionAdapter = InsertionAdapter(
            database,
            'JourneyCycle',
            (JourneyCycleData item) => <String, Object?>{
                  'financialYearId': item.financialYearId,
                  'name': item.name,
                  'startDate': item.startDate,
                  'endDate': item.endDate,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<JourneyCycleData> _journeyCycleDataInsertionAdapter;

  @override
  Future<List<JourneyCycleData>?> getAllData() async {
    return _queryAdapter.queryList('Select * From JourneyCycle',
        mapper: (Map<String, Object?> row) => JourneyCycleData(
            row['financialYearId'] as int?,
            row['name'] as String?,
            row['startDate'] as String?,
            row['endDate'] as String?,
            row['created_by'] as int?,
            row['created_on'] as String?,
            row['modified_by'] as int?,
            row['modified_on'] as String?,
            row['id'] as int?));
  }

  @override
  Future<List<JourneyCycleData>?> getCurrentJourneyCycle(
      int financialYearId) async {
    return _queryAdapter.queryList(
        'select * from JourneyCycle where financialYearId = ?1 and DATE(\'now\') between DATE(startDate) and DATE(endDate)',
        mapper: (Map<String, Object?> row) => JourneyCycleData(row['financialYearId'] as int?, row['name'] as String?, row['startDate'] as String?, row['endDate'] as String?, row['created_by'] as int?, row['created_on'] as String?, row['modified_by'] as int?, row['modified_on'] as String?, row['id'] as int?),
        arguments: [financialYearId]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from JourneyCycle where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertJourneyCycleData(JourneyCycleData data) async {
    await _journeyCycleDataInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<JourneyCycleData> journeyCycleList) async {
    await _journeyCycleDataInsertionAdapter.insertList(
        journeyCycleList, OnConflictStrategy.replace);
  }
}

class _$FinancialYearDao extends FinancialYearDao {
  _$FinancialYearDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _financialYearDataInsertionAdapter = InsertionAdapter(
            database,
            'FinancialYear',
            (FinancialYearData item) => <String, Object?>{
                  'name': item.name,
                  'startDate': item.startDate,
                  'endDate': item.endDate,
                  'isCurrentYear': item.isCurrentYear ? 1 : 0,
                  'created_by': item.createdBy,
                  'created_on': item.createdOn,
                  'modified_by': item.modifiedBy,
                  'modified_on': item.modifiedOn,
                  'id': item.id
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<FinancialYearData> _financialYearDataInsertionAdapter;

  @override
  Future<List<FinancialYearData>?> getAllData() async {
    return _queryAdapter.queryList('Select * From FinancialYear',
        mapper: (Map<String, Object?> row) => FinancialYearData(
            row['name'] as String?,
            row['startDate'] as String?,
            row['endDate'] as String?,
            (row['isCurrentYear'] as int) != 0,
            row['created_by'] as int?,
            row['created_on'] as String?,
            row['modified_by'] as int?,
            row['modified_on'] as String?,
            row['id'] as int?));
  }

  @override
  Future<List<FinancialYearData>> getCurrentFinancialYear() async {
    return _queryAdapter.queryList(
        'select * from FinancialYear where isCurrentYear=1',
        mapper: (Map<String, Object?> row) => FinancialYearData(
            row['name'] as String?,
            row['startDate'] as String?,
            row['endDate'] as String?,
            (row['isCurrentYear'] as int) != 0,
            row['created_by'] as int?,
            row['created_on'] as String?,
            row['modified_by'] as int?,
            row['modified_on'] as String?,
            row['id'] as int?));
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn('delete from FinancialYear where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertFinancialYearData(FinancialYearData data) async {
    await _financialYearDataInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<FinancialYearData> financialYearList) async {
    await _financialYearDataInsertionAdapter.insertList(
        financialYearList, OnConflictStrategy.replace);
  }
}

class _$ClosingBalanceDao extends ClosingBalanceDao {
  _$ClosingBalanceDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database),
        _closingBalanceInsertionAdapter = InsertionAdapter(
            database,
            'ClosingBalance',
            (ClosingBalance item) => <String, Object?>{
                  'id': item.id,
                  'customerId': item.customerId,
                  'fyId': item.fyId,
                  'obAmount': item.obAmount,
                  'cbAmount': item.cbAmount,
                  'created_by': item.created_by,
                  'created_on': item.created_on,
                  'modified_by': item.modified_by,
                  'modified_on': item.modified_on
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ClosingBalance> _closingBalanceInsertionAdapter;

  @override
  Future<List<ClosingBalance>?> getAllData() async {
    return _queryAdapter.queryList('Select * From ClosingBalance',
        mapper: (Map<String, Object?> row) => ClosingBalance(
            id: row['id'] as int?,
            customerId: row['customerId'] as int?,
            fyId: row['fyId'] as int?,
            obAmount: row['obAmount'] as double?,
            cbAmount: row['cbAmount'] as double?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?));
  }

  @override
  Future<List<ClosingBalance>?> getCurrentFinancialYearOpeningBalance(
      int customerId, int fyId) async {
    return _queryAdapter.queryList(
        'select *  from ClosingBalance where customerId =?1 and fyId=?2',
        mapper: (Map<String, Object?> row) => ClosingBalance(
            id: row['id'] as int?,
            customerId: row['customerId'] as int?,
            fyId: row['fyId'] as int?,
            obAmount: row['obAmount'] as double?,
            cbAmount: row['cbAmount'] as double?,
            created_by: row['created_by'] as int?,
            created_on: row['created_on'] as String?,
            modified_by: row['modified_by'] as int?,
            modified_on: row['modified_on'] as String?),
        arguments: [customerId, fyId]);
  }

  @override
  Future<void> deleteData(int id) async {
    await _queryAdapter.queryNoReturn(
        'delete from ClosingBalance where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> insertClosingBalanceData(ClosingBalance data) async {
    await _closingBalanceInsertionAdapter.insert(
        data, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertAllData(List<ClosingBalance> data) async {
    await _closingBalanceInsertionAdapter.insertList(
        data, OnConflictStrategy.replace);
  }
}
