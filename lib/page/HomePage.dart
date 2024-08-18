import 'package:flutter/material.dart';
import 'package:simple_memo_app/body/MemoBody.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      String categoryId = categoryRepository.categoryList[0].id;
      context.read<SelectedMemoCategoryIdProvider>().setId(categoryId);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(child: CommonScaffold(body: const MemoBody()));
  }
}
