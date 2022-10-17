import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/visit_punch/visit_punch_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../../../services/shared_preference_service.dart';
import '../../widgets/dash_line_divider.dart';
import '../anaysis/analysis_screen.dart';
import '../base/base_screen.dart';
import '../cart/cart_item_list_widget.dart';
import '../outlet_info/outlet_info_screen.dart';

/// Created by Dev 2136 on 09/12/2021
/// Modified by Dev 2136 on 09/12/2021
/// Purpose : timeline retail info screen of the app
class TimelineRetailInfo extends StatefulWidget {
  TimelineRetailInfo(
      {this.startVisit = false,
      this.customerId = -1,
      this.orderId,
      this.noOrderId,
      this.selectedDate,
      Key? key})
      : super(key: key);

  final bool startVisit;
  int customerId = -1;
  int? orderId;
  int? noOrderId;
  String? selectedDate;

  @override
  _TimelineRetailInfoState createState() => _TimelineRetailInfoState();
}

class _TimelineRetailInfoState extends State<TimelineRetailInfo>
    with UtilityMixin {
  bool isJointVisit = false;
  List<VisitPartnersDataResponse> _visitPartnerList = [];
  CustomerDataItemsResponse _customerInfo = CustomerDataItemsResponse();
  List<VisitDataItemsResponse> _visitPunchList = [];
  VisitDataItemsResponse _lastVisit = VisitDataItemsResponse();
  late VisitPunchBloc _visitPunchBloc;
  bool isMakeOwner = false;
  VisitPartnersDataResponse? initialValue;
  int userId = 0;
  int punchId = 0;
  DateTime now = DateTime.now();
  List<ProductWithPriceModel> _orderList = [];
  NoOrderTypeData? _noOrderData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) => BaseScreen<VisitPunchBloc>(
        onBlocReady: (bloc) {
          _visitPunchBloc = bloc;
          _visitPunchBloc.add(GetVisitPartnerListFromDB());
          _visitPunchBloc.add(GetCustomerDetailFromDB(id: widget.customerId));
        },
        builder: (context, bloc, child) =>
            BlocListener<VisitPunchBloc, BaseState>(
          listener: (context, state) {
            if (state is VisitPartnersSuccessState) {
              _visitPartnerList = state.data;
            } else if (state is VisitPartnersFailedState) {
            } else if (state is CustomerSuccessState) {
              _customerInfo = state.data;
              _visitPunchBloc.add(
                  GetLastVisitByCustomerIdFromDB(id: _customerInfo.id ?? 0));
              _visitPunchBloc
                  .add(GetCustomerAddressesFromDB(id: _customerInfo.id!));
            } else if (state is CustomerFailedState) {
            } else if (state is GetLastVisitByCustomerIdSuccessState) {
              if (state.data != null) {
                _lastVisit = state.data;
              }
            } else if (state is GetLastVisitByCustomerIdFailedState) {
            } else if (state is VisitPunchInDBSuccessState) {
              print("VISit punch DB insert Success");
              initialValue = null;
              isMakeOwner = false;
              ApiService().checkInternet().then((internet) {
                SharedPreferenceService().addIntToSF(
                  SharedPrefsConstants.scopeId,
                  punchId,
                );
                if (internet) {
                  _visitPunchBloc.add(const GetUnSyncVisitPunchFromDB());
                } else {
                  SharedPreferenceService().addIntToSF(
                    SharedPrefsConstants.visitId,
                    punchId,
                  );
                  navigationPush(
                      context,
                      OutletInfoScreen(
                        outletInfo: _customerInfo,
                      ));
                }
              });
            } else if (state is VisitPunchInDBFailedState) {
            } else if (state is GetUnSyncVisitPunchSuccessState) {
              print("GetUnSyncVisitPunchSuccessState");
              _visitPunchList = state.data;
              for (int i = 0; i < _visitPunchList.length; i++) {
                if (_visitPunchList[i].id! < 0) {
                  _visitPunchList[i].id = 0;
                }
              }
              _visitPunchBloc.add(VisitPunchAPICall(request: _visitPunchList));
            } else if (state is GetUnSyncVisitPunchFailState) {
              print("GetUnSyncVisitPunchFailState");
            } else if (state is VisitPunchAPICallSuccessState) {
              print("VISit punch API call Success");
              _visitPunchBloc.add(const DeleteUnSyncVisitFromDB());
            } else if (state is VisitPunchAPICallFailState) {
              print("VISit punch API call Fail");
            } else if (state is DeleteUnSyncVisitSuccessState) {
              print("VISit punch Database Delete Success");
              _visitPunchBloc.add(const GetLastTimeStampFromDb());
            } else if (state is DeleteUnSyncVisitFailState) {
              print("VISit punch Database Delete Fail");
            } else if (state is GetLastSyncDateFromDBSuccessState) {
              print("GetLastSyncDateFromDBSuccessState");
              _visitPunchBloc.add(
                  GetVisitDataAPICall(pageIndex: 1, fromTimeStamp: state.data));
            } else if (state is GetLastSyncDateFromDBFailState) {
            } else if (state is GetVisitDataAPICallSuccessState) {
              _visitPunchBloc.add(
                  GetPunchVisitByCustomerIdFromDB(id: _customerInfo.id ?? 0));
              print("VISit Data API call Success");
            } else if (state is GetVisitDataAPICallFailState) {
              print("VISit Data API call Fail");
            } else if (state is GetPunchVisitByCustomerIdSuccessState) {
              _lastVisit = state.data;
              SharedPreferenceService().addIntToSF(
                SharedPrefsConstants.visitId,
                _lastVisit.id!,
              );
              navigationPush(
                  context,
                  OutletInfoScreen(
                    outletInfo: _customerInfo,
                  ));
            } else if (state is GetPunchVisitByCustomerIdFailedState) {
            } else if (state is CustomerAddressSuccessState ||
                state is CustomerAddressFailedState) {
              _manageCustomerAddresses(state);
            } else if (state is OrderDataSuccessState ||
                state is OrderDataFailedState) {
              _manageOrderDataState(state);
            } else if (state is NoOrderDataSuccessState ||
                state is NoOrderDataFailedState) {
              _manageNoOrderDataState(state);
            }
          },
          child: Stack(
            children: [
              Scaffold(
                appBar: CustomAppBar(
                  hasBack: widget.startVisit,
                  title: widget.startVisit
                      ? AppStrings.lblOutletHome2
                      : AppStrings.lblOutletHome1,
                ),
                drawer: AppDrawer(
                  selectedIndex: widget.startVisit ? 3 : 2,
                ),
                body: SafeArea(
                  child: CommonContainer(
                    topLayout: CommonDetailedHeader(
                      outletName: _customerInfo.businessName ?? ' ',
                      retailerType: _customerInfo.customerTypeName ?? ' ',
                      retailerLocation: _customerInfo.routeName ?? ' ',
                      screenName: "",
                      date: widget.startVisit
                          ? DateFormat('dd/MM/yyyy').format(now)
                          : getDateFromDateTime(widget.selectedDate!),
                    ),
                    child: _buildTimelineRetailInfoView(),
                  ),
                ),
              ),
              LoaderView<VisitPunchBloc>(
                loader: CustomLoader.normal(),
              ),
            ],
          ),
        ),
      );

  void _manageCustomerAddresses(BaseState state) {
    if (widget.orderId != null) {
      _visitPunchBloc.add(GetOrderDataFromDB(orderId: widget.orderId!));
    } else if (widget.noOrderId != null) {
      _visitPunchBloc.add(GetNoOrderDataFromDB(noOrderId: widget.noOrderId!));
    }
    if (state is CustomerAddressSuccessState) {
      final customerAddress = <CustomerAddressResponse>[];
      state.data.forEach((v) {
        customerAddress.add(CustomerAddressResponse.fromJsonForRowQuery(v));
      });
      _customerInfo.customerAddress = customerAddress;
    } else {
      widget.orderId != null
          ? _visitPunchBloc.add(GetOrderDataFromDB(orderId: widget.orderId!))
          : null;
    }
  }

  void _manageOrderDataState(state) {
    if (state is OrderDataSuccessState) {
      if (state.data != null) {
        state.data.forEach((v) {
          _orderList.add(ProductWithPriceModel.fromJsonForRowQuery(v));
        });
      }
    } else {}
  }

  void _manageNoOrderDataState(state) {
    if (state is NoOrderDataSuccessState) {
      if (state.data != null) {
        state.data.forEach((v) {
          _noOrderData = NoOrderTypeData.fromJsonForRowQuery(v);
        });
      }
    } else {}
  }

  Widget _buildTimelineRetailInfoView() => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  NameNumberWidget(
                      retailerName: _customerInfo.contactPersonName ?? ' ',
                      number: _customerInfo.mobileNumber ?? ' '),
                  const SizedBox(height: 15),
                  const DashedDivider(
                    height: 1,
                    color: AppColors.border,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _lastVisitText(),
                  _lastVisitDetailView(),
                  if (!widget.startVisit)
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: CartItemListWidget(orderList: _orderList))
                  //child: Text('uncomment previous line remove this one'))
                ],
              ),
            ),
          ),
          if (widget.startVisit)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: appCommonFlatButton(
                    btnTxt: AppStrings.lblANALYSIS.toUpperCase(),
                    isTopRightRounded: false,
                    onPressed: () {
                      navigationPush(
                          context,
                          AnalysisScreen(
                            customerInfo: _customerInfo,
                            lastVisit: _lastVisit,
                          ));
                    },
                  ),
                ),
                const SizedBox(
                  width: 1,
                ),
                Expanded(
                    child: appCommonFlatButton(
                        btnTxt: AppStrings.lblStartVisit.toUpperCase(),
                        isTopLeftRounded: false,
                        onPressed: savePunchIntoDatabase)),
              ],
            )
          else
            appCommonFlatButton(
                btnTxt: AppStrings.lblANALYSIS,
                onPressed: () {
                  navigationPush(
                      context,
                      AnalysisScreen(
                        customerInfo: _customerInfo,
                        lastVisit: _lastVisit,
                      ));
                })
        ],
      );

  Widget _lastVisitText() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Last Visit : ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.extraBold,
              letterSpacing: 0.05,
            ),
          ),
          Text(
            getDateFromDateTime(_lastVisit.createdOn ?? 'N/A'),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.normal,
              letterSpacing: 0.05,
            ),
          ),
          const Text(
            '  |  Visit Type : ',
            style: TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.extraBold,
              letterSpacing: 0.05,
            ),
          ),
          Text(
            getVisitTypeName(_lastVisit.visitType ?? -1),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: AppFonts.normal,
              letterSpacing: 0.05,
            ),
          ),
        ],
      );

  Widget _lastVisitDetailView() => Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(
                      20, 20, widget.startVisit ? 0 : 20, 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [Shadows.greyShadow],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Container(
                      padding: EdgeInsets.fromLTRB(
                          20,
                          widget.startVisit ? 0 : 20,
                          10,
                          widget.startVisit ? 10 : 20),
                      child: Column(
                        children: [
                          Visibility(
                            visible: !widget.startVisit,
                            child: Column(
                              children: [
                                if (_noOrderData != null)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        '${AppStrings.lblNoOrderReason} : ',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: AppFonts.extraBold,
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          _noOrderData?.typeName ?? '',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: AppFonts.extraBold,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      )
                                    ],
                                  ),
                                if (_lastVisit.visitType == 2)
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        AppStrings.lblVisitPartner,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: AppFonts.extraBold,
                                        ),
                                      ),
                                    ],
                                  ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      /*const Text(
                                        AppStrings.lblVisitPartner,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: AppFonts.extraBold,
                                        ),
                                      ),*/
                                      Row(
                                        children: [
                                          Text(
                                            '${AppStrings.lblStartVisit} : ',
                                            style: CustomTextStyle
                                                .punchInTextStyle,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            getTimeFromDateAndTime(
                                                _lastVisit.startTime ?? "-"),
                                            style: CustomTextStyle
                                                .punchInTextStyle,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${AppStrings.lblStopVisit} : ',
                                            style: CustomTextStyle
                                                .punchInTextStyle,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            getTimeFromDateAndTime(
                                                _lastVisit.endTime ?? "-"),
                                            style: CustomTextStyle
                                                .punchInTextStyle,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Visibility(
                              visible: widget.startVisit, child: _switchView()),
                          Visibility(
                            visible: isJointVisit,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      '${AppStrings.lblSelectVisitPartner} :',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: AppFonts.extraBold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.only(left: 10),
                                      height: 30,
                                      width: 180,
                                      color: AppColors.hint,
                                      child: DropdownButton<
                                          VisitPartnersDataResponse>(
                                        alignment: Alignment.centerLeft,
                                        items: _visitPartnerList
                                            .map((value) => DropdownMenuItem<
                                                    VisitPartnersDataResponse>(
                                                  value: value,
                                                  child: Text(
                                                    value.name,
                                                    style: CustomTextStyle
                                                        .smallTextStyle,
                                                  ),
                                                ))
                                            .toList(),
                                        menuMaxHeight: 300,
                                        onChanged: (newValue) {
                                          setState(() {
                                            initialValue = newValue!;
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.keyboard_arrow_down),
                                        value: initialValue,
                                        isExpanded: true,
                                        style: CustomTextStyle.inputFieldText,
                                      ),
                                    ),
                                    if (widget.startVisit)
                                      CustomRadioWidget(
                                        labelText: AppStrings.lblMakeOwner,
                                        value: isMakeOwner,
                                        onChanged: (value) {
                                          _onChanged();
                                        },
                                        radioSelection: true,
                                        fontSize: 12,
                                        fontWeight: AppFonts.bold,
                                        height: 35,
                                      )
                                    else
                                      const SizedBox(
                                        height: 10,
                                      ),
                                  ],
                                ),
                                Visibility(
                                  visible: !widget.startVisit,
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                        'Punch-Out',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: AppFonts.extraBold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '10:15:23 AM',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: AppFonts.extraBold,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Visibility(
              visible: false, child: _makeOwner('16/Sep2021', '10:15:23 AM'))
        ],
      );

  Widget _makeOwner(String date, String time) => Expanded(
        flex: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              date,
              style: CustomTextStyle.punchInTextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              time,
              style: CustomTextStyle.punchInTextStyle,
            ),
          ],
        ),
      );

  Widget _switchView() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppStrings.single,
            style: CustomTextStyle.switchPrimaryTextStyle,
          ),
          Switch(
            value: isJointVisit,
            activeColor: AppColors.primary,
            inactiveThumbColor: AppColors.primary,
            inactiveTrackColor: AppColors.tabBackground.withAlpha(150),
            onChanged: (isReceived) {
              setState(() {
                isJointVisit = !isJointVisit;
                initialValue = null;
                isMakeOwner = false;
              });
            },
          ),
          Text(
            AppStrings.joint,
            style: CustomTextStyle.switchPrimaryTextStyle,
          ),
        ],
      );

  /// Created by Dev 2183 on 01/11/2022
  /// Modified by
  /// Purpose : This method is used to do save punchIn data in Database.
  void savePunchIntoDatabase() async {
    userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    punchId = generateRandomNumber();
    if (!isJointVisit) {
      _visitPunchBloc.add(InsertVisitDetailIntoDB(
          visitType: VisitTypeId.singleVisit,
          startTime: getCurrentDateAndTime(),
          userId: userId,
          customerId: widget.customerId,
          makeOwner: isMakeOwner,
          scopeId: punchId));
    } else {
      if (initialValue != null) {
        _visitPunchBloc.add(InsertVisitDetailIntoDB(
            visitType: VisitTypeId.jointVisit,
            partnerId: initialValue!.id,
            userId: userId,
            startTime: getCurrentDateAndTime(),
            customerId: widget.customerId,
            makeOwner: isMakeOwner,
            scopeId: punchId));
      } else {
        showCustomFlushBar(
            context, AppStrings.msgPleaseSelectPartnerForJointVisit);
      }
    }
  }

  void _onChanged() {
    setState(() {
      if (isMakeOwner) {
        isMakeOwner = false;
      } else {
        isMakeOwner = true;
      }
    });
  }
}
