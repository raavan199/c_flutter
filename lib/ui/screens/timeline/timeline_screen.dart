import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/timeline/timeline_bloc.dart';
import '../../../exports/constants.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import '../../../utilities/shadow.dart';
import '../../widgets/custom_dropdown_cutomer_type.dart';
import '../base/base_screen.dart';
import '../timeline_retailerinfo/timeline_retailinfo_screen.dart'
    show TimelineRetailInfo;

/// Created by Dev 2136 on 08/12/2021
/// Modified by Dev 2136 on 02/22/2022
/// Purpose : timeline screen
class TimelineScreen extends StatefulWidget {
  const TimelineScreen({Key? key}) : super(key: key);

  @override
  _TimelineScreenState createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> with UtilityMixin {
  List<HorizontalBoxListModel> _horizontalList = [];
  late TimelineBloc _bloc;
  List<CustomerTypeDataResponse> _customerTypeDataResponse = [];
  final List<VisitDataItemsResponse> _visitList = [];
  List<VisitDataItemsResponse> _visitDisplayList = [];
  var _singleCount = 0;
  var _jointCount = 0;
  var _ordersCount = 0;
  var _noOrdersCount = 0;
  int? selectedSupplierId;
  String? date;
  final _formKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    super.initState();
    date = getCurrentDate();
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _visitList) {
      list.add(SearchModel(item.businessName ?? ""));
    }
    return list;
  }

  List<VisitDataItemsResponse> _getResultData(List<SearchModel> result) {
    final list = <VisitDataItemsResponse>[];
    for (final item in result) {
      for (final element in _visitList) {
        if (item.searchable ==
            element.businessName) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<TimelineBloc>(
        onBlocReady: (bloc) {
          _bloc = bloc;
          _bloc.add(GetVisitListFromDB(
              date: getCurrentDate(format: DateFormats.yyyyMMddDash)));
        },
        builder: (context, bloc, child) =>
            BlocListener<TimelineBloc, BaseState>(
          listener: (context, state) {
            if (state is VisitSuccessState || state is VisitFailedState) {
              _manageVisitStates(state);
            }
            if (state is CustomerTypeSuccessState ||
                state is CustomerTypeFailedState) {
              _manageCustomerTypeStates(state);
            }
          },
          child: Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.lblTimeline,
              date: date,
              calenderRequired: true,
              selectedDate: (value) {
                setState(() {
                  date = DateFormat('dd/MM/yyyy').format(value);
                });
                final dateTime = DateTime.parse(value.toString());
                final onlyDate = formatDate(dateTime, [yyyy, '-', mm, '-', dd]);
                _bloc.add(GetVisitListFromDB(date: onlyDate));
              },
            ),
            drawer: const AppDrawer(
              selectedIndex: 2,
            ),
            body: CommonContainer(
                isSearchable: true,
                searchData: _getSearchableData(),
                searchHint: AppStrings.searchHintRouteInfo,
                onSearchResult: (result) {
                  setState(() {
                    _visitDisplayList = _getResultData(result);
                  });
                },
                child: _buildMethodView()),
          ),
        ),
      );

  void _manageVisitStates(state) {
    if (state is VisitSuccessState) {
      _visitList.clear();
      _visitDisplayList.clear();
      _singleCount = 0;
      _jointCount = 0;
      _ordersCount = 0;
      _noOrdersCount = 0;
      selectedSupplierId = null;
      _formKey.currentState?.reset();
      if (state.data != null) {
        state.data.forEach((v) {
          _visitList.add(VisitDataItemsResponse.fromJsonForRowQuery(v));
          if (VisitDataItemsResponse.fromJsonForRowQuery(v).partnerId != null) {
            _jointCount++;
          } else {
            _singleCount++;
          }
          if (VisitDataItemsResponse.fromJsonForRowQuery(v).orderId != null) {
            _ordersCount++;
          } else if (VisitDataItemsResponse.fromJsonForRowQuery(v).noOrderId !=
              null) {
            _noOrdersCount++;
          }
        });
        _visitDisplayList.addAll(_visitList);
        setState(() {
          _horizontalList = [
            HorizontalBoxListModel(
                _visitDisplayList.length.toString(), AppStrings.outlets),
            HorizontalBoxListModel(_singleCount.toString(), AppStrings.single),
            HorizontalBoxListModel(_jointCount.toString(), AppStrings.joint),
            HorizontalBoxListModel(_ordersCount.toString(), AppStrings.orders),
            HorizontalBoxListModel(_noOrdersCount.toString(), 'N/O'),
          ];
        });
      }
      _bloc.add(const GetCustomerTypeListFromDB());
    } else {
      _bloc.add(const GetCustomerTypeListFromDB());
    }
  }

  void _manageCustomerTypeStates(state) {
    if (state is CustomerTypeSuccessState) {
      _customerTypeDataResponse = state.data;
    } else {
      showCustomFlushBar(context, state.msg ?? "");
    }
  }

  void _itemClick(int index) {
    setState(() {
      _visitDisplayList.clear();
      switch (index) {
        case 0:
          {
            _visitList.forEach((element) {
              if (selectedSupplierId != null) {
                if (element.customerType == selectedSupplierId) {
                  _visitDisplayList.add(element);
                }
              } else {
                _visitDisplayList.add(element);
              }
            });
          }
          break;
        case 1:
          {
            _visitList.forEach((element) {
              if (selectedSupplierId != null) {
                if (element.partnerId == null &&
                    element.customerType == selectedSupplierId) {
                  _visitDisplayList.add(element);
                }
              } else {
                if (element.partnerId == null) {
                  _visitDisplayList.add(element);
                }
              }
            });
          }
          break;
        case 2:
          {
            _visitList.forEach((element) {
              if (selectedSupplierId != null) {
                if (element.partnerId != null &&
                    element.customerType == selectedSupplierId) {
                  _visitDisplayList.add(element);
                }
              } else {
                if (element.partnerId != null) {
                  _visitDisplayList.add(element);
                }
              }
            });
          }
          break;
        case 3:
          {
            _visitList.forEach((element) {
              if (selectedSupplierId != null) {
                if (element.orderId != null &&
                    element.customerType == selectedSupplierId) {
                  _visitDisplayList.add(element);
                }
              } else {
                if (element.orderId != null) {
                  _visitDisplayList.add(element);
                }
              }
            });
          }
          break;
        case 4:
          {
            _visitList.forEach((element) {
              if (selectedSupplierId != null) {
                if (element.noOrderId != null &&
                    element.customerType == selectedSupplierId) {
                  _visitDisplayList.add(element);
                }
              } else {
                if (element.noOrderId != null) {
                  _visitDisplayList.add(element);
                }
              }
            });
          }
          break;
      }
    });
  }

  Widget _buildMethodView() => Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 30),
        child: Column(
          children: [
            HorizontalBoxesView(list: _horizontalList, itemClick: _itemClick),
            const SizedBox(
              height: 10,
            ),
            _outletSelectionView(),
            const SizedBox(
              height: 10,
            ),
            if (_visitDisplayList.isNotEmpty)
              _outletListView()
            else
              const Text(AppStrings.msgNoDataFound)
          ],
        ),
      );

  Widget _outletSelectionView() => Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [Shadows.greyShadow],
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 5),
          child: CustomDropdownCustomerType(
            key: _formKey,
            labelText: AppStrings.selectOutletType,
            items: _customerTypeDataResponse,
            iconPath: AppAssets.icDropDownArrow,
            customerType: (value) {
              setState(() {
                _visitDisplayList.clear();
                _jointCount = 0;
                _singleCount = 0;
                _ordersCount = 0;
                _noOrdersCount = 0;
                _visitList.forEach((element) {
                  if (element.customerType == value.id) {
                    selectedSupplierId = value.id;
                    _visitDisplayList.add(element);
                    if (element.partnerId != null) {
                      _jointCount++;
                    } else {
                      _singleCount++;
                    }
                    if (element.orderId != null) {
                      _ordersCount++;
                    } else if (element.noOrderId != null) {
                      _noOrdersCount++;
                    }
                  }
                });
                _horizontalList = [
                  HorizontalBoxListModel(
                      _visitDisplayList.length.toString(), AppStrings.outlets),
                  HorizontalBoxListModel(
                      _singleCount.toString(), AppStrings.single),
                  HorizontalBoxListModel(
                      _jointCount.toString(), AppStrings.joint),
                  HorizontalBoxListModel(
                      _ordersCount.toString(), AppStrings.orders),
                  HorizontalBoxListModel(_noOrdersCount.toString(), 'N/O'),
                ];
              });
            },
          ),
        ),
      );

  Widget _outletListView() => Expanded(
          child: ListView.builder(
        itemCount: _visitDisplayList.length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, i) {
          final item = _visitDisplayList[i];
          return Padding(
            padding: const EdgeInsets.only(
                right: AppStyles.pageSideMargin,
                left: AppStyles.pageSideMargin,
                bottom: 20),
            child: InkWell(
              onTap: () {
                navigationPush(
                    context,
                    TimelineRetailInfo(
                      customerId: item.customerId!,
                      orderId: item.orderId,
                      noOrderId: item.noOrderId,
                      selectedDate: date,
                    ));
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: const [Shadows.greyShadow],
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      backgroundColor: item.totalAmount != 0.0
                          ? AppColors.primary
                          : AppColors.accentOrange,
                      radius: 22,
                      child: const Center(
                        child: Text(
                          //item.initials,
                          "RT",
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item.businessName ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        CustomTextStyle.calendarHeaderTextStyle,
                                  ),
                                ),
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${getTimeFromDateAndTime(item.startTime ?? "")} - ${getTimeFromDateAndTime(item.endTime ?? "") ?? ""}',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: CustomTextStyle.timeLineTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              if (item.orderId != null)
                                Expanded(
                                    child: Text(
                                  '#${item.orderId} - Rs. ${item.totalAmount}',
                                  style: CustomTextStyle.orderNumberTextStyle,
                                ))
                              else if (item.noOrderId != null)
                                Expanded(
                                    child: Text(
                                  '#${item.noOrderId}',
                                  style: CustomTextStyle.orderNumberTextStyle,
                                ))
                              else
                                Text(
                                  '#${item.id}',
                                  style: CustomTextStyle.orderNumberTextStyle,
                                ),
                              if (item.orderId != null)
                                _button(
                                  AppStrings.order,
                                  AppColors.accentGreen,
                                  AppColors.white,
                                )
                              else if (item.noOrderId != null)
                                _button(
                                  AppStrings.lblNoOrder,
                                  AppColors.black,
                                  AppColors.white,
                                )
                              else
                                _button(
                                  "",
                                  AppColors.white,
                                  AppColors.white,
                                )
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ));

  Widget _button(String btnTxt, Color? bgColor, Color? textColor) => SizedBox(
        child: MaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            height: 30,
            disabledElevation: 0,
            elevation: 0,
            color: bgColor ?? AppColors.white,
            onPressed: () {},
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
}
