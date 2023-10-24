import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final Function(DateTime)? onHeaderTapped;
  final Function(DateTime, DateTime) onDaySelected;
  const CustomTableCalendar({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    this.onHeaderTapped,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    Intl.defaultLocale = 'ko_KR';

    return TableCalendar(
      locale: 'ko_KR',
      firstDay: DateTime.utc(2023, 1, 1),
      lastDay: DateTime.utc(2032, 12, 31),
      focusedDay: focusedDay,
      rowHeight: 40.0,
      onHeaderTapped: onHeaderTapped,
      onDaySelected: onDaySelected,
      selectedDayPredicate: (day) => isSameDay(selectedDay, day),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontSize: 25.sp,
          fontWeight: FontWeight.bold,
        ),
        // 임시 값으로 추후 수정시에 바꿔주세용
        // leftChevronVisible: false,
        // rightChevronVisible: false,

        headerMargin: const EdgeInsets.only(bottom: 25.0),
      ),
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: false,
        outsideDaysVisible: false,
        selectedTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        defaultTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        todayTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
