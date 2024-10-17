import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/widget/search/SearchImages.dart';
import 'package:simple_memo_app/widget/search/SearchMemo.dart';
import 'package:simple_memo_app/widget/search/SearchTitle.dart';

class SearchItem extends StatelessWidget {
  SearchItem({super.key, required this.memoInfo});

  MemoInfoClass memoInfo;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: crossAxisAlignmentInfo[memoInfo.textAlign]!,
        children: [
          SearchTitle(memoInfo: memoInfo),
          SearchImages(uint8ListList: memoInfo.imageList ?? []),
          SearchMemo(text: memoInfo.memo, textAlign: memoInfo.textAlign)
        ],
      ),
    );
  }
}
