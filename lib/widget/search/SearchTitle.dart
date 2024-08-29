import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/SearchItemBottomSheet.dart';

class SearchTitle extends StatefulWidget {
  SearchTitle({super.key, required this.memoInfo});

  MemoInfoClass memoInfo;

  @override
  State<SearchTitle> createState() => _SearchTitleState();
}

class _SearchTitleState extends State<SearchTitle> {
  onMore() {
    String locale = context.locale.toString();

    showModalBottomSheet(
      context: context,
      builder: (context) => SearchItemBottomSheet(
        memoInfo: widget.memoInfo,
        title: ymdeFullFormatter(
          locale: locale,
          dateTime: widget.memoInfo.dateTime!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    bool isLight = context.watch<ThemeProvider>().isLight;
    String locale = context.locale.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: ymdFullFormatter(
                locale: locale,
                dateTime: widget.memoInfo.dateTime!,
              ),
              fontSize: fontSize - 1,
              isNotTr: true,
            ),
            CommonText(
              text: eeeeFormatter(
                  locale: locale, dateTime: widget.memoInfo.dateTime!),
              fontSize: fontSize - 3,
              color: isLight ? grey.original : grey.s400,
              isNotTr: true,
            ),
          ],
        ),
        InkWell(
          onTap: onMore,
          child: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(
              Icons.more_vert_rounded,
              size: 20,
              color: isLight ? grey.original : grey.s400,
            ),
          ),
        )
      ],
    );
  }
}
