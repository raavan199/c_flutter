import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../../exports/mixins.dart';
import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/outlet_info/outlet_info_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import '../../../mixins/TimerSingleTon.dart';
import '../../../services/api/api_service.dart';
import '../../../services/shared_preference_service.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/dash_line_divider.dart';
import '../accounts/accounts_screen.dart';
import '../base/base_screen.dart';
import '../modify_outlet/modify_outlet_screen.dart';
import '../no_order/no_order_screen.dart';
import '../order_history/order_history_screen.dart';
import '../outlet_albums/outlet_album_screen.dart';
import '../routes/route_screen.dart';
import '../sales_adjustment/sales_adjustment_screen.dart';
import '../sales_return/sales_return_screen.dart';
import '../supplier/select_supplier_screen.dart';
import '../timeline_retailerinfo/timeline_retailinfo_screen.dart';
import 'outlet_info_main_widget.dart';

class OutletInfoScreen extends StatefulWidget {
  OutletInfoScreen({this.outletInfo, Key? key}) : super(key: key);

  CustomerDataItemsResponse? outletInfo;

  @override
  State<StatefulWidget> createState() => _OutletInfoScreenState();
}

class _OutletInfoScreenState extends State<OutletInfoScreen> with UtilityMixin {
  List<OutletInfoButtonModel>? buttons;
  late OutletInfoBloc _bloc;
  int? visitId;
  bool? isJointVisit = false;
  bool isStopTimer = false;
  OrderRecordDataResponse lastOrder = OrderRecordDataResponse();

  @override
  void initState() {
    super.initState();
    TimerSingleton().resetTimer();
    buttons = <OutletInfoButtonModel>[
      const OutletInfoButtonModel(
          title: 'New Order', icon: AppAssets.icNewOrder),
      const OutletInfoButtonModel(
          title: 'Order History', icon: AppAssets.icOrderHistory),
      const OutletInfoButtonModel(title: 'Account ', icon: AppAssets.icAccount),
      const OutletInfoButtonModel(
          title: 'Sales Return', icon: AppAssets.icSalesReturn),
      const OutletInfoButtonModel(
          title: 'Adjustment', icon: AppAssets.icAdjustment),
      const OutletInfoButtonModel(title: 'No Order', icon: AppAssets.icNoOrder),
    ];
  }

  @override
  Widget build(BuildContext context) => BaseScreen<OutletInfoBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
          _bloc.add(
              GetLastOrderByCustomerId(customerId: widget.outletInfo!.id ?? 0));
        },
        builder: (context, bloc, child) => BlocListener<OutletInfoBloc,
                BaseState>(
            listener: (context, state) {
              if (state is GetLastOrderByCustomerIdSuccessState) {
                if (state.data != null && state.data.isNotEmpty) {
                  lastOrder = OrderRecordDataResponse.fromJsonF0rRowQuery(
                      state.data[0]);
                  // lastOrder = state.data!;
                }
              } else if (state is GetLastOrderByCustomerIdFailState) {
              } else if (state is UpdateVisitPunchOutDBSuccessState) {
                ApiService().checkInternet().then((internet) {
                  if (internet) {
                    _bloc.add(const GetUnSyncVisitPunchFromDB());
                  } else {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      navigationPush(
                          context,
                          TimelineRetailInfo(
                            startVisit: true,
                            customerId: widget.outletInfo!.id!,
                          ));
                    }
                  }
                });
              } else if (state is UpdateVisitPunchOutDBFailedState) {
              } else if (state is GetUnSyncVisitPunchSuccessState) {
                _bloc.add(VisitPunchAPICall(request: state.data));
              } else if (state is GetUnSyncVisitPunchFailState) {
              } else if (state is VisitPunchAPICallSuccessState) {
                print("VISit punch API call Success");
                _bloc.add(const DeleteUnSyncVisitFromDB());
              } else if (state is VisitPunchAPICallFailState) {
              } else if (state is DeleteUnSyncVisitSuccessState) {
                print("VISit punch Database Delete Success");
                _bloc.add(const GetLastTimeStampFromDb());
              } else if (state is DeleteUnSyncVisitFailState) {
                print("VISit punch Database Delete Fail");
              } else if (state is GetLastSyncDateFromDBSuccessState) {
                print("GetLastSyncDateFromDBSuccessState");
                _bloc.add(GetVisitDataAPICall(
                    pageIndex: 1, fromTimeStamp: state.data));
              } else if (state is GetLastSyncDateFromDBFailState) {
                print("GetLastSyncDateFromDBFailState");
              } else if (state is GetVisitDataAPICallSuccessState) {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else {
                  navigationPush(
                      context,
                      TimelineRetailInfo(
                        startVisit: true,
                        customerId: widget.outletInfo!.id!,
                      ));
                }
                print("VISit Data API call Success");
              } else if (state is GetVisitDataAPICallFailState) {
                print("VISit Data API call Fail");
              } else if (state is GetUpdatedCustomerDetailsSuccessState ||
                  state is GetUpdatedCustomerDetailsFailState) {
                _manageUpdatedCustomerDetailsSuccessState(state);
              }
            },
            child: WillPopScope(
              onWillPop: () async => (await showConfirmationDialog()) ?? false,
              child: Scaffold(
                appBar: CustomAppBar(
                  title: AppStrings.lblOutletHome3,
                  hasBack: true,
                  backTap: () {
                    showConfirmationDialog();
                  },
                ),
                body: SafeArea(
                  child: CommonContainer(
                      hasTimer: true,
                      stopTimer: isStopTimer,
                      topLayout: CommonDetailedHeader(
                        screenName: AppStrings.lblOutletHome3,
                        outletName: widget.outletInfo?.businessName ?? '',
                        retailerLocation: widget.outletInfo?.routeName ?? '',
                        retailerType: widget.outletInfo?.customerTypeName ?? '',
                        date: getCurrentDate(),
                        showActions: true,
                        showLocation: true,
                        isEditEnabled: true,
                        hasExtraPadding: true,
                        editOnTap: () {
                          /*navigationPush(
                              context,
                              ModifyOutletScreen(
                                isFromRouteInfo: false,
                                outletInfo: widget.outletInfo,
                              ));*/
                          _navigateToModifyOutlet(context);
                        },
                        cameraOnTap: () {
                          ApiService().checkInternet().then((internet) async {
                            if (internet) {
                              await navigationWithAwaitPush(
                                  context,
                                  OutletAlbumScreen(
                                    outletInfo: widget.outletInfo!,
                                    isFromRouteInfo: false,
                                  ));
                              setState(() {});
                            } else {
                              showNoInternetDialog(context);
                            }
                          });
                        },
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            NameNumberWidget(
                                retailerName:
                                    widget.outletInfo!.contactPersonName,
                                number: widget.outletInfo!.mobileNumber),
                            const SizedBox(
                              height: 10,
                            ),
                            const DashedDivider(
                              color: AppColors.border,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            _LastOrderWidget(
                                getDateFromDateTime(lastOrder.orderDate ??
                                    AppStrings.notAssign),
                                '${lastOrder.totalAmount?.toStringAsFixed(2) ?? 0}'),
                            Expanded(
                                child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        45, 26, 45, 26),
                                    child: _gridviewWidget(buttons))),
                            _bottomBar(context),
                          ],
                        ),
                      )),
                ),
              ),
            )),
      );

  void _manageUpdatedCustomerDetailsSuccessState(state) {
    if (state is GetUpdatedCustomerDetailsSuccessState) {
      setState(() {
        widget.outletInfo = state.data;
      });
    } else {}
  }

  Widget _LastOrderWidget(String lastOrderDate, String lastOrderValue) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _lastOrderTitle('Last Order: '),
          _lastOrderValue(lastOrderDate),
          _lastOrderTitle(' | '),
          _lastOrderTitle('Order Value: '),
          _lastOrderValue('$lastOrderValue/-'),
        ],
      );

  Widget _gridviewWidget(List<OutletInfoButtonModel>? buttons) =>
      GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 30,
        mainAxisSpacing: 15,
        children: List.generate(
            buttons!.length,
            (index) => Center(
                child: OutletInfoMainWidget(
                    iconPath: buttons[index].icon,
                    title: buttons[index].title,
                    onItemTap: () async {
                      switch (index) {
                        case 0:
                          await navigationWithAwaitPush(
                              context,
                              SelectSupplierScreen(
                                  outletInfo: widget.outletInfo));
                          setState(() {});
                          break;
                        case 1:
                          await navigationWithAwaitPush(
                              context,
                              OrderHistoryScreen(
                                  outletInfo: widget.outletInfo));
                          setState(() {});
                          break;
                        case 2:
                          await navigationWithAwaitPush(context,
                              AccountsScreen(outletInfo: widget.outletInfo));
                          setState(() {});
                          break;
                        case 3:
                          await navigationWithAwaitPush(
                              context,
                              SalesReturnScreen(
                                outletInfo: widget.outletInfo!,
                              ));
                          setState(() {});
                          break;
                        case 4:
                          await navigationWithAwaitPush(
                              context,
                              SalesAdjustmentScreen(
                                  outletInfo: widget.outletInfo!));
                          setState(() {});
                          break;
                        case 5:
                          await navigationWithAwaitPush(context,
                              NoOrderScreen(outletInfo: widget.outletInfo));
                          setState(() {});
                          break;
                      }
                    }))),
      );

  Widget _bottomBar(BuildContext context) => Container(
        padding: const EdgeInsets.fromLTRB(8, 15, 8, 12),
        decoration: const BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _button('Complaint', null, null, () {}),
                _button('Competition', null, null, () {}),
                _button('Outlet Stock', null, null, () {}),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _button('Survey', null, null, () {}),
                _button('Visit Notes', null, null, () {}),
                _button(AppStrings.lblEndVisit, AppColors.accentYellow,
                    AppColors.white, showConfirmationDialog),
              ],
            )
          ],
        ),
      );

  Future<void> _navigateToModifyOutlet(BuildContext context) async {
    final result = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ModifyOutletScreen(
            isFromRouteInfo: false,
            outletInfo: widget.outletInfo,
          ),
        ));
    // after edit outlet pop up to this method
    return setState(() {
      if (result != null) {
        final CustomerDataItemsResponse updatedCustomerData = result;
        /*widget.outletInfo = updatedCustomerData;
        print(widget.outletInfo);*/
        _bloc.add(GetCustomerAddressesFromDB(id: result.id!));
      }
    });
  }

  showConfirmationDialog() {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              content: AppStrings.msgAreYouSure,
              title: AppStrings.lblEndVisitDialogTitle,
              yes: AppStrings.lblYes,
              no: AppStrings.lblNo,
              yesOnPressed: () {
                updateVisitPunchInDB();
              },
              noOnPressed: () {
                Navigator.of(context).pop(false);
                print('alert dialog no clicked');
              },
            ));
  }

  /// Created by Dev 2183 on 01/19/2022
  /// Modified by
  /// Purpose : This method is used to do update punch-out data in Database.
  void updateVisitPunchInDB() async {
    int? scopeId;
    final userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    visitId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.visitId);
    scopeId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.scopeId);
    if (visitId != null && visitId != 0) {
      _bloc.add(UpdateVisitPunchIntoDB(
          visitId: visitId ?? -1,
          scopeId: scopeId,
          endTime: getCurrentDateAndTime(),
          isSync: SyncStatus.unSync,
          userId: userId));
    } else {
      if (scopeId != null && scopeId != 0) {
        _bloc.add(UpdateVisitPunchIntoDB(
            visitId: scopeId,
            scopeId: scopeId,
            endTime: getCurrentDateAndTime(),
            isSync: SyncStatus.unSync,
            userId: userId));
      } else {
        print("Visit Id not Found");
      }
    }

    await SharedPreferenceService().removeValue(SharedPrefsConstants.visitId);
    await SharedPreferenceService().removeValue(SharedPrefsConstants.scopeId);
    await SharedPreferenceService().removeValue(PrefKeys.timerValue);
    TimerSingleton().stopTimer();
  }
}

Widget _lastOrderTitle(String title) => Text(
      title,
      style: CustomTextStyle.mobileNumberTextStyle,
    );

Widget _lastOrderValue(String data) => Text(
      data,
      style: CustomTextStyle.retailerNameTextStyle,
    );

Widget _button(String btnTxt, Color? bgColor, Color? textColor,
        VoidCallback onButtonTap) =>
    SizedBox(
      width: (Get.width / 3) - 8,
      child: MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          height: 40,
          disabledElevation: 0,
          elevation: 0,
          //highlightColor: Colors.transparent,
          color: bgColor ?? AppColors.white,
          onPressed: onButtonTap,
          disabledColor: AppColors.hint,
          child: Text(
            btnTxt,
            style: TextStyle(
              color: (textColor == null) ? AppColors.primary : textColor,
              fontSize: 12,
              fontWeight: AppFonts.bold,
            ),
          )),
    );
