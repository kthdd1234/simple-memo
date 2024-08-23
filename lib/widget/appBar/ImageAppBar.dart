import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonSvg.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/widget/appBar/SearchAppBar.dart';

class ImageAppBar extends StatelessWidget {
  ImageAppBar({
    super.key,
    required this.isRecent,
    required this.onSlide,
    required this.onRecent,
  });

  bool isRecent;
  Function() onSlide, onRecent;

  @override
  Widget build(BuildContext context) {
    EdgeInsets padding = const EdgeInsets.fromLTRB(5, 10, 10, 10);

    return Row(
      children: [
        const BackBtn(),
        CommonSpace(width: 10),
        CommonText(text: '사진 모아보기'),
        const Spacer(),
        Row(
          children: [
            CommonSvg(
              name: 'slide-show',
              onTap: onSlide,
              padding: padding,
            ),
            CommonSvg(
              name: isRecent ? 'up-down' : 'down-up',
              onTap: onRecent,
              padding: padding,
            ),
          ],
        )
      ],
    );
  }
}
