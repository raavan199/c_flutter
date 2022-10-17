import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../exports/resources.dart';
import '../../exports/utilities.dart';
import 'custom_radio_widget.dart';

/// Created by Dev 2301 on 12/9/2021
/// Modified by Dev 2301 on 12/9/2021
/// Purpose : missed punch page --> radio selection view
///  Apply leave screen --> radio selection view
class RadioSelectionView extends StatefulWidget {
  const RadioSelectionView(
      {required this.list,
      this.hasDecoration = true,
      this.hasSpaceBetween = true,
      this.fontSize,
      this.fontWeight,
      required this.onItemChanged,
      Key? key})
      : super(key: key);
  final List<RadioSelectionItemModel> list;
  final bool hasDecoration;
  final bool hasSpaceBetween;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Function onItemChanged;

  @override
  _RadioSelectionViewState createState() => _RadioSelectionViewState();
}

class _RadioSelectionViewState extends State<RadioSelectionView> {
  @override
  Widget build(BuildContext context) => widget.hasDecoration
      ? Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [Shadows.greyShadow],
            borderRadius: BorderRadius.circular(5),
          ),
          margin: const EdgeInsets.symmetric(vertical: 15),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, child: _radioSelectionView()),
        )
      : SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: _radioSelectionView());

  ///selection view
  Widget _radioSelectionView() => Row(
        children: widget.list
            .map(
              (e) => _radioItem(e),
            )
            .toList(),
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
    height: 40,
    isHorizontal: true,
      );

  void _onChanged(RadioSelectionItemModel e) {
    setState(() {
      for (final item in widget.list) {
        if (e.title == item.title) {
          widget.onItemChanged(e);
          item.isSelected = true;
        } else {
          item.isSelected = false;
        }
      }
    });
  }
}

class RadioSelectionItemModel {
  RadioSelectionItemModel(this.title, {this.id,this.isSelected = false});
  int? id;
  String title;
  bool isSelected;
}
