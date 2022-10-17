import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../exports/models.dart';
import '../../../exports/resources.dart';
import '../../../exports/widgets.dart';

/// Created by Dev 2301 on 12/15/2021
/// Modified by Dev 2301 on 12/15/2021
/// Purpose : filter list view widget
class FilterListView extends StatefulWidget {
  const FilterListView(
      {required this.data,
      this.headerSectionFlex = 2,
      this.itemSectionFlex = 3,
      Key? key})
      : super(key:key);
  final List<FilterItemModel> data;
  final int headerSectionFlex;
  final int itemSectionFlex;
  @override
  _FilterListViewState createState() => _FilterListViewState();
}

class _FilterListViewState extends State<FilterListView> {
  List<FilterSectionModel> sectionList = [];

  ///method to get selected item from given list
  FilterItemModel? _getSelectedItem(List<FilterItemModel> list) {
    for (final item in list) {
      if (item.isSelected) {
        return item;
      }
    }
    return null;
  }

  ///method to get sub items list of given item
  List<FilterItemModel> _getSubItems(FilterItemModel? item) =>
      item?.subItems ?? [];

  @override
  void initState() {
    sectionList.addAll([
      FilterSectionModel(
        "Group",
        AppAssets.icUserGroup,
      ),
      FilterSectionModel("Sub-Group", AppAssets.icUserGroup),
      FilterSectionModel("Categories", AppAssets.icDashboard),
      FilterSectionModel("Sub-Categ.", AppAssets.icDashboard),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) => _sectionListView();

  Widget _sectionListView() {
    final groupList = widget.data;
    final subGroupList = _getSubItems(_getSelectedItem(groupList));
    final categoryList = _getSubItems(_getSelectedItem(subGroupList));
    final subCategoryList = _getSubItems(_getSelectedItem(categoryList));
    return ListView(
      padding: const EdgeInsets.only(
          top: 20,
          left: AppStyles.pageSideMargin,
          right: AppStyles.pageSideMargin),
      // itemCount: list.length,
      children: [
        _sectionItem(sectionList[0], groupList),
        if (subGroupList.isNotEmpty) _sectionItem(sectionList[1], subGroupList),
        if (categoryList.isNotEmpty) _sectionItem(sectionList[2], categoryList),
        if (subCategoryList.isNotEmpty)
          _sectionItem(sectionList[3], subCategoryList),
      ],
    );
  }

  Widget _sectionItem(FilterSectionModel item, List<FilterItemModel> list) =>
      Row(
        children: [
          /// group/subgroup/category/sub category header
          Expanded(
            flex: widget.headerSectionFlex,
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
            flex: widget.itemSectionFlex,
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

  Widget _groupListView(List<FilterItemModel> list) => ListView.builder(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 10),
        itemCount: list.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final item = list[index];
          return CustomRadioWidget(
            labelText: item.name,
            value: item.isSelected,
            onChanged: (value) {
              _onChanged(list, item);
            },
            radioSelection: true,
            fontSize: 12,
          );
        },
      );

  ///change selection
  void _onChanged(List<FilterItemModel> list, FilterItemModel selectedItem) {
    setState(() {
      for (final i in list) {
        if (selectedItem.name == i.name) {
          i.isSelected = true;
        } else {
          i.isSelected = false;
        }
      }
    });
  }
}

class FilterSectionModel {
  FilterSectionModel(
    this.name,
    this.icon,
    /*{
    this.isVisible = false,
  }*/
  );

  final String name;
  final String icon;
  // bool isVisible;
}
