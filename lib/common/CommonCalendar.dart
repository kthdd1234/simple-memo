import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CommonCalendar extends StatefulWidget {
  CommonCalendar({
    super.key,
    required this.selectedDateTime,
    required this.calendarFormat,
    required this.shouldFillViewport,
    required this.markerBuilder,
    this.todayBuilder,
    required this.onPageChanged,
    required this.onDaySelected,
    required this.onFormatChanged,
  });

  DateTime selectedDateTime;
  CalendarFormat calendarFormat;
  bool shouldFillViewport;
  Function(bool, DateTime) markerBuilder;
  Function(bool, DateTime)? todayBuilder;
  Function(DateTime) onPageChanged, onDaySelected;
  Function(CalendarFormat) onFormatChanged;

  @override
  State<CommonCalendar> createState() => _CommonCalendarState();
}

class _CommonCalendarState extends State<CommonCalendar> {
  Widget? dowBuilder(bool isLight, DateTime dateTime) {
    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    String locale = context.locale.toString();
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? themeColor
                : Colors.white;

    return CommonText(
      text: eFormatter(locale: locale, dateTime: dateTime),
      color: color,
      fontSize: fontSize - 2,
      isNotTr: true,
    );
  }

  Widget? defaultBuilder(bool isLight, DateTime dateTime) {
    Color color = dateTime.weekday == 6
        ? blue.original
        : dateTime.weekday == 7
            ? red.original
            : isLight
                ? themeColor
                : Colors.white;

    return Column(
      children: [
        CommonSpace(height: 13.5),
        CommonText(text: '${dateTime.day}', color: color, isNotTr: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    String locale = context.locale.toString();
    bool isLight = context.watch<ThemeProvider>().isLight;

    tableCalendar() {
      return TableCalendar(
        locale: locale,
        sixWeekMonthsEnforced: true,
        shouldFillViewport: widget.shouldFillViewport,
        calendarStyle: CalendarStyle(
          cellMargin: const EdgeInsets.all(14),
          cellAlignment: widget.shouldFillViewport
              ? Alignment.topCenter
              : Alignment.center,
          todayDecoration: BoxDecoration(
            color: isLight ? themeColor : calendarSelectedDateTimeBgColor,
            shape: BoxShape.circle,
          ),
          todayTextStyle: TextStyle(
            color: isLight ? Colors.white : calendarSelectedDateTimeTextColor,
            fontSize: fontSize - 2,
          ),
        ),
        availableGestures: widget.shouldFillViewport
            ? AvailableGestures.horizontalSwipe
            : AvailableGestures.all,
        calendarBuilders: CalendarBuilders(
          defaultBuilder: (cx, dateTime, _) =>
              defaultBuilder(isLight, dateTime),
          dowBuilder: (cx, dateTime) => dowBuilder(isLight, dateTime),
          markerBuilder: (cx, dateTime, _) =>
              widget.markerBuilder(isLight, dateTime),
          todayBuilder: widget.todayBuilder != null
              ? (cx, dateTime, _) => widget.todayBuilder!(isLight, dateTime)
              : null,
        ),
        headerVisible: false,
        firstDay: DateTime.utc(2000, 1, 1),
        lastDay: DateTime.utc(3000, 1, 1),
        currentDay: widget.selectedDateTime,
        focusedDay: widget.selectedDateTime,
        calendarFormat: widget.calendarFormat,
        availableCalendarFormats: availableCalendarFormats,
        onPageChanged: widget.onPageChanged,
        onDaySelected: (dateTime, _) => widget.onDaySelected(dateTime),
        onFormatChanged: widget.onFormatChanged,
      );
    }

    return tableCalendar();
  }
}


//  CommonContainer(
//         color: isLight ? Colors.white : darkBgColor,
//         innerPadding: isLight
//             ? const EdgeInsets.symmetric(vertical: 15)
//             : const EdgeInsets.all(0),
//         outerPadding: isLight
//             ? const EdgeInsets.symmetric(horizontal: 7)
//             : const EdgeInsets.only(bottom: 15),
//         height: widget.shouldFillViewport
//             ? MediaQuery.of(context).size.height / 1.4
//             : null,
//         child: tableCalendar(),
//       )