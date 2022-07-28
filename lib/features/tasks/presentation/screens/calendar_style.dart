import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../constatns/colors.dart';

HeaderStyle myHeaderStyle() {
  return HeaderStyle(
      titleTextStyle: const TextStyle(color: Colors.white),
      formatButtonVisible: false,
      leftChevronVisible: false,
      rightChevronVisible: false,
      headerPadding: EdgeInsets.symmetric(vertical: 15.h),
      titleCentered: true);
}

CalendarStyle MyCalendarStyle() {
  return const CalendarStyle(
    markerDecoration:
        BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
    defaultTextStyle:
        TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
    todayTextStyle:
        TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.w500),
    todayDecoration: BoxDecoration(),
    weekendTextStyle:
        TextStyle(color: AppColors.taskYellow, fontWeight: FontWeight.w500),
  );
}
