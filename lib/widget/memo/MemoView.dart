import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/page/MemoPage.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';

class MemoView extends StatefulWidget {
  const MemoView({super.key});

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> {
  onMemo() {
    navigator(context: context, page: MemoPage());
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    String categoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;
    String? memo = getMemoInfo(selectedDateTime, categoryId)?.memo;
    log(memo ?? '');
    // todo

    return Expanded(
      child: InkWell(
        onTap: onMemo,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: CommonText(text: '+ 메모 추가하기', color: grey.original),
            ),
          ),
        ),
      ),
    );
  }
}
