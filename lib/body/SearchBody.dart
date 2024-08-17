import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/class.dart';
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
  bool isRecent = true;

  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     context.read<SelectedMemoCategoryIdProvider>().setId('searchAll');
  //   });

  //   super.initState();
  // }

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
    List<MemoCategoryClass> searchCategoryList = [
      MemoCategoryClass(id: 'searchAll', name: '전체'.tr()),
      ...categoryList
    ];

    return MultiValueListenableBuilder(
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
            SearchView(),
            CommonDivider(horizontal: 10, color: grey.s400),
            MemoCategoryList(categoryList: searchCategoryList)
          ],
        );
      },
    );
  }
}
