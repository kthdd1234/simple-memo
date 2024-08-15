import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
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
  svg({required String name, required Function() onTap}) {
    return InkWell(onTap: onTap, child: svgAsset(name: name, width: 20));
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonText(
            text: ymdeShortFormatter(
              locale: locale,
              dateTime: selectedDateTime,
            ),
            fontSize: 17,
            isNotTr: true,
          ),
          Row(
            children: [
              svg(name: 'star', onTap: widget.onCheckImportant),
              CommonSpace(width: 15),
              svg(name: 'calendar', onTap: widget.onShowCalendar),
              CommonSpace(width: 15),
              svg(name: 'category', onTap: widget.onMemoCategory),
            ],
          ),
        ],
      ),
    );
  }
}
