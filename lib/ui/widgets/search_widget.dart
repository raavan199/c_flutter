import 'package:flutter/material.dart';

import '../../exports/models.dart';
import '../../exports/resources.dart';
import '../../exports/utilities.dart';

/// Created by Dev 2301 on 12/4/2021
/// Modified by Dev 2301 on 12/4/2021
/// Purpose : search component
class SearchWidget extends StatefulWidget {
  SearchWidget(
      {required this.dataList,
      required this.onResult,
      required this.searchHint,
      Key? key})
      : super(key: key);
  final List<SearchModel> dataList;
  final Function(List<SearchModel>) onResult;
  final String searchHint;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  static const tag = "SearchWidget";
  final TextEditingController _searchController = TextEditingController();

  bool _isSearchExpanded = false;
  String _searchText = "";
  List<SearchModel> searchResult = [];

  @override
  void initState() {
    _searchController.addListener(() {
      if (_searchController.text.isEmpty) {
        setState(() {
          _searchText = "";
        });
      } else {
        setState(() {
          _searchText = _searchController.text;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_isSearchExpanded)
            //if (widget.isSearchExpanded)
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: [Shadows.greyShadow],
                ),
                height: 45,
                // width: 45,
                child: _searchField(),
              ),
            )
          else
            InkWell(
              onTap: () {
                setState(() {
                  _isSearchExpanded = true;
                });
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [Shadows.greyShadow],
                ),
                height: 45,
                width: 45,
                child: const Icon(
                  Icons.search,
                  size: 25,
                ),
              ),
            ),
        ],
      );

  Widget _searchField() => TextField(
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.black),
        controller: _searchController,
        onChanged: searchOperation,
        autofocus: _isSearchExpanded,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.close,
              color: AppColors.black,
              size: 25,
            ),
            onPressed: _onSearchCancel,
          ),
          /*   prefixIcon: Icon(
            Icons.search,
            color: AppColors.black,
            size: 25,
          ),*/
          hintText: widget.searchHint,
          hintStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.black),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      );

  void searchOperation(String value) {
    searchResult.clear();
    final data = widget.dataList;
    for (var i = 0; i < data.length; i++) {
      // if (data[i].searchable.toLowerCase().contains(value)) {
      if (data[i].searchable.toLowerCase().contains(value.toLowerCase())) {
        searchResult.add(data[i]);
      }
    }
    widget.onResult(searchResult);
    Logger.d(tag, searchResult);
  }

  void _onSearchCancel() {
    setState(() {
      _isSearchExpanded = false;
      _searchController.clear();
      widget.onResult(widget.dataList);
      searchResult.clear();
      FocusScope.of(context).unfocus();
    });
  }
}
