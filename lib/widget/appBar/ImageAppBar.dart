import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonAppBar.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/util/func.dart';

class ImageAppBar extends StatelessWidget {
  const ImageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(title: '사진', actions: [
      svgWidget(name: 'slide-show', onTap: () {}),
      CommonSpace(width: 15),
      svgWidget(name: 'image-remove', onTap: () {}),
    ]);
  }
}
