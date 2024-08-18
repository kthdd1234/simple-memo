import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonTag.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';

class MemoCategoryList extends StatefulWidget {
  MemoCategoryList({super.key, required this.categoryList});

  List<MemoCategoryClass> categoryList;

  @override
  State<MemoCategoryList> createState() => _MemoCategoryListState();
}

class _MemoCategoryListState extends State<MemoCategoryList> {
  onTag(String selectedId) {
    context.read<SelectedMemoCategoryIdProvider>().setId(selectedId);
  }

  @override
  Widget build(BuildContext context) {
    String selectedMemoCategoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          itemCount: widget.categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 7),
            child: CommonTag(
              text: widget.categoryList[index].name,
              textColor: selectedMemoCategoryId == widget.categoryList[index].id
                  ? Colors.white
                  : Colors.black,
              bgColor: selectedMemoCategoryId == widget.categoryList[index].id
                  ? textColor
                  : Colors.white,
              isBold: selectedMemoCategoryId == widget.categoryList[index].id,
              isNotTr: true,
              fontSize: 13,
              onTap: () => onTag(widget.categoryList[index].id),
            ),
          ),
        ),
      ),
    );
  }
}
