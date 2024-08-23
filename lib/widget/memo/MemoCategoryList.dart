import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonTag.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/util/func.dart';

class MemoCategoryList extends StatelessWidget {
  MemoCategoryList({super.key, required this.categoryId, required this.onTag});

  String categoryId;
  Function(String) onTag;

  @override
  Widget build(BuildContext context) {
    List<CategoryBox> categoryList = getCategoryList();

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10),
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
                isSelection: categoryId == categoryList[index].id,
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
