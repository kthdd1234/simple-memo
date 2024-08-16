import 'dart:typed_data';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/SearchItemBottomSheet.dart';

class SearchTitle extends StatefulWidget {
  SearchTitle({super.key, required this.dateTime});

  DateTime dateTime;

  @override
  State<SearchTitle> createState() => _SearchTitleState();
}

class _SearchTitleState extends State<SearchTitle> {
  onMore() {
    String locale = context.locale.toString();

    showModalBottomSheet(
      context: context,
      builder: (context) => SearchItemBottomSheet(
        title: ymdeFullFormatter(
          locale: locale,
          dateTime: widget.dateTime,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonText(
              text: ymdFullFormatter(locale: locale, dateTime: widget.dateTime),
              fontSize: 13,
              isNotTr: true,
            ),
            CommonSpace(height: 2),
            CommonText(
              text: eeeeFormatter(locale: locale, dateTime: widget.dateTime),
              fontSize: 12,
              color: grey.original,
              isNotTr: true,
            ),
          ],
        ),
        InkWell(
          onTap: onMore,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: Icon(
              Icons.more_vert_rounded,
              size: 17,
              color: grey.original,
            ),
          ),
        )
      ],
    );
  }
}
