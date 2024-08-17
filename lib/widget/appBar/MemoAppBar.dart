import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonAppBar.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:easy_localization/easy_localization.dart';

class MemoAppBar extends StatefulWidget {
  MemoAppBar({
    super.key,
    required this.isShowCalendar,
    required this.onShowCalendar,
    required this.onCheckImportant,
    required this.onMemoCategory,
  });

  bool isShowCalendar;
  Function() onShowCalendar, onCheckImportant, onMemoCategory;

  @override
  State<MemoAppBar> createState() => _MemoAppBarState();
}

class _MemoAppBarState extends State<MemoAppBar> {
  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return CommonAppBar(
      title: ymdeShortFormatter(locale: locale, dateTime: selectedDateTime),
      isNotTr: true,
      actions: [
        svgWidget(name: 'calendar', onTap: widget.onShowCalendar),
        CommonSpace(width: 15),
        svgWidget(name: 'category', onTap: widget.onMemoCategory),
      ],
    );
  }
}
