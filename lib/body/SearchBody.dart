import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/SearchAppBar.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';
import 'package:simple_memo_app/widget/search/SearchView.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  TextEditingController keywordController = TextEditingController();
  bool isSearch = false;
  bool isRecent = true;
  String categoryId = 'all';

  onSearch() {
    setState(() => isSearch = !isSearch);
  }

  onCancel() {
    setState(() {
      isSearch = !isSearch;
      keywordController.text = '';
    });
  }

  onEditingComplete() {
    FocusScope.of(context).unfocus();

    if (keywordController.text == '') {
      onSearch();
    }
  }

  onUpDown() {
    setState(() => isRecent = !isRecent);
  }

  onTag(String selectedId) {
    setState(() => categoryId = selectedId);
  }

  @override
  Widget build(BuildContext context) {
    List<CategoryBox> categoryList = getCategoryList();

    categoryList.insert(
      0,
      CategoryBox(
        id: 'all',
        name: '전체'.tr(),
        createDateTime: DateTime.now(),
      ),
    );

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchAppBar(
              controller: keywordController,
              isRecent: isRecent,
              isSearch: isSearch,
              onEditingComplete: onEditingComplete,
              onUpDown: onUpDown,
              onSearch: onSearch,
              onCancel: onCancel,
            ),
            SearchView(
              isRecent: isRecent,
              keyword: keywordController.text,
              categoryId: categoryId,
            ),
            MemoCategoryList(
              categoryId: categoryId,
              categoryList: categoryList,
              onTag: onTag,
            ),
          ],
        );
      },
    );
  }
}
