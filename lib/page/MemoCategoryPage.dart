import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/util/class.dart';

class MemoCategoryPage extends StatelessWidget {
  const MemoCategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        appBarInfo: AppBarInfoClass(title: '카테고리', isCenter: false),
        body: Column(
          children: [
            CommonContainer(
              child: Column(
                children: [],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
