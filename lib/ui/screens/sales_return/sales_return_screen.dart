import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/add_sales_return/add_sales_return_bloc.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/shared_preference_service.dart';
import '../base/base_screen.dart';
import '../sales_return_history/sales_retuen_history_screen.dart';
import 'sales_return_form_widget.dart';

class SalesReturnScreen extends StatefulWidget {
  CustomerDataItemsResponse outletInfo;

  SalesReturnScreen({required this.outletInfo, Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SalesReturnScreenState();
}

class _SalesReturnScreenState extends State<SalesReturnScreen>
    with UtilityMixin {
  late AddSalesReturnBloc _bloc;

  List<ProductListDataItemsResponse> _productList = [];
  List<DistributionData> _distributorList = [];
  List<WarehouseDataItemsResponse> _warehouseList = [];
  List<SalesReturnReason> _reasonList = [];
  List<OrderInvoiceMapping> _invoiceList = [];
  final TextEditingController _batchNumberController = TextEditingController();
  final TextEditingController _damagedController = TextEditingController();
  final TextEditingController _sellableController = TextEditingController();
  ProductListDataItemsResponse? selectedProduct;
  WarehouseDataItemsResponse? selectedWarehouse;
  SalesReturnReason? selectedReason;
  OrderInvoiceMapping? selectedInvoice;
  DistributionData? selectedDistributor;
  int? selectedUOM;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => BaseScreen<AddSalesReturnBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(const GetProductList());
      },
      builder: (context, bloc, child) =>
          BlocListener<AddSalesReturnBloc, BaseState>(
              listener: (context, state) {
                if (state is ProductSuccessState) {
                  for (final data in state.data) {
                    _productList.add(
                        ProductListDataItemsResponse.fromJsonForRowQuery(data));
                  }
                  _bloc.add(const GetReasonList());
                } else if (state is ProductFailedState) {
                } else if (state is GetReasonSuccessState) {
                  setState(() {
                    _reasonList = state.data ?? [];
                  });
                  _bloc.add(GetDistributorList(widget.outletInfo.id!));
                } else if (state is GetReasonFailedState) {
                } else if (state is GetDistributorAndWarehouseSuccessState) {
                  _warehouseList = [];
                  _distributorList = [];
                  setState(() {
                    _warehouseList = state.warehouseData;
                    for (final distributor in state.distributorData) {
                      _distributorList.add(
                          DistributionData.fromJsonForRowQuery(distributor));
                    }
                  });
                  _bloc.add(GetInvoiceList(widget.outletInfo.id!));
                } else if (state is GetDistributorAndWarehouseFailedState) {
                  _bloc.add(GetInvoiceList(widget.outletInfo.id!));
                } else if (state is GetInvoiceSuccessState) {
                  _invoiceList = state.data;
                } else if (state is GetInvoiceFailedState) {
                } else if (state is AddSalesReturnSuccessState) {
                  Navigator.pop(context);
                } else if (state is AddSalesReturnFailedState) {}
              },
              child: Scaffold(
                appBar: CustomAppBar(
                  title: AppStrings.lblSalesReturn,
                  hasBack: true,
                ),
                body: SafeArea(
                  child: CommonContainer(
                    hasTimer: true,
                    topLayout: CommonDetailedHeader(
                      hasExtraPadding: true,
                      screenName: '',
                      outletName: widget.outletInfo.businessName,
                      retailerLocation: widget.outletInfo.routeName,
                      retailerType: widget.outletInfo.customerTypeName,
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                NameNumberWidget(
                                    retailerName:
                                        widget.outletInfo.contactPersonName,
                                    number: widget.outletInfo.mobileNumber),
                                const SizedBox(
                                  height: 20,
                                ),
                                SalesReturnFormWidget(
                                  formKey: _formKey,
                                  productList: _productList,
                                  reasonList: _reasonList,
                                  distributorList: _distributorList,
                                  warehouseList: _warehouseList,
                                  invoiceList: _invoiceList,
                                  batchNumberController: _batchNumberController,
                                  damagedController: _damagedController,
                                  sellableController: _sellableController,
                                  selectedDistributor: (supplier) {
                                    selectedDistributor = supplier;
                                  },
                                  selectedInvoice: (invoice) {
                                    selectedInvoice = invoice;
                                  },
                                  selectedProduct: (product) {
                                    selectedProduct = product;
                                  },
                                  selectedReason: (reason) {
                                    selectedReason = reason;
                                  },
                                  selectedUOM: (UOM) {
                                    selectedUOM = UOM;
                                  },
                                  selectedWarehouse: (warehouse) {
                                    selectedWarehouse = warehouse;
                                  },
                                )
                              ],
                            ),
                          ),
                        ),
                        CommonBottomButton(
                            btnText1: AppStrings.lblReturnHistory,
                            btnText2: AppStrings.lblSUBMIT,
                            onPress1: () async {
                             await navigationWithAwaitPush(
                                  context,
                                  SalesReturnHistoryScreen(
                                    outletInfo: widget.outletInfo,
                                  ));
                             setState(() {

                             });
                            },
                            onPrese2: onSubmitCalled)
                      ],
                    ),
                  ),
                ),
              )));

  void onSubmitCalled() async {
    if (_formKey.currentState?.validate() ?? false) {
      showCustomDialog(context, AppStrings.msgAreYouSureToAddSalesReturn,
          AppStrings.lblSubmitSalesReturn, AppStrings.lblYes,
          yesOnPressed: _confirmSubmitCalled,
          no: AppStrings.lblNo,
          noOnPressed: () {});
    }
  }

  void _confirmSubmitCalled() async {
    final currentDate = '${DateTime.now().toIso8601String()}+05:30';
    final userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    var visitId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.visitId);
    if (visitId == null || visitId == 0) {
      visitId = await SharedPreferenceService()
          .getIntValuesSF(SharedPrefsConstants.scopeId);
    }
    var salesReturn = SalesReturnItem(
        created_by: userId,
        created_on: currentDate,
        id: generateRandomNumber(),
        returnDate: currentDate,
        warehouseId: selectedWarehouse?.id,
        customerId: widget.outletInfo.id,
        productId: selectedProduct?.id,
        secondaryInvoiceId: selectedInvoice?.id,
        rate: 0.0,
        storageId: null,
        sellableQuantity: double.tryParse(_sellableController.text),
        damagedQuantity: double.tryParse(_damagedController.text),
        uoM: selectedUOM,
        reasonId: selectedReason?.id,
        fyId: 0, //updating value in bloc event
        jcId: 0, //updating value in bloc event
        remark: "",
        grnId: null,
        rId: null,
        subscriberId: 1,
        distributorId: selectedDistributor?.id,
        batchNumber: _batchNumberController.text,
        cgst: 0,
        sgst: 0,
        igst: 0,
        isApprove: false,
        isCancel: false,
        isSync: SyncStatus.unSync,
        visitId: visitId);
    _bloc.add(InsertIntoDBList(salesReturn));
  }
}
