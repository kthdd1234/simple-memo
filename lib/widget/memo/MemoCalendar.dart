import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonCalendar.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:table_calendar/table_calendar.dart';

class MemoCalendar extends StatefulWidget {
  MemoCalendar({
    super.key,
    required this.isShowCalendar,
    required this.onShowCalendar,
  });

  bool isShowCalendar;
  Function() onShowCalendar;

  @override
  State<MemoCalendar> createState() => _MemoCalendarState();
}

class _MemoCalendarState extends State<MemoCalendar> {
  onDaySelected(DateTime dateTime) {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  Widget? markerBuilder(bool isLight, DateTime dateTime) {
    return null;
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return widget.isShowCalendar
        ? CommonCalendar(
            selectedDateTime: selectedDateTime,
            calendarFormat: CalendarFormat.month,
            shouldFillViewport: false,
            markerBuilder: markerBuilder,
            onDaySelected: onDaySelected,
            onPageChanged: (_) {},
            onFormatChanged: (_) {},
          )
        : const CommonNull();
  }
}
