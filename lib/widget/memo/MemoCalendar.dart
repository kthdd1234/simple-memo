import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonCalendar.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonImage.dart';
import 'package:simple_memo_app/common/CommonMask.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:table_calendar/table_calendar.dart';

class MemoCalendar extends StatefulWidget {
  MemoCalendar({
    super.key,
    required this.selectedDateTime,
    required this.categoryId,
    required this.isCalendar,
    required this.onCalendar,
    required this.onFormatChanged,
  });

  DateTime selectedDateTime;
  String categoryId;
  bool isCalendar;
  Function() onCalendar;
  Function(CalendarFormat) onFormatChanged;

  @override
  State<MemoCalendar> createState() => _MemoCalendarState();
}

class _MemoCalendarState extends State<MemoCalendar> {
  onDaySelected(DateTime dateTime) {
    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  Widget? pictureBuildler(bool isLight, DateTime dateTime) {
    int recordKey = dateTimeKey(dateTime);
    MemoInfoClass? memoInfoClass = getMemoInfo(dateTime, widget.categoryId);
    String? memo = memoInfoClass?.memo;
    Uint8List? unit8List = memoInfoClass?.imageList?[0];
    bool isToday = dateTimeKey(widget.selectedDateTime) == recordKey;

    // if (unit8List != null) {
    //   return Stack(
    //     alignment: AlignmentDirectional.bottomCenter,
    //     children: [
    //       Center(
    //         child: CommonImage(
    //           uint8List: unit8List,
    //           width: 30,
    //           height: 30,
    //           onTap: (_) {},
    //         ),
    //       ),
    //       Center(child: CommonMask(width: 30, height: 30, opacity: 0.2)),
    //       Center(
    //         child: Container(
    //           padding: const EdgeInsets.all(3),
    //           decoration: BoxDecoration(
    //             color: isToday ? textColor : null,
    //             borderRadius: BorderRadius.circular(100),
    //           ),
    //           child: memo != null
    //               ? svgAsset(name: 'check', width: 20, color: Colors.white)
    //               : CommonText(
    //                   text: '${dateTime.day}',
    //                   isNotTr: true,
    //                   color: Colors.white,
    //                   isBold: true,
    //                 ),
    //         ),
    //       ),
    //     ],
    //   );
    // } else

    if (memo != null) {
      return svgAsset(name: 'check', width: 18, color: textColor);
    }

    return const CommonNull();
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return widget.isCalendar
        ? Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                CommonCalendar(
                  selectedDateTime: selectedDateTime,
                  calendarFormat: CalendarFormat.month,
                  shouldFillViewport: false,
                  markerBuilder: pictureBuildler,
                  onDaySelected: onDaySelected,
                  onFormatChanged: widget.onFormatChanged,
                  onPageChanged: (_) {},
                ),
                CommonDivider(horizontal: 10, color: grey.s400),
              ],
            ),
          )
        : const CommonNull();
  }
}
