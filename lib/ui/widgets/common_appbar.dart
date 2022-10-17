import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../exports/mixins.dart';
import '../../exports/resources.dart';

/// Created by Dev 2301 on 11/30/2021
/// Modified by Dev 2301 on 11/30/2021
/// Purpose : commonly used custom app bar widget of the app
class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  CustomAppBar(
      {this.hasBack = false,
      this.title,
      this.actions,
      this.date,
      this.backTap,
      this.selectedDate,
      this.calenderRequired,
      Key? key})
      : super(key: key);
  final bool hasBack;
  final String? title;
  final String? date;
  final List<Widget>? actions;
  final Function? backTap;
  Function? selectedDate;
  bool? calenderRequired = false;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  static Widget backButton(BuildContext context) => InkWell(
        highlightColor: Colors.transparent,
        onTap: () => Navigator.of(context).pop(),
        child: const SizedBox(
          height: 30,
          width: 30,
          child: Center(
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.tabBackground,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.white,
                size: 14,
              ),
            ),
          ),
        ),
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> with UtilityMixin{

  DateTime? selectDate;
  @override
  Widget build(BuildContext context) => AppBar(
        backgroundColor: AppColors.primary,
        title: widget.title == null
            ? Container(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                  AppAssets.icLogoLarge,
                  height: 35,
                ),
            )
            : getTitleAndDate(context, widget.date, widget.title!),
        leading: widget.hasBack ? _back(context) : _home(context),
        elevation: 0,
        actions: widget.actions,
      );

  Widget _back(BuildContext context) => InkWell(
        highlightColor: Colors.transparent,
        onTap: () {
          if (widget.backTap != null) {
            widget.backTap?.call();
          } else {
            Navigator.of(context).pop();
          }
        },
        child: const SizedBox(
          height: 15,
          width: 15,
          child: Center(
            child: CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.tabBackground,
              child: Icon(
                Icons.arrow_back_ios_rounded,
                color: AppColors.white,
                size: 14,
              ),
            ),
          ),
        ),
      );

  Widget getTitleAndDate(BuildContext context, String? date, String title) =>
      Row(
        children: [
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: AppFonts.bold),
            ),
          ),
          Visibility(visible: date != null, child: getDateView(context, date))
        ],
      );

  Widget _home(BuildContext context) => InkWell(
        highlightColor: Colors.transparent,
        onTap: () => Scaffold.of(context).openDrawer(),
        child: SizedBox(
          height: 15,
          width: 15,
          child: Center(
            child: SvgPicture.asset(
              AppAssets.icSideMenu,
              color: AppColors.white,
              height: 30,
              width: 30,
            ),
          ),
        ),
      );

  Widget getDateView(BuildContext context, String? date) => InkWell(
        onTap: () {
          if (widget.calenderRequired!) {
            DatePicker.showDatePicker(context,
                minTime: DateTime(DateTime.now().year - 1),
                maxTime: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day),
                onChanged: (date) {}, onConfirm: (date) {
              selectDate = date;
              widget.selectedDate!(date);
            }, currentTime: selectDate ?? DateTime.now());
          }
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              AppAssets.icCalendar,
              height: 15,
              width: 15,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5, right: 5, top: 2),
              child: Text(date ?? "",
                  style: const TextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                      fontWeight: AppFonts.normal)),
            )
          ],
        ),
      );
}
