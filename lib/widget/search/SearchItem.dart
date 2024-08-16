import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/widget/search/SearchImages.dart';
import 'package:simple_memo_app/widget/search/SearchMemo.dart';
import 'package:simple_memo_app/widget/search/SearchTitle.dart';

class SearchItem extends StatelessWidget {
  const SearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      outerPadding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchTitle(dateTime: DateTime.now()),
          SearchImages(uint8ListList: []),
          SearchMemo()
        ],
      ),
    );
  }
}
