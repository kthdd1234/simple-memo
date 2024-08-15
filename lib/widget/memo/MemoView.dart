import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/page/MemoPage.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';

class MemoView extends StatefulWidget {
  const MemoView({super.key});

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> {
  onMemo() {
    navigator(context: context, page: MemoPage(initTextAlign: TextAlign.left));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onMemo,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonText(
                    text: '메모를 입력해주세요.',
                    textAlign: TextAlign.start,
                    color: grey.original,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
