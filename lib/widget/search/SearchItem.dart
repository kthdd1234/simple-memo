import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/widget/search/SearchImages.dart';
import 'package:simple_memo_app/widget/search/SearchMemo.dart';
import 'package:simple_memo_app/widget/search/SearchTitle.dart';

class SearchItem extends StatelessWidget {
  SearchItem({
    super.key,
    required this.dateTime,
    required this.textAlign,
    this.uint8ListList,
    this.memo,
  });

  DateTime dateTime;
  List<Uint8List>? uint8ListList;
  String? memo;
  TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: crossAxisAlignmentInfo[textAlign]!,
        children: [
          SearchTitle(dateTime: dateTime),
          SearchImages(uint8ListList: uint8ListList ?? []),
          SearchMemo(text: memo, textAlign: textAlign)
        ],
      ),
    );
  }
}
