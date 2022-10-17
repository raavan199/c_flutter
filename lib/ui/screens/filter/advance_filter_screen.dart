import 'dart:collection';

import 'package:cygneto/blocs/base/base_bloc.dart';
import 'package:cygneto/blocs/filter/filter_bloc.dart';
import 'package:cygneto/data/models/product_category_list/product_category_list_data_items_response.dart';
import 'package:cygneto/data/models/product_group_list/product_group_item.dart';
import 'package:cygneto/ui/screens/base/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../data/models/entities/filter_data_model.dart';
import '../../../exports/mixins.dart';
import '../../../exports/resources.dart';
import '../../../exports/themes.dart';
import '../../../exports/widgets.dart';
import 'filter_list_view.dart';

/// Created by Dev 2301 on 12/14/2021
/// Modified by Dev 2301 on 12/14/2021
/// Purpose : filter screen for orders
class AdvanceFilterScreen extends StatefulWidget {
  Map<String, int?> filterResult;

  AdvanceFilterScreen(this.filterResult);

  @override
  _AdvanceFilterScreenState createState() => _AdvanceFilterScreenState();
}

class _AdvanceFilterScreenState extends State<AdvanceFilterScreen>
    with UtilityMixin {
  final int _headerSectionFlex = 2;
  final int _itemSectionFlex = 3;
  List<ProductGroupItems> _groupItemList = [];
  List<ProductGroupItems> _subGroupItemList = [];
  List<ProductCategoryListDataItemsResponse> _categoryList = [];
  List<ProductCategoryListDataItemsResponse> _subCategoryList = [];
  List<int> _filtersIdList = [];

  late FilterBloc _bloc;
  List<FilterSectionModel> sectionList = [];

  int? subGroupId, catId, subCatId;

  // bool GID=true,SGID=true,CID=true

  @override
  void initState() {
    super.initState();
    print("filter screen:${widget.filterResult}");
    sectionList.addAll([
      FilterSectionModel(
        "Group",
        AppAssets.icUserGroup,
      ),
      FilterSectionModel("Sub-Group", AppAssets.icUserGroup),
      FilterSectionModel("Categories", AppAssets.icDashboard),
      FilterSectionModel("Sub-Categ.", AppAssets.icDashboard),
    ]);
  }

  @override
  Widget build(BuildContext context) => BaseScreen<FilterBloc>(
    onBlocReady: (bloc) {
      _bloc = bloc;
      _bloc.add(GetGroupListFromDB());
      _bloc.add(GetCategoryListFromDB());
      if(widget.filterResult.isNotEmpty){
        if(widget.filterResult.containsKey('groupId')&&
            widget.filterResult['groupId']!=null){
          _bloc.add(GetSubGroupListFromDB(id:widget.filterResult['groupId']!));
        }
        if(widget.filterResult.containsKey('catId')&&
            widget.filterResult['catId']!=null){
          _bloc.add(GetSubCategoryListFromDB(id:widget.filterResult['catId']!));
        }
      }

    },
    builder: (context, bloc, child) => BlocListener<FilterBloc, BaseState>(
      listener: (context, state) {
        if (state is FilterGroupSuccessState) {
          _groupItemList = state.data;
          // final categoryList = _getSubItems(_getSelectedItem(subGroupList));
          //  final subCategoryList = _getSubItems(_getSelectedItem(categoryList));

          print('group list ${_groupItemList.length}');
          // _bloc.add(GetTotalCustomerCountFromDB());
        } else if (state is FilterGroupFailedState) {
          showSnackBar(context, state.msg ?? "");
        } else if (state is FilterSubGroupSuccessState) {
          _subGroupItemList = state.data;
          print('sub group list ${_groupItemList.length}');
        } else if (state is FilterSubGroupFailedState) {
          showSnackBar(context, state.msg ?? "");
        } else if (state is FilterCategorySuccessState) {
          _categoryList = state.data;
          print('category list ${_groupItemList.length}');
        } else if (state is FilterCategoryFailedState) {
          showSnackBar(context, state.msg ?? "");
        } else if (state is FilterSubCategorySuccessState) {
          _subCategoryList = state.data;
          print('sub category list ${_groupItemList.length}');
        } else if (state is FilterSubCategoryFailedState) {
          showSnackBar(context, state.msg ?? "");
        }
      },
      child: Scaffold(
        appBar: CustomAppBar(
          hasBack: true,
          title: AppStrings.lblFilters,
          actions: [_btnClearFilter()],
        ),
        body: CommonContainer(
          child: Stack(
            children: [
              _bg(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20,
                        left: AppStyles.pageSideMargin,
                        right: AppStyles.pageSideMargin),
                    child: ListView(
                      children: [
                        _sectionGruopItem(sectionList[0], _groupItemList),
                        if (_subGroupItemList.isNotEmpty)
                          _sectionSubGroupItem(
                              sectionList[1], _subGroupItemList),
                        if (_categoryList.isNotEmpty)
                          _sectionCategoryItem(
                              sectionList[2], _categoryList),
                        if (_subCategoryList.isNotEmpty)
                          _sectionSubCategoryItem(
                              sectionList[3], _subCategoryList),
                      ],
                    ),
                  )),
                  _bottomButtonView(),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );

  Widget _sectionGruopItem(
    FilterSectionModel item,
    List<ProductGroupItems> list,
  ) =>
      Row(
        children: [
          /// group/subgroup/category/sub category header
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  item.icon,
                  height: 17,
                  width: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: AppFonts.normal,
                        color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),

          /// respective item list
          Expanded(
            child: Column(
              children: [
                _groupListView(list),
                Container(
                  height: 1,
                  color: AppColors.filterBg,
                )
              ],
            ),
          )
        ],
      );

  Widget _groupListView(List<ProductGroupItems> list) => ListView.builder(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = list[index];
          return CustomRadioWidget(
            labelText: item.name,
            value:widget.filterResult['groupId']==item.id,
            onChanged: (value) {
              _onGroupChanged(list, item);
            },
            radioSelection: true,
            fontSize: 12,
          );
        },
      );

  ///change selection
  void _onGroupChanged(
      List<ProductGroupItems> list, ProductGroupItems selectedItem) {
    setState(() {
      for (final i in list) {
        print("id: ${i.id} group id ${selectedItem.groupId}");
        if (selectedItem.name == i.name) {
          if (widget.filterResult.containsKey('groupId')) {
            if (widget.filterResult['groupId'] != selectedItem.id) {
              widget.filterResult['groupId'] = selectedItem.id;
              widget.filterResult['subGroupId'] = null;
              _subGroupItemList.clear();
            }
          } else {
            widget.filterResult['groupId'] = selectedItem.id;
          }
          i.isSelected = true;
          _bloc.add(GetSubGroupListFromDB(id: selectedItem.id!));
        } else {
          i.isSelected = false;
        }
      }
    });
  }

  Widget _sectionSubGroupItem(
    FilterSectionModel item,
    List<ProductGroupItems> list,
  ) =>
      Row(
        children: [
          /// group/subgroup/category/sub category header
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  item.icon,
                  height: 17,
                  width: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: AppFonts.normal,
                        color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),

          /// respective item list
          Expanded(
            child: Column(
              children: [
                _subGroupListView(list),
                Container(
                  height: 1,
                  color: AppColors.filterBg,
                )
              ],
            ),
          )
        ],
      );

  Widget _subGroupListView(List<ProductGroupItems> list) => ListView.builder(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = list[index];
          return CustomRadioWidget(
            labelText: item.name,
            value:widget.filterResult['subGroupId']==item.id,
            onChanged: (value) {
              _onSubGroupChanged(list, item);
            },
            radioSelection: true,
            fontSize: 12,
          );
        },
      );

  ///change selection
  void _onSubGroupChanged(
      List<ProductGroupItems> list, ProductGroupItems selectedItem) {
    setState(() {
      for (final i in list) {
        if (selectedItem.name == i.name) {
          if (widget.filterResult.containsKey('subGroupId')) {
            if (widget.filterResult['subGroupId'] != selectedItem.id) {
              widget.filterResult['subGroupId'] = selectedItem.id;
            }
          } else {
            widget.filterResult['subGroupId'] = selectedItem.id;
          }

          i.isSelected = true;
          _bloc.add(GetCategoryListFromDB());
        } else {
          i.isSelected = false;
        }
      }
    });
  }

  Widget _sectionCategoryItem(
    FilterSectionModel item,
    List<ProductCategoryListDataItemsResponse> list,
  ) =>
      Row(
        children: [
          /// group/subgroup/category/sub category header
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  item.icon,
                  height: 17,
                  width: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: AppFonts.normal,
                        color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),

          /// respective item list
          Expanded(
            child: Column(
              children: [
                _categoryListView(list),
                Container(
                  height: 1,
                  color: AppColors.filterBg,
                )
              ],
            ),
          )
        ],
      );

  Widget _categoryListView(List<ProductCategoryListDataItemsResponse> list) =>
      ListView.builder(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = list[index];
          return CustomRadioWidget(
            labelText: item.name,
            value:widget.filterResult['catId']==item.id,
            onChanged: (value) {
              _onCategoryChanged(list, item);
            },
            radioSelection: true,
            fontSize: 12,
          );
        },
      );

  ///change selection
  void _onCategoryChanged(List<ProductCategoryListDataItemsResponse> list,
      ProductCategoryListDataItemsResponse selectedItem) {
    setState(() {
      for (final i in list) {
        if (selectedItem.name == i.name) {
          if (widget.filterResult.containsKey('catId')) {
            if (widget.filterResult['catId'] != selectedItem.id) {
              widget.filterResult['catId'] = selectedItem.id;
              widget.filterResult['subCatId'] = null;
              _subCategoryList.clear();
            }
          } else {
            widget.filterResult['catId'] = selectedItem.id;
          }

          i.isSelected = true;
          _bloc.add(GetSubCategoryListFromDB(id: selectedItem.id!));
        } else {
          i.isSelected = false;
        }
      }
    });
  }

  Widget _sectionSubCategoryItem(
    FilterSectionModel item,
    List<ProductCategoryListDataItemsResponse> list,
  ) =>
      Row(
        children: [
          /// group/subgroup/category/sub category header
          Expanded(
            child: Row(
              children: [
                SvgPicture.asset(
                  item.icon,
                  height: 17,
                  width: 17,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 13,
                        fontWeight: AppFonts.normal,
                        color: AppColors.black),
                  ),
                ),
              ],
            ),
          ),

          /// respective item list
          Expanded(
            child: Column(
              children: [
                _subCategoryListView(list),
                Container(
                  height: 1,
                  color: AppColors.filterBg,
                )
              ],
            ),
          )
        ],
      );

  Widget _subCategoryListView(
          List<ProductCategoryListDataItemsResponse> list) =>
      ListView.builder(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = list[index];
          return CustomRadioWidget(
            labelText: item.name,
            value:widget.filterResult['subCatId']==item.id,
            onChanged: (value) {
              _subCategoryChange(list, item);
            },
            radioSelection: true,
            fontSize: 12,
          );
        },
      );

  ///change selection
  void _subCategoryChange(List<ProductCategoryListDataItemsResponse> list,
      ProductCategoryListDataItemsResponse selectedItem) {
    setState(() {
      for (final i in list) {
        if (selectedItem.name == i.name) {
          if (widget.filterResult.containsKey('subCatId')) {
            if (widget.filterResult['subCatId'] != selectedItem.id) {
              widget.filterResult['subCatId'] = selectedItem.id;
            }
          } else {
            widget.filterResult['subCatId'] = selectedItem.id;
          }
          i.isSelected = true;
          // _bloc.add(GetCategoryListFromDB());
        } else {
          i.isSelected = false;
        }
      }
    });
  }

  Widget _bg() => Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  flex: _headerSectionFlex,
                  child: Container(
                    color: AppColors.filterBg,
                    // color: Colors.grey,
                  ),
                ),
                Expanded(
                  flex: _itemSectionFlex,
                  child: Container(
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        ],
      );

  Widget _btnClearFilter() => Center(
        child: InkWell(
          onTap: _onClear,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Text(
              AppStrings.lblClearFilter,
              style: TextStyle(
                  color: AppColors.white,
                  decoration: TextDecoration.underline,
                  fontSize: 14),
            ),
          ),
        ),
      );

  Widget _bottomButtonView() => appCommonFlatButton(
        btnTxt: AppStrings.lblApplyFilter,
        onPressed: _onApply,
      );

  void _onApply() {
    // Map<String,int?> map=HashMap();
    // map['groupId']=groupId;
    // map['subGroupId']=subGroupId;
    // map['catId']=catId;
    // map['subCatId']=subCatId;

    Navigator.of(context).pop(widget.filterResult);
  }

  void _onClear() {
    //Navigator.of(context).pop();
    setState(() {

      widget.filterResult=HashMap();
      _subGroupItemList.clear();
      _subCategoryList.clear();
    });
  }

  bool _checkSelected(int? id, var model, String tag) {
    print("check selected $id==${model.id}");

    if (id == model.id) {
      if (tag.contains("GID")) {
        //_bloc.add(GetSubGroupListFromDB(id:model.id!));
      } else if (tag.contains("SGID")) {
        // _bloc.add(GetCategoryListFromDB());
      } else if (tag.contains("CID")) {
        // _bloc.add(GetSubCategoryListFromDB(id:model.id!));
      }
      return true;
    } else {
      return false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
