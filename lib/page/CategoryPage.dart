import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonSvgText.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/enum.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/widget/bottomSheet/MemoCategoryBottomSheet.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  onPressed() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => MemoCategoryBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        padding: const EdgeInsets.only(left: 20, right: 15),
        appBarInfo: AppBarInfoClass(title: '카테고리 편집'),
        body: Column(
          children: categoryList
              .map((category) => MemoCategoryItem(
                    name: category.name,
                    count: 7,
                  ))
              .toList(),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            onPressed: onPressed,
            child: const Icon(Icons.add_rounded, size: 25),
          ),
        ),
      ),
    );
  }
}

class MemoCategoryItem extends StatelessWidget {
  MemoCategoryItem({super.key, required this.name, required this.count});

  String name;
  int count;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          InkWell(
            child: Icon(Icons.remove_circle, size: 20, color: red.s400),
          ),
          CommonSpace(width: 10),
          Expanded(
            child: CommonContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CommonText(text: name, isNotTr: true),
                  CommonSvgText(
                    text: '$count',
                    fontSize: 16,
                    textColor: isLight ? grey.original : Colors.white,
                    svgColor: isLight ? grey.original : Colors.white,
                    svgWidth: 6,
                    svgLeft: 6,
                    isNotTr: true,
                    svgDirection: SvgDirection.right,
                  )
                ],
              ),
            ),
          ),
          CommonSpace(width: 10),
          InkWell(
            child: Icon(
              Icons.reorder_rounded,
              size: 20,
              color: grey.original,
            ),
          ),
        ],
      ),
    );
  }
}
