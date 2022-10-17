import 'package:flutter/material.dart';

import '../../../exports/resources.dart';
import '../../../exports/utilities.dart';
import '../../../exports/widgets.dart';
import '../../widgets/custom_radio_widget.dart';

/// Created by Dev 2183 on 12/14/2021
/// Modified by Dev 2183 on 12/14/2021
/// Purpose : No Order Screen --> radio selection view

class NoOrderRadioSelectionView extends StatefulWidget {
  NoOrderRadioSelectionView(
      {this.list,
      this.hasSpaceBetween = true,
      this.fontSize,
      this.fontWeight,
      this.onTap,
      Key? key})
      : super(key: key);
  List<RadioSelectionItemModel>? list;
  final bool hasSpaceBetween;
  final double? fontSize;
  final FontWeight? fontWeight;
  Function? onTap;

  @override
  _NoOrderRadioSelectionViewState createState() =>
      _NoOrderRadioSelectionViewState();
}

class _NoOrderRadioSelectionViewState extends State<NoOrderRadioSelectionView> {
  @override
  Widget build(BuildContext context) => Container(
        child: _radioSelectionView(),
      );

/*
  ///selection view
  Widget _radioSelectionView() => Column(
        children: widget.list!
            .map(
              (e) => _radioItem(e),
            )
            .toList(),
      );*/

  ///selection view
  Widget _radioSelectionView() => ListView.builder(
        itemCount: widget.list!.length,
        shrinkWrap: true,
        itemBuilder: (context, index) => _radioItem(widget.list![index]),
      );

  Widget _radioItem(RadioSelectionItemModel item) => CustomRadioWidget(
        labelText: item.title,
        value: item.isSelected,
        onChanged: (value) {
          _onChanged(item);
        },
        radioSelection: true,
        fontSize: widget.fontSize,
        fontWeight: widget.fontWeight,
        isHorizontal: false,
      );

  void _onChanged(RadioSelectionItemModel e) {
    setState(() {
      for (final item in widget.list!) {
        if (e.title == item.title) {
          item.isSelected = true;
        } else {
          item.isSelected = false;
        }
      }
      widget.list!.forEach((element) {
        if (element.id == e.id) {
          element.isSelected = e.isSelected;
        }
      });
      if (widget.onTap != null) widget.onTap!(e.id);
    });
  }
}
