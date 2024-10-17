import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonSvg.dart';
import 'package:simple_memo_app/common/CommonSvgText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/enum.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:easy_localization/easy_localization.dart';

class MemoAppBar extends StatefulWidget {
  MemoAppBar({
    super.key,
    required this.isCalendar,
    required this.onCalendar,
    required this.onCategory,
  });

  bool isCalendar;
  Function() onCalendar, onCategory;

  @override
  State<MemoAppBar> createState() => _MemoAppBarState();
}

class _MemoAppBarState extends State<MemoAppBar> {
  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;
    String locale = context.locale.toString();
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              CommonSvgText(
                text: ymdeShortFormatter(
                    locale: locale, dateTime: selectedDateTime),
                fontSize: fontSize + 1,
                isNotTr: true,
                svgName: 'dir-down-bold',
                svgWidth: 10,
                svgLeft: 7,
                svgDirection: SvgDirection.right,
                onTap: widget.onCalendar,
              ),
              const Spacer(),
              CommonSvg(
                name: 'category',
                onTap: widget.onCategory,
                padding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ],
          ),
        ),
        CommonDivider(),
      ],
    );
  }
}
