import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonText.dart';

class MoreAppBar extends StatelessWidget {
  const MoreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: CommonText(text: '설정'),
        ),
        CommonDivider(),
      ],
    );
  }
}
