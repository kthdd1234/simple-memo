import 'package:flutter/cupertino.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/SearchAppBar.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';
import 'package:simple_memo_app/widget/search/SearchView.dart';

import '../common/CommonDivider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController keywordController = TextEditingController();
  bool isRecent = true;

  onEditingComplete() {
    FocusScope.of(context).unfocus();
  }

  onUpDown() {
    setState(() => isRecent = !isRecent);
  }

  @override
  Widget build(BuildContext context) {
    List<MemoCategoryClass> categoryList =
        getMemoCategoryList(categoryRepository.categoryList);

    return CommonBackground(
      child: CommonScaffold(
        body: MultiValueListenableBuilder(
          valueListenables: valueListenables,
          builder: (context, values, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SearchAppBar(
                  controller: keywordController,
                  isRecent: isRecent,
                  onEditingComplete: onEditingComplete,
                  onUpDown: onUpDown,
                ),
                SearchView(isRecent: isRecent, keyword: keywordController.text),
                CommonDivider(horizontal: 10, color: grey.s400),
                MemoCategoryList(categoryList: categoryList)
              ],
            );
          },
        ),
      ),
    );
  }
}
