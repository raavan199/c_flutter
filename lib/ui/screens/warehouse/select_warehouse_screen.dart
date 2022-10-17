import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/warehouse/warehouse_bloc.dart';
import '../../../exports/mixins.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../base/base_screen.dart';
import '../product/product_screen.dart';

class SelectWarehouseScreen extends StatefulWidget {
  const SelectWarehouseScreen({
    required this.distributorId,
    required this.outletInfo,
    required this.distributorName,
    Key? key,
  }) : super(key: key);

  final int distributorId;
  final String distributorName;
  final CustomerDataItemsResponse? outletInfo;

  @override
  _SelectWarehouseScreenState createState() => _SelectWarehouseScreenState();
}

class _SelectWarehouseScreenState extends State<SelectWarehouseScreen>
    with UtilityMixin {
  List<WarehouseDataItemsResponse> _warehouseList = [];
  List<WarehouseDataItemsResponse> _warehouseDisplayList = [];
  late WarehouseBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _warehouseList) {
      list.add(SearchModel(item.name!));
    }
    return list;
  }

  List<WarehouseDataItemsResponse> _getResultData(List<SearchModel> result) {
    final list = <WarehouseDataItemsResponse>[];
    for (final item in result) {
      for (final element in _warehouseList) {
        if (item.searchable == element.name) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<WarehouseBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetWarehouseList(distributorId: widget.distributorId));
      },
      builder: (context, bloc, child) => BlocListener<WarehouseBloc, BaseState>(
            listener: (context, state) {
              if (state is WarehouseSuccessState) {
                _warehouseList = state.data;
                _warehouseDisplayList = _warehouseList;
              } else if (state is WarehouseFailedState) {
                showCustomFlushBar(context, AppStrings.msgDataNotAvailable);
              }
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title: AppStrings.lblSelectWarehouse,
                hasBack: true,
              ),
              body: CommonContainer(
                hasTimer: true,
                topLayout: const SizedBox(
                  height: 10,
                ),
                isSearchable: true,
                searchData: _getSearchableData(),
                searchHint: AppStrings.searchHintWarehouse,
                onSearchResult: (result) {
                  setState(() {
                    _warehouseDisplayList = _getResultData(result);
                  });
                },
                child: SizedBox(
                    height: Get.height,
                    child: _warehouseDisplayList.isNotEmpty
                        ? WareHouseListView()
                        : const Center(
                            child: Text(AppStrings.msgNoDataFound),
                          )),
              ),
            ),
          ));

  Widget WareHouseListView() => ListView.builder(
        shrinkWrap: true,
        itemCount: _warehouseDisplayList.length,
        padding: const EdgeInsets.only(
            top: 30,
            left: AppStyles.pageSideMargin,
            right: AppStyles.pageSideMargin,
            bottom: 15),
        itemBuilder: (context, index) =>
            _buildItem(context, _warehouseDisplayList[index]),
      );

  Widget _buildItem(BuildContext context, item) => InkWell(
        onTap: () async {
          await navigationWithAwaitPush(
              context,
              ProductScreen(
                  distributorId: widget.distributorId,
                  warehouseId: item.id,
                  outletInfo: widget.outletInfo));
          setState(() {});
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [Shadows.greyShadow],
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.iclocation,
                width: 15,
                height: 15,
              ),
              const SizedBox(
                width: 15,
              ),
              Text(item.name),
            ],
          ),
        ),
      );
}
