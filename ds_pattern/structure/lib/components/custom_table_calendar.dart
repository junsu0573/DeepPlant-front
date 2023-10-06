import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomTableCalendar extends StatelessWidget {
  final DateTime focusedDay;
  late final DateTime selectedDay;
  final Function(DateTime)? onHeaderTapped;
  final Function(DateTime, DateTime) onDaySelected;
  CustomTableCalendar({
    super.key,
    required this.focusedDay,
    this.onHeaderTapped,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
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
        titleTextStyle: TextStyle(
          fontSize: 17.0,
          fontWeight: FontWeight.bold,
        ),
        // 임시 값으로 추후 수정시에 바꿔주세용
        // leftChevronVisible: false,
        // rightChevronVisible: false,
        headerPadding: EdgeInsets.only(right: 230.0),
        headerMargin: EdgeInsets.only(bottom: 25.0),
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        selectedTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        defaultTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        todayTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
      ),
    );
  }
}
