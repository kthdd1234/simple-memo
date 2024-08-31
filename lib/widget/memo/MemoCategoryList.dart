import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:simple_memo_app/common/CommonTag.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';

class MemoCategoryList extends StatefulWidget {
  MemoCategoryList({
    super.key,
    required this.categoryId,
    required this.categoryList,
    this.controller,
    required this.onTag,
  });

  String categoryId;
  ItemScrollController? controller;
  List<CategoryBox> categoryList;
  Function(String) onTag;

  @override
  State<MemoCategoryList> createState() => _MemoCategoryListState();
}

class _MemoCategoryListState extends State<MemoCategoryList> {
  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    double fontSize = user.fontSize ?? defaultFontSize;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
      child: SizedBox(
        height: 35,
        child: ScrollablePositionedList.builder(
          itemScrollController: widget.controller,
          physics: const ClampingScrollPhysics(),
          itemCount: widget.categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Center(
              child: CommonTag(
                text: widget.categoryList[index].name,
                isSelection: widget.categoryId == widget.categoryList[index].id,
                isNotTr: true,
                fontSize: fontSize - 1,
                onTap: () => widget.onTag(widget.categoryList[index].id),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
