import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/page/MemoCategoryPage.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/MemoAppBar.dart';
import 'package:simple_memo_app/widget/memo/MemoCalendar.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';
import 'package:simple_memo_app/widget/memo/MemoView.dart';

class MemoBody extends StatefulWidget {
  const MemoBody({super.key});

  @override
  State<MemoBody> createState() => _MemoBodyState();
}

class _MemoBodyState extends State<MemoBody> {
  bool isShowCalendar = false;

  onShowCalendar() {
    setState(() => isShowCalendar = !isShowCalendar);
  }

  onCheckImportant() {
    //
  }

  onMemoCategory() {
    navigator(context: context, page: const MemoCategoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (context, values, child) {
          return Column(
            children: [
              MemoAppBar(
                isShowCalendar: isShowCalendar,
                onShowCalendar: onShowCalendar,
                onCheckImportant: onCheckImportant,
                onMemoCategory: onMemoCategory,
              ),
              MemoCalendar(
                isShowCalendar: isShowCalendar,
                onShowCalendar: onShowCalendar,
              ),
              CommonDivider(horizontal: 10, color: grey.s400),
              const MemoView(),
              CommonDivider(horizontal: 10, color: grey.s400),
              const MemoCategoryList()
            ],
          );
        });
  }
}
