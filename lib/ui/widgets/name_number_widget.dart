import 'package:flutter/widgets.dart';

import '../../exports/themes.dart';

class NameNumberWidget extends StatefulWidget {
  const NameNumberWidget({
    this.retailerName,
    this.number,
    Key? key,
  }) : super(key: key);

  final String? retailerName;
  final String? number;

  @override
  State<StatefulWidget> createState() => _NameNumberWidgetState();
}

class _NameNumberWidgetState extends State<NameNumberWidget> {
  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${widget.retailerName}',
            style: CustomTextStyle.retailerNameTextStyle,
          ),
          Text(
            ' | ${widget.number}',
            style: CustomTextStyle.mobileNumberTextStyle,
          ),
        ],
      );
}
