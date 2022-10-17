import 'dart:io';

import 'package:cygneto/data/models/financial_year/financial_year_response.dart';
import 'package:cygneto/data/models/journey_cycle/journey_cycle_response.dart';
import 'package:cygneto/data/models/no_order/no_order_response.dart';
import 'package:cygneto/data/models/sales_return/sales_return_history_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../data/models/AvailableStock/available_stock_request.dart';
import '../data/models/AvailableStock/available_stock_response.dart';
import '../data/models/closing_balance/closing_balance_response.dart';
import '../data/models/district/district_request.dart';
import '../data/models/district/district_response.dart';
import '../data/models/image_folder/image_folder_request.dart';
import '../data/models/image_folder/image_folder_response.dart';
import '../data/models/invoice/get_invoice_response.dart';
import '../data/models/invoice/invoice_statement_response.dart';
import '../data/models/invoice/manage_payment_collection_request.dart';
import '../data/models/location/location_request.dart';
import '../data/models/order_item/order_item_response.dart';
import '../data/models/order_record/order_record_response.dart';
import '../data/models/product_group_list/product_group_request.dart';
import '../data/models/product_pricing_list/product_pricing_request.dart';
import '../data/models/product_trends/product_trend_status_item.dart';
import '../data/models/route/get_route_by_user_parent.dart';
import '../data/models/route/get_route_by_user_request.dart';
import '../data/models/sales_return/sales_return_item.dart';
import '../data/models/sales_return/sales_return_reason_response.dart';
import '../data/models/sales_return/sales_return_request.dart';
import '../data/models/unitofmeasurement/unit_of_measurement_response.dart';
import '../data/models/visit/manage_punch_response.dart';
import '../data/models/visit_order_mapping/visit_order_response.dart';
import '../exports/constants.dart';
import '../exports/models.dart';

part 'api_client.g.dart';

/// Created by Dev 1051 on 7/13/2021
/// Modified by Dev 1051 on 7/13/2021
/// Purpose : This is a API client class used to prepare api client object with
/// api references.
@RestApi(baseUrl: APIEnvironment.staging)
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST(APIPath.login)
  Future<LoginResponse> doLogin(@Body() LoginRequest request);

  @POST(APIPath.forgotPin)
  Future<ForgotPinResponse> doForgotPin(@Body() ForgotPinRequest request);

  @POST(APIPath.verifyOTP)
  Future<VerifyOtpResponse> doVerifyOTP(@Body() VerifyOtpRequest request);

  @POST(APIPath.resetPin)
  Future<ResetPinResponse> doResetPin(@Body() ResetPinRequest request);

  @POST(APIPath.state)
  Future<StateResponse> getState(@Body() StateRequest request);

  @POST(APIPath.customerType)
  Future<CustomerTypeResponse> getCustomerType(
      @Body() CustomerTypeRequest request);

  @POST(APIPath.customer)
  Future<CustomerResponse> getCustomer(@Body() CustomerRequest request);

  @POST(APIPath.productList)
  Future<ProductListResponse> getProductList(
      @Body() ProductListRequest request);

  @POST(APIPath.warehouse)
  Future<WarehouseResponse> getWarehouse(@Body() WarehouseRequest request);

  @POST(APIPath.getVisitPartners)
  Future<VisitPartnersResponse> getVisitPartners(
      @Body() VisitPartnersRequest request);

  @POST(APIPath.getSchemeList)
  Future<SchemeListResponse> getSchemeList(@Body() SchemeListRequest request);

  @POST(APIPath.getProductCategoryList)
  Future<ProductCategoryListResponse> getProductCategoryList(
      @Body() ProductCategoryListRequest request);

  @POST(APIPath.visit)
  Future<VisitResponse> getVisit(@Body() VisitRequest request);

  //getRouteByUser api

  @POST(APIPath.getRoutesByUser)
  Future<GetRouteByUserParent> doGetRouteByUser(
      @Body() GetRouteByUserRequest request);

  //district api call
  @POST(APIPath.district)
  Future<DistrictResponse> doDistrictCall(@Body() DistrictRequest request);

  //distribution api call
  @POST(APIPath.distribution)
  Future<DistributionResponse> doDistributionCall(
      @Body() DistributionRequest request);

  //unit of measurement

  @POST(APIPath.unitOfMeasurement)
  Future<UOMResponse> doUnitOfMeasurementCall(@Body() UOMRequest request);

  //product group list  api call
  @POST(APIPath.productGroupList)
  Future<ProductGroupResponse> doProductGroupListCall(
      @Body() ProductGroupRequest request);

  //product pricing list  api call
  @POST(APIPath.productPricingList)
  Future<ProductPricingResponse> doProductPricingListCall(
      @Body() ProductPricingRequest request);

  //product schema register list  api call
  @POST(APIPath.productSchemaRegisterList)
  Future<ProductSchemaResponse> doProductSchemaRegisterListCall(
      @Body() ProductSchemaRequset request);

  //country  list  api call
  @GET(APIPath.country)
  Future<CountryResponse> doCountryListCall();

  //location  list  api call
  @POST(APIPath.location)
  Future<LocationResponse> doLocationListCall(@Body() LocationRequest request);

  //customer category  list  api call
  @POST(APIPath.customerCategory)
  Future<CustomerCategoryResponse> doCustomerCategoryListApiCall(
      @Body() CustomerCategoryRequest request);

  //Image Folder List api call
  @POST(APIPath.imageFolder)
  Future<ImageFolderResponse> doImageFolderListCall(
      @Body() ImageFolderRequest request);

  //Visit punch in-out Api call
  @POST(APIPath.manageVisitPunch)
  Future<ManagePunchResponse> manageVisitPunchCall(
      @Body() ManageVisitPunchRequest request);

  @POST(APIPath.availableStock)
  Future<AvailableStockResponse> getAvailableStock(
      @Body() AvailableStockRequest request);

  //Order Record History API call
  @POST(APIPath.orderRecordList)
  Future<OrderRecordResponse> getOrderRecordListCall(
      @Body() OrderRecordRequest request);

  //Order Item for record Api call
  @POST(APIPath.orderItemList)
  Future<OrderItemResponse> getOrderItemListCall(
      @Body() OrderItemRequest request);

  ///used same request object as above because we have to send the same request
  ///(only timestamp) in visit order mapping api
  @POST(APIPath.getVisitOrderMapping)
  Future<VisitOrderResponse> getVisitOrderMapping(
      @Body() OrderItemRequest request);

  ///used same response object as above because we have to receive the same response
  ///(succeeded,message,errors) in placeOrder Api
  //Place Order API call
  @POST(APIPath.placeOrder)
  Future<ManagePunchResponse> createPlaceOrderCall(
      @Body() OrderRecordDataResponse request);

  @POST(APIPath.productTrends)
  Future<ProductTrendStatusItem> getProductTrends(
      @Body() GetRouteByUserRequest request);

  @POST(APIPath.manageCustomer)
  Future<AddCustomerResponse> addOutlet(
      @Body() CustomerDataItemsResponse request);

  //Get Customer Image API call
  @POST(APIPath.customerImages)
  Future<CustomerImageResponse> getCustomerImages(
      @Body() SchemeListRequest request);

  //Image File API call
  @GET("${APIPath.downloadFile}{file_id}")
  Future<ImageFileResponse> getImageFile(@Path("file_id") id);

  //Get Customer Image API call
  @MultiPart()
  @POST(APIPath.uploadFile)
  Future<ManagePunchResponse> uploadCustomerImages(
      @Part(name: 'folderId') int folderId,
      @Part(name: 'CustomerId') int CustomerId,
      @Part(name: 'image') File image,
      @Part(name: 'IsCover') bool IsCover);

  ///used same request object as above because we have to send the same request
  ///(only timestamp) in NoOrder Type api
  @POST(APIPath.noOrderType)
  Future<NoOrderTypeResponse> getNoOrderType(@Body() OrderItemRequest request);

  ///used same response object as above because we have to receive the same response
  ///(succeeded,message,errors) in NoOrder Api
  //Place Order API call
  @POST(APIPath.manageNoOrder)
  Future<ManagePunchResponse> doNoOrderCall(
      @Body() List<NoOrderRequest> request);

  @POST(APIPath.noOrder)
  Future<NoOrderResponse> getNoOrder(@Body() SchemeListRequest request);

  @POST(APIPath.salesReturnHistory)
  Future<SalesReturnHistoryResponse>
  getSalesReturn(@Body() OrderRecordRequest request);

  @POST(APIPath.journeyCycle)
  Future<JourneyCycleResponse> getJourneyCycle(
      @Body() OrderRecordRequest request);

  @POST(APIPath.financialYear)
  Future<FinancialYearResponse> getFinancialYear(
      @Body() OrderRecordRequest request);

  @POST(APIPath.getInvoices)
  Future<GetInvoiceResponse>
  getInvoices(@Body() LocationRequest request);

  @POST(APIPath.getSalesReturnReasons)
  Future<SalesReturnReasonResponse>
  getSalesReturnReason(@Body() OrderRecordRequest request);

  @POST(APIPath.addSalesReturn)
  Future<GetInvoiceResponse> addSalesReturn(
      @Body() SalesReturnRequest request);

  //Leave Type List api call
  @POST(APIPath.leaveType)
  Future<LeaveTypeResponse> getLeaveType(@Body() OrderItemRequest request);

  //manage apply leave api call
  @POST(APIPath.applyLeave)
  Future<ManagePunchResponse> applyLeaveCall(
      @Body() LeaveItem request);

  //Leave Type List api call
  @POST(APIPath.leave)
  Future<LeaveResponse> getLeave(@Body() SchemeListRequest request);

  //Miss Punch API call
  @POST(APIPath.missPunch)
  Future<MissPunchResponse> getMissPunch(@Body() MissPunchRequest request);

  //manage apply leave api call
  @POST(APIPath.applyMissPunch)
  Future<ManagePunchResponse> applyMissPunchCall(@Body() MissPunchItem request);

  //attendance List api call
  @POST(APIPath.attendance)
  Future<AttendanceResponse> getAttendance(@Body() SchemeListRequest request);

  //Get Customer Image API call
  @MultiPart()
  @POST(APIPath.punchMediaFile)
  Future<PunchMediaFileResponse> uploadPunchImage(
      @Part(name: 'Module') int Module, @Part(name: 'image') File image);

//manage apply leave api call
  @POST(APIPath.saveAttendance)
  Future<ManagePunchResponse> uploadAttendance(
      @Body() UploadAttendanceRequest request);

  //Activity register Type List api call
  @POST(APIPath.activityRegisterType)
  Future<ActivityRegisterTypeResponse> getActivityRegisterType(
      @Body() OrderItemRequest request);

  //Order Item for record Api call
  @POST(APIPath.activityRegistered)
  Future<ActivityRegisteredResponse> getActivityRegistered(
      @Body() SchemeListRequest request);

  ///used same response object as above because we have to receive the same response
  ///(succeeded,message,errors) in NoOrder Api
  //Activity Register save call
  @POST(APIPath.saveActivityRegister)
  Future<ManagePunchResponse> saveActivityRegister(
      @Body() SaveActivityRegisterRequest request);

  //Invoice Statements  api call
  @POST(APIPath.getInvoiceStatements)
  Future<InvoiceStatementResponse> getInvoiceStatement(
      @Body() GetRouteByUserRequest request);

  @POST(APIPath.postInvoiceStatements)
  Future<InvoiceStatementResponse> postInvoiceStatement(
      @Body() ManagePaymentCollectionRequest request);

  @POST(APIPath.getClosingBalanceList)
  Future<ClosingBalanceResponse> getClosingBalanceList(
      @Body() ProductSchemaRequset request);

  //Image File API call
  @DELETE("${APIPath.deleteActivityRegister}{id}")
  Future<ManagePunchResponse> deleteActivity(@Path("id") id);
}
