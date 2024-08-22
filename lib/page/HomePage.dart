import 'package:flutter/material.dart';
import 'package:simple_memo_app/body/MemoBody.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/util/func.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      List<CategoryBox> categoryList = getCategoryList();
      context.read<SelectedMemoCategoryIdProvider>().setId(categoryList[0].id);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(child: CommonScaffold(body: const MemoBody()));
  }
}
