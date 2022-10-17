import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/modify_outlets/modify_outlet_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../data/models/route/get_route_by_user_items.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../../../services/shared_preference_service.dart';
import '../base/base_screen.dart';
import '../outlet_albums/outlet_album_screen.dart';
import 'modify_outlet_form_widget.dart';

class ModifyOutletScreen extends StatefulWidget {
  ModifyOutletScreen({
    required this.isFromRouteInfo,
    this.outletInfo,
    Key? key,
  }) : super(key: key);

  CustomerDataItemsResponse? outletInfo = CustomerDataItemsResponse();
  bool isFromRouteInfo;

  @override
  State<StatefulWidget> createState() => _ModifyOutletScreenState();
}

class _ModifyOutletScreenState extends State<ModifyOutletScreen>
    with UtilityMixin {
  final _formKey = GlobalKey<FormState>();
  DateTime now = DateTime.now();
  late ModifyOutletBloc _bloc;
  List<CustomerTypeDataResponse> customerTypeList = [];
  List<CustomerCategoryDataResponse> customerCategoryList = [];
  List<DistributionData>? _supplierList = [];
  List<RouteItems>? _routeList = [];
  int userId = 0;
  List<DistributionData> selectedSupplierList = [];
  CustomerDataItemsResponse? outletData = CustomerDataItemsResponse();

  @override
  void initState() {
    super.initState();
    if (!widget.isFromRouteInfo) {
      final List<CustomerAddressResponse> address = [];
      address.addAll(widget.outletInfo!.customerAddress!);
      outletData = CustomerDataItemsResponse(
        id: widget.outletInfo?.id,
        isSync: widget.outletInfo?.isSync,
        contactPersonName: widget.outletInfo?.contactPersonName,
        businessName: widget.outletInfo?.businessName,
        mobileNumber: widget.outletInfo?.mobileNumber,
        emailAddress: widget.outletInfo?.emailAddress,
        pincode: widget.outletInfo?.pincode,
        gstin: widget.outletInfo?.gstin,
        routeId: widget.outletInfo?.routeId,
        routeName: widget.outletInfo?.routeName,
        customerType: widget.outletInfo?.customerType,
        customerTypeName: widget.outletInfo?.customerTypeName,
        isActive: widget.outletInfo?.isActive,
        distributorId_1: widget.outletInfo?.distributorId_1,
        distributorId_2: widget.outletInfo?.distributorId_2,
        distributorId_3: widget.outletInfo?.distributorId_3,
        customerCategory: widget.outletInfo?.customerCategory,
        customerCategoryName: widget.outletInfo?.customerCategoryName,
        createdBy: widget.outletInfo?.createdBy,
        createdOn: widget.outletInfo?.createdOn,
        isSystemGenerated: widget.outletInfo?.isSystemGenerated,
        modifiedBy: widget.outletInfo?.modifiedBy,
        modifiedOn: widget.outletInfo?.modifiedOn,
        customerAddress: address,
      );
    }
    getUserId();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BaseScreen<ModifyOutletBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetCustomerTypeFromDBEvent());
      },
      builder: (context, bloc, child) => BlocListener<ModifyOutletBloc,
              BaseState>(
          listener: (context, state) {
            if (state is GetCustomerTypeFromDBSuccessState) {
              customerTypeList = state.data;
              print("customerTypeList ${customerTypeList.length}");
              _bloc.add(GetCustomerCategoryFromDBEvent());
            } else if (state is GetCustomerTypeFromDBFailedState) {
              _bloc.add(GetCustomerCategoryFromDBEvent());
              showCustomFlushBar(context, state.msg ?? "");
            } else if (state is GetCustomerCategoryFromDBSuccessState) {
              customerCategoryList = state.data;
              print("customerCategoryList ${customerCategoryList.length}");
              _bloc.add(GetSupplierInOutletFromDB());
            } else if (state is GetCustomerCategoryFromDBFailedState) {
              _bloc.add(GetSupplierInOutletFromDB());
              showCustomFlushBar(context, state.msg ?? "");
            } else if (state is SupplierInOutletSuccessState ||
                state is SupplierInOutletFailedState) {
              _manageSupplierState(state);
            } else if (state is RouteSuccessState ||
                state is RouteFailedState) {
              _manageRouteState(state);
            } else if (state is SuccessState || state is FailedState) {
              _manageAddOutletState(state);
            } else if (state is UpdateCustomerTableSuccessState ||
                state is UpdateCustomerTableFailedState) {
              _manageUpdateCustomerTableState(state);
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: widget.isFromRouteInfo
                  ? AppStrings.lblAddOutlet
                  : AppStrings.lblModifyOutlet,
              hasBack: true,
            ),
            body: SafeArea(
              child: CommonContainer(
                hasTimer: !widget.isFromRouteInfo,
                topLayout: !widget.isFromRouteInfo
                    ? CommonDetailedHeader(
                        screenName: 'Modify Outlet',
                        outletName: outletData?.businessName ?? '',
                        retailerLocation: outletData?.routeName ?? '',
                        retailerType: outletData?.customerTypeName ?? '',
                        date: getCurrentDate(),
                        showActions: true,
                        hasExtraPadding: true,
                        cameraOnTap: () {
                          ApiService().checkInternet().then((internet) {
                            if (internet) {
                              navigationPush(
                                  context,
                                  OutletAlbumScreen(
                                    isFromRouteInfo: widget.isFromRouteInfo,
                                    outletInfo: outletData,
                                  ));
                            } else {
                              showNoInternetDialog(context);
                            }
                          });
                        })
                    : const SizedBox(
                        height: 10,
                      ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              if (widget.isFromRouteInfo == false)
                                NameNumberWidget(
                                    retailerName:
                                        outletData?.contactPersonName ?? "",
                                    number: outletData?.mobileNumber ?? "")
                              else
                                Container(
                                  height: 0,
                                ),
                              Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                  child: ModifyOutletFormWidget(
                                    isFromRoute: widget.isFromRouteInfo,
                                    customerType: customerTypeList,
                                    customerCategoryList: customerCategoryList,
                                    customerData: outletData,
                                    supplierList: _supplierList,
                                    routeList: _routeList,
                                    formKey: _formKey,
                                    selectedSupplierList: selectedSupplierList,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      appCommonFlatButton(
                          btnTxt: AppStrings.lblSave.toUpperCase(),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              showCustomDialog(
                                  context,
                                  AppStrings.msgAreYouSure,
                                  AppStrings.lblAddEditOutlet,
                                  AppStrings.lblYes,
                                  yesOnPressed: _onPressedSave,
                                  no: AppStrings.lblNo,
                                  noOnPressed: () {});
                            }
                          })
                    ]),
              ),
            ),
          )));

  void _manageSupplierState(state) {
    if (state is SupplierInOutletSuccessState) {
      _supplierList = state.data;
      _supplierList?.forEach((element) {
        if (outletData?.distributorId_1 != null &&
            element.id == outletData?.distributorId_1) {
          selectedSupplierList.add(element);
        } else if (outletData?.distributorId_2 != null &&
            element.id == outletData?.distributorId_2) {
          selectedSupplierList.add(element);
        } else if (outletData?.distributorId_3 != null &&
            element.id == outletData?.distributorId_3) {
          selectedSupplierList.add(element);
        }
      });
      _bloc.add(GetRouteListFromDB());
    } else {
      _bloc.add(GetRouteListFromDB());
      showCustomFlushBar(context, state.msg ?? "");
    }
  }

  void _manageRouteState(state) {
    if (state is RouteSuccessState) {
      _routeList = state.data;
    } else {
      showCustomFlushBar(context, state.msg ?? "");
    }
  }

  void _manageAddOutletState(state) {
    if (state is SuccessState) {
      final AddCustomerResponse data = state.data;
      outletData?.id = data.data?.id;
      outletData?.customerAddress = data.data?.customerAddress;
      _bloc.add(UpdateCustomerTable(customerDataItemsResponse: outletData!));
    } else {
      print('manage customer API call fail');
      showCustomFlushBar(context, state.msg ?? "");
    }
  }

  void _manageUpdateCustomerTableState(state) {
    if (state is UpdateCustomerTableSuccessState) {
      Navigator.pop(context, outletData);
    } else {
      showCustomFlushBar(context, state.msg ?? "");
    }
  }

  getUserId() async {
    await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId)
        .then((value) => {userId = value});
  }

  void _onPressedSave() {
    if (selectedSupplierList.length == 3) {
      outletData?.distributorId_1 = selectedSupplierList[0].id;
      outletData?.distributorId_2 = selectedSupplierList[1].id;
      outletData?.distributorId_3 = selectedSupplierList[2].id;
    }
    if (selectedSupplierList.length == 2) {
      outletData?.distributorId_1 = selectedSupplierList[0].id;
      outletData?.distributorId_2 = selectedSupplierList[1].id;
    }
    if (selectedSupplierList.length == 1) {
      outletData?.distributorId_1 = selectedSupplierList[0].id;
    }
    outletData?.isActive = true;
    if (widget.isFromRouteInfo == false) {
      outletData?.modifiedOn = getCurrentDateAndTime();
      outletData?.modifiedBy = userId;
      outletData?.createdOn = outletData?.createdOn;
      outletData?.createdBy = outletData?.createdBy;
    } else {
      outletData?.createdOn = getCurrentDateAndTime();
      outletData?.createdBy = userId;
    }
    outletData?.id = widget.isFromRouteInfo ? 0 : outletData?.id;
    ApiService().checkInternet().then((internet) {
      if (internet) {
        if (outletData?.customerAddress?.length == null ||
            outletData?.customerAddress?.length! == 0) {
          showCustomDialog(context, AppStrings.msgAddMinimumOneAddress,
              AppStrings.lblAddAddress, AppStrings.ok,
              yesOnPressed: () {});
        } else {
          outletData?.customerAddress?.forEach((element) {
            element.createdBy = userId;
            element.createdOn = getCurrentDateAndTime();
            element.isActive = true;
          });
          _bloc.add(AddOutlet(customerDataItemsResponse: outletData!));
        }
      } else {
        showNoInternetDialog(context,
            content: AppStrings.msgCheckInternetForAddOutlet);
      }
    });
  }
}
