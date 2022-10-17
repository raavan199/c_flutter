import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/app_constants.dart';
import '../../data/models/attendance/attendance_item.dart';
import '../../exports/mixins.dart';
import '../../exports/resources.dart';
import '../../exports/themes.dart';
import '../../exports/utilities.dart';

class EventCalendar extends StatefulWidget {
  EventCalendar(
      {Key? key,
      required this.selectedDate,
      required this.selectedMonth,
      required this.list})
      : super(key: key);

  List<AttendanceItem> list;
  Function selectedDate;
  Function selectedMonth;

  @override
  _EventCalendarState createState() => _EventCalendarState();
}

class _EventCalendarState extends State<EventCalendar> with UtilityMixin {
  late final ValueNotifier<List<Event>> _selectedEvents;
  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var attendanceItem;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) => kEvents[day] ?? [];

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      });
      widget.selectedDate(_selectedDay);

      _selectedEvents.value = _getEventsForDay(selectedDay);
      print(selectedDay);
    }
  }

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(
            left: AppStyles.calendarMargin, right: AppStyles.calendarMargin),
        child: TableCalendar<Event>(
          calendarFormat: _calendarFormat,
          availableCalendarFormats: const {
            CalendarFormat.month: 'Month',
          },
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            headerMargin: const EdgeInsets.only(
                right:
                    AppStyles.calendarHeaderMargin - AppStyles.calendarMargin,
                left: AppStyles.calendarHeaderMargin - AppStyles.calendarMargin,
                top: 5,
                bottom: 10),
            leftChevronIcon: const Icon(Icons.arrow_back_ios_rounded),
            rightChevronIcon: const Icon(Icons.arrow_forward_ios_rounded),
            titleTextStyle: CustomTextStyle.calendarHeaderTextStyle,
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            dowTextFormatter: (date, locale) =>
                DateFormat.E(locale).format(date)[0],
            weekdayStyle: CustomTextStyle.calendarHeaderTextStyle,
            weekendStyle: CustomTextStyle.calendarHeaderTextStyle,
          ),
          availableGestures: AvailableGestures.horizontalSwipe,
          focusedDay: _focusedDay,
          calendarStyle: CalendarStyle(
            outsideDaysVisible: false,
            todayDecoration: _dateDecoration(AppColors.primary),
            markerSize: 0,
          ),
          firstDay: kFirstDay,
          lastDay: kLastDay,

          ///determine which days are selected
          selectedDayPredicate: (day) {
            return _getSelectedDay(day);
          },

          ///selected date builder
          calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, day, focusedDay) => Center(
                    child: Container(
                      height: 35,
                      width: 35,
                      decoration: _dateDecoration(_getColor(day)),
                      child: Center(
                        child: Text(
                          day.day.toString(),
                          style: const TextStyle(
                              color: AppColors.black, fontSize: 12),
                        ),
                      ),
                    ),
                  )),

          eventLoader: _getEventsForDay,

          onDaySelected: _onDaySelected,
          // onRangeSelected: _onRangeSelected,
          // onFormatChanged: (format) {
          //   if (_calendarFormat != format) {
          //     setState(() {
          //       _calendarFormat = format;
          //     });
          //   }
          // },
          onPageChanged: (focusedDay) {
            _focusedDay = focusedDay;
            widget.selectedMonth(focusedDay);
          },
        ),
      );

  BoxDecoration _dateDecoration(Color color) =>
      BoxDecoration(color: color, shape: BoxShape.circle);

  Color _getColor(DateTime day) {
    attendanceItem = widget.list.firstWhereOrNull(
        (e) => getDateFromDate(day) == getDateFromDateTime(e.created_on!));

    if (attendanceItem == null) {
      return const Color(0xffADD8E6);
    } else if (attendanceItem.isSync == SyncStatus.sync) {
      return const Color(0xff00C914);
    } else if (attendanceItem.isSync == SyncStatus.unSync) {
      return const Color(0xffFA4751);
    }
    return AppColors.primary;
  }

  bool _getSelectedDay(DateTime day) {
    attendanceItem = widget.list.firstWhereOrNull(
        (e) => getDateFromDate(day) == getDateFromDateTime(e.created_on!));

    if (attendanceItem == null) {
      return false;
    } else {
      return true;
    }
  }
}
