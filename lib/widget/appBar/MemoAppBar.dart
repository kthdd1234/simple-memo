import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonAppBar.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonSvg.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:easy_localization/easy_localization.dart';

class MemoAppBar extends StatefulWidget {
  MemoAppBar({
    super.key,
    required this.isCalendar,
    required this.onCalendar,
    required this.onImages,
    required this.onCategory,
    required this.onSearch,
    required this.onMore,
  });

  bool isCalendar;
  Function() onCalendar, onImages, onCategory, onSearch, onMore;

  @override
  State<MemoAppBar> createState() => _MemoAppBarState();
}

class _MemoAppBarState extends State<MemoAppBar> {
  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    EdgeInsets padding = const EdgeInsets.fromLTRB(7, 7, 10, 10);

    return Column(
      children: [
        CommonAppBar(
          title: ymdeShortFormatter(locale: locale, dateTime: selectedDateTime),
          isNotTr: true,
          svgName: 'dir-down-bold',
          svgLeft: 7,
          onTap: widget.onCalendar,
          actions: [
            CommonSvg(
              name: 'search',
              onTap: widget.onSearch,
              padding: padding,
            ),
            CommonSvg(
              name: 'images',
              onTap: widget.onImages,
              padding: padding,
            ),
            CommonSvg(
              name: 'category',
              onTap: widget.onCategory,
              padding: padding,
            ),
            CommonSvg(
              name: 'setting',
              onTap: widget.onMore,
              padding: padding,
            ),
          ],
        ),
        CommonDivider(horizontal: 10),
      ],
    );
  }
}
