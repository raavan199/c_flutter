import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../exports/resources.dart';
import '../../exports/themes.dart';

class CalendarHeader extends StatefulWidget {
  CalendarHeader({this.selectedMonth,required this.month, Key? key}) : super(key: key);
  DateTime month;
  Function? selectedMonth;

  @override
  State<CalendarHeader> createState() => _CalendarHeaderState();
}

class _CalendarHeaderState extends State<CalendarHeader> {
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.calendarHeaderMargin, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  widget.month = DateTime(widget.month.year, widget.month.month - 1, 1);
                  widget.selectedMonth!(widget.month);
                });
              },
              child: const Icon(Icons.arrow_back_ios_rounded),
            ),
            Text(
              DateFormat('MMMM yyyy').format(widget.month),
              style: CustomTextStyle.calendarHeaderTextStyle,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  widget.month = DateTime(widget.month.year, widget.month.month + 1, 1);
                  widget.selectedMonth!(widget.month);
                });
              },
              child: const Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        ),
      );
}
