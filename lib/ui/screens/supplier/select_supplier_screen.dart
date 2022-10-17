import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../blocs/base/base_bloc.dart';
import '../../../blocs/select_supplier/select_supplier_bloc.dart';
import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../../mixins/utility_mixin.dart';
import '../base/base_screen.dart';
import '../warehouse/select_warehouse_screen.dart';

class SelectSupplierScreen extends StatefulWidget {
  const SelectSupplierScreen({required this.outletInfo, Key? key})
      : super(key: key);
  final CustomerDataItemsResponse? outletInfo;

  @override
  _SelectSupplierScreenState createState() => _SelectSupplierScreenState();
}

class _SelectSupplierScreenState extends State<SelectSupplierScreen> with UtilityMixin{
  List<DistributionData> _supplierList = [];
  List<DistributionData> _supplierDisplayList = [];
  late SelectSupplierBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  List<SearchModel> _getSearchableData() {
    final list = <SearchModel>[];
    for (final item in _supplierList) {
      list.add(SearchModel(item.businessName!));
    }
    return list;
  }

  List<DistributionData> _getResultData(List<SearchModel> result) {
    final list = <DistributionData>[];
    for (final item in result) {
      for (final element in _supplierList) {
        if (item.searchable == element.businessName!) {
          list.add(element);
        }
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) => BaseScreen<SelectSupplierBloc>(
      onBlocReady: (bloc) {
        _bloc = bloc;
        _bloc.add(GetSupplierFromDB(
          widget.outletInfo!.distributorId_1 ?? 0,
          widget.outletInfo!.distributorId_2 ?? 0,
          widget.outletInfo!.distributorId_3 ?? 0,
        ));
      },
      builder: (context, bloc, child) =>
          BlocListener<SelectSupplierBloc, BaseState>(
            listener: (context, state) {
              if (state is SupplierSuccessState) {
                _supplierList = [];
                if (state.data != null) {
                  state.data.forEach((v) {
                    _supplierList.add(DistributionData.fromJsonForRowQuery(v));
                  });
                }
                //_supplierList = state.data;
                _supplierDisplayList = _supplierList;
              } else if (state is SupplierFailedState) {
                showCustomFlushBar(context, AppStrings.msgDataNotAvailable);
              }
            },
            child: Scaffold(
              appBar: CustomAppBar(
                title: AppStrings.lblSelectDistributor,
                hasBack: true,
              ),
              body: CommonContainer(
                hasTimer: true,
                topLayout: CommonDetailedHeader(
                    outletName: widget.outletInfo!.businessName,
                    hasExtraPadding: true,
                    retailerType: widget.outletInfo!.customerTypeName,
                    retailerLocation: widget.outletInfo?.routeName,
                    screenName: AppStrings.lblSelectSupplier),
                isSearchable: true,
                searchData: _getSearchableData(),
                searchHint: AppStrings.searchHintSupplier,
                onSearchResult: (result) {
                  setState(() {
                    _supplierDisplayList = _getResultData(result);
                  });
                },
                child: _supplierDisplayList.isNotEmpty
                    ? SupplierListView()
                    : const Center(
                        child: Text(AppStrings.msgNoDataFound),
                      ),
              ),
            ),
          ));

  Widget SupplierListView() => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _supplierDisplayList.length,
          padding: const EdgeInsets.only(
            top: 30,
            left: AppStyles.pageSideMargin,
            right: AppStyles.pageSideMargin,
            bottom: 10,
          ),
          itemBuilder: (context, index) =>
              _buildItem(context, _supplierDisplayList[index]),
        ),
      );

  Widget _buildItem(BuildContext context, DistributionData item) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: const [Shadows.greyShadow],
          borderRadius: BorderRadius.circular(5),
        ),
        child: InkWell(
          onTap: () async {
            await navigationWithAwaitPush(
                context,
                SelectWarehouseScreen(
                distributorId: item.id!,
                outletInfo: widget.outletInfo,
                distributorName: item.businessName ?? '',
            ));
            setState(() {});

          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.businessName!,
                  style: CustomTextStyle.mobileNumberTextStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _supplierDetailText(
                        AppAssets.icPerson, item.contactPersonName),
                    const Spacer(),
                    _supplierDetailText(AppAssets.icPhone, item.mobileNumber),
                  ],
                ),
                const SizedBox(
                  height: 6,
                ),
                _supplierDetailText(AppAssets.icMail, item.emailId ?? "N/A"),
              ],
            ),
          ),
        ),
      );

  Widget _supplierDetailText(image, title) => Row(
        children: [
          Container(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: SvgPicture.asset(
                image,
                width: 15,
                height: 15,
              ),
            ),
          ),
          Text(
            title,
            style: CustomTextStyle.smallTextStyle,
          ),
        ],
      );
}
