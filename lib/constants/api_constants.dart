library apiconstants;

///base url for different environments
class APIEnvironment {
  // static const String prod = "https://test.com/";
  static const String prod = "https://apitestot.crowdcontrolhq.com/";
  static const String dev = "http://192.192.9.54:8072";
  static const String staging = "https://fsmapi.stagingapplications.com/";
}

class APIMethods {
  static const String get = "get";
  static const String put = "put";
  static const String post = "post";
  static const String delete = "delete";
}

class APIPath {
  //auth
  static const String login = "identity/Users/authenticate";
  static const String forgotPin = "identity/Users/forgotPin";
  static const String verifyOTP = "identity/Users/verifyOTP";
  static const String resetPin = "identity/Users/resetPin";
  static const String logout = "/api/user/mobile-logout";
  static const String state = "fieldSales/state";
  static const String customerType = "fieldSales/CustomerType";
  static const String customer = "fieldSales/customer";
  static const String productList = "fieldSales/Product/getProductList";
  static const String warehouse = "fieldSales/Warehouse";
  static const String getVisitPartners = "fieldSales/visit/GetVisitPartners";
  static const String getSchemeList = "fieldSales/Schemes/getSchemeList";
  static const String getProductCategoryList = "fieldSales/Product/getProductCategoryList";
  static const String visit = "fieldSales/Visit";
  static const String getRoutesByUser="fieldSales/Routes/GetByUser";
  static const String district="fieldSales/district";
  static const String distribution="fieldSales/distributor";
  static const String productGroupList="fieldSales/Product/getProductGroupList";
  static const String productPricingList="fieldSales/Product/getProductPricingList";
  static const String productSchemaRegisterList="fieldSales/ProductSchemeRegister/getProductSchemeRegisterList";
  static const String unitOfMeasurement="fieldSales/UnitOfMeasure";
  static const String country="fieldSales/country";
  static const String location="fieldSales/location";
  static const String customerCategory="fieldSales/CustomerCategory";
  static const String imageFolder="fieldSales/customer/ImageFolders";
  static const String manageVisitPunch="fieldSales/Visit/ManagePunchInOut";
  static const String availableStock = "fieldSales/Product/getAvailableStock";
  static const String orderRecordList="fieldSales/Order/getOrderRecordList";
  static const String orderItemList="fieldSales/Order/getOrderItemList";
  static const String getVisitOrderMapping="fieldSales/Order/getVisitOrderList";
  static const String placeOrder="fieldSales/Order/CreatePlaceOrder";
  static const String productTrends="fieldSales/Product/trends";
  static const String manageCustomer="distribution/Customer/manage";
  static const String customerImages="fieldSales/customer/images";
  static const String downloadFile="fieldSales/MediaFile/";
  static const String uploadFile="fieldSales/Customer/UploadImage";
  static const String noOrderType="fieldSales/NoOrder/getNoOrderType";
  static const String manageNoOrder="fieldSales/NoOrder/ManageNoOrder";
  static const String noOrder = "fieldSales/NoOrder";
  static const String salesReturnHistory="fieldSales/SalesReturn/getSalesReturnHistory";
  static const String journeyCycle="/fieldSales/FinancialYears/getJourneyCycleList";
  static const String financialYear="/fieldSales/FinancialYears/getFinancialYearList";
  static const String getInvoices="fieldSales/Accounts/invoices";
  static const String getSalesReturnReasons="fieldSales/SalesReturnReason/getSalesReturnReason";
  static const String addSalesReturn="fieldSales/SalesReturn/ManageSalesReturn";
  static const String getInvoiceStatements="fieldSales/Accounts/invoicestatements";
  static const String postInvoiceStatements="fieldSales/Accounts/managepaymentcollections";
  static const String getClosingBalanceList="fieldSales/customer/obmasters";

  static const String leaveType="fieldSales/LeaveType";
  static const String applyLeave="fieldSales/leaves/manage";
  static const String leave="fieldSales/leaves";
  static const String missPunch="fieldSales/MissedPunch/history";
  static const String applyMissPunch="fieldSales/MissedPunch/apply";
  static const String attendance="fieldSales/Attendance/";
  static const String punchMediaFile="fieldSales/MediaFile/upload";
  static const String saveAttendance="fieldSales/Attendance/Save";
  static const String activityRegisterType="fieldSales/ActivityType/";
  static const String activityRegistered="fieldSales/ActivityRegister";
  static const String saveActivityRegister="fieldSales/ActivityRegister/Save";
  static const String deleteActivityRegister="fieldSales/ActivityRegister/delete/";



}
