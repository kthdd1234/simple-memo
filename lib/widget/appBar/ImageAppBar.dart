import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              CommonText(text: '사진'),
              const Spacer(),
              Row(
                children: [
                  CommonSvg(
                    name: 'slide-show',
                    onTap: onSlide,
                    padding: const EdgeInsets.only(left: 10),
                  ),
                  CommonSvg(
                    name: isRecent ? 'up-down' : 'down-up',
                    onTap: onRecent,
                    padding: const EdgeInsets.only(left: 10),
                  ),
                ],
              )
            ],
          ),
        ),
        CommonDivider(),
      ],
    );
  }
}
