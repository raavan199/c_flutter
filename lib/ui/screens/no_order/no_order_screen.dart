import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/no_order_type/no_order_type_bloc.dart';
import '../../../constants/app_constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';
import '../../../services/api/api_service.dart';
import '../../../services/shared_preference_service.dart';
import '../../widgets/custom_dialog.dart';
import '../base/base_screen.dart';
import 'no_order_list_view.dart';

/// Created by Dev 2183 on 12/14/2021
/// Modified by Dev 2183 on 12/14/2021
/// Purpose : No Order Screen
class NoOrderScreen extends StatefulWidget {
  const NoOrderScreen({required this.outletInfo, Key? key}) : super(key: key);
  final CustomerDataItemsResponse? outletInfo;

  @override
  _NoOrderScreenState createState() => _NoOrderScreenState();
}

class _NoOrderScreenState extends State<NoOrderScreen> with UtilityMixin {
  late NoOrderTypeBloc _bloc;
  int userId = 0;
  late List<NoOrderRequest> unSyncNoOrderList;

  List<RadioSelectionItemModel> _radioSelectionList = [];
  List<RadioSelectionItemModel> _radioSelectionDisplayList = [];

  String remarks = '';

  @override
  void initState() {
    super.initState();
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _radioSelectionList) {
      list.add(SearchModel(item.title ?? ""));
    }
    return list;
  }

  List<RadioSelectionItemModel> _getResultData(List<SearchModel> result) {
    final list = <RadioSelectionItemModel>[];
    for (final item in result) {
      for (final element in _radioSelectionList) {
        if (item.searchable == element.title) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<NoOrderTypeBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(const GetNoOrderTypeFromDB());
      },
      builder: (context, bloc, child) =>
          BlocListener<NoOrderTypeBloc, BaseState>(
              listener: (context, state) {
                if (state is GetNoOrderTypeSuccessState) {
                  _radioSelectionList = [];
                  state.data.forEach((element) {
                    _radioSelectionList.add(
                      RadioSelectionItemModel(element.typeName ?? '',
                          id: element.id),
                    );
                  });
                  _radioSelectionDisplayList = _radioSelectionList;
                } else if (state is GetNoOrderTypeFailState) {
                  print('GetNoOrderTypeFailState');
                } else if (state is InsertNoOrderIntoDBSuccessState) {
                  ApiService().checkInternet().then((internet) {
                    if (internet) {
                      _bloc.add(const GetUnSyncNoOrder());
                    } else {
                      Navigator.of(context).pop();
                    }
                  });
                } else if (state is InsertNoOrderIntoDBFailedState) {
                  print('InsertNoOrderIntoDBFailedState');
                } else if (state is GetUnSyncNoOrderSuccessState) {
                  print('GetUnSyncNoOrderSuccessState');
                  unSyncNoOrderList = state.data;
                  if (unSyncNoOrderList.isNotEmpty) {
                    for (int i = 0; i < unSyncNoOrderList.length; i++) {
                      if (unSyncNoOrderList[i].id! < 0) {
                        unSyncNoOrderList[i].id = 0;
                      }
                    }
                  }
                  callManageNoOrderAPI();
                } else if (state is GetUnSyncNoOrderFailedState) {
                } else if (state is NoOrderApiCallSuccessSate) {
                  print("NoOrderApiCallSuccessSate");
                  _bloc.add(const DeleteUnSyncNoOrderFromDB());
                } else if (state is NoOrderApiCallFailedState) {
                  Navigator.of(context).pop();
                  print("NoOrderApiCallFailedState");
                } else if (state is DeleteUnSyncNoOrderSuccessState) {
                  _bloc.add(const GetNewNoOrder());
                  print("DeleteUnSyncNoOrderSuccessStates");
                } else if (state is DeleteUnSyncNoOrderFailState) {
                  print("DeleteUnSyncNoOrderFailState");
                } else if (state is NoOrderSuccessState) {
                  Navigator.of(context).pop();
                  print("NoOrderSuccessState");
                } else if (state is NoOrderFailedState) {
                  Navigator.of(context).pop();
                  print("NoOrderFailedState");
                }
              },
              child: Scaffold(
                appBar: CustomAppBar(
                  title: AppStrings.lblNoOrder,
                  hasBack: true,
                ),
                body: SafeArea(
                  child: CommonContainer(
                    hasTimer: true,
                    topLayout: const CommonDetailedHeader(
                        hasExtraPadding: true,
                        outletName: AppStrings.outletName,
                        retailerType: AppStrings.retailerType,
                        retailerLocation: AppStrings.retailerLocation,
                        screenName: ''),
                    isSearchable: true,
                    searchData: _getSearchableData(),
                    searchHint: AppStrings.searchHintNoOrder,
                    onSearchResult: (result) {
                      setState(() {
                        _radioSelectionDisplayList = _getResultData(result);
                      });
                    },
                    child: _buildNoOrderListView(),
                  ),
                ),
              )));

  Widget _buildNoOrderListView() => Stack(children: [
        Padding(
            padding: const EdgeInsets.fromLTRB(
                AppStyles.pageSideMargin, 30, AppStyles.pageSideMargin, 15),
            child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: NoOrderListView(
              addRemarks: (value) {
                remarks = value;
              },
                  outletInfo: widget.outletInfo,
              noOrderRadioList: _radioSelectionDisplayList,
            ))),
        Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            height: 50,
            child: appCommonFlatButton(
                btnTxt: AppStrings.lblSubmit,
                onPressed: showConfirmationDialog),
          ),
        )
      ]);

  showConfirmationDialog() {
    int id = 0;
    for (int i = 0; i < _radioSelectionList.length; i++) {
      if (_radioSelectionList[i].isSelected) {
        id = _radioSelectionList[i].id ?? 0;
      }
    }
    if (id != 0) {
      showDialog(
          context: context,
          builder: (context) => CustomDialog(
                content: AppStrings.msgAreYouSure,
                title: AppStrings.lblNoOrder,
                yes: AppStrings.lblYes,
                no: AppStrings.lblNo,
                yesOnPressed: () {
                  _onSubmit(id);
                },
                noOnPressed: () {
                  Navigator.of(context).pop(false);
                  print('alert dialog no clicked');
                },
              ));
    } else {
      showCustomFlushBar(context, "Select a reason first");
    }
  }

  void _onSubmit(int id) async {
    userId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.userId);
    var visitId = await SharedPreferenceService()
        .getIntValuesSF(SharedPrefsConstants.visitId);
    if (visitId == null || visitId == 0) {
      visitId = await SharedPreferenceService()
          .getIntValuesSF(SharedPrefsConstants.scopeId);
    }

    _bloc.add(InsertNoOrderIntoDB(
        request: NoOrderRequest(
            id: generateRandomNumber(),
            customerId: widget.outletInfo!.id ?? 0,
            noOrderTypeId: id,
            remarks: remarks ?? '',
            isActive: true,
            visitId: visitId,
            created_by: userId,
            created_on: getCurrentDateAndTime(),
            isSync: SyncStatus.unSync)));
  }

  void callManageNoOrderAPI() {
    _bloc.add(NoOrderAPICall(request: unSyncNoOrderList));
  }
}
