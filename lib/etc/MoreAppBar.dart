import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonAppBar.dart';

class MoreAppBar extends StatelessWidget {
  const MoreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(title: '더보기', actions: []);
  }
}
