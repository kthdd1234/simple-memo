import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonTag.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';

class MemoCategoryList extends StatefulWidget {
  MemoCategoryList({super.key});

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

    List<CategoryBox> categoryList = getCategoryList();

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
      child: SizedBox(
        height: 35,
        child: ListView.builder(
          itemCount: categoryList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 7),
            child: Center(
              child: CommonTag(
                text: categoryList[index].name,
                isSelection: selectedMemoCategoryId == categoryList[index].id,
                isNotTr: true,
                fontSize: 16,
                onTap: () => onTag(categoryList[index].id),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
