import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonImage.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';

class ImageSelectionModalSheet extends StatelessWidget {
  ImageSelectionModalSheet({
    super.key,
    required this.uint8List,
    required this.onSlide,
    required this.onRemove,
  });

  Uint8List uint8List;
  Function() onSlide, onRemove;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonModalSheet(
      title: '사진',
      height: 530,
      child: Column(
        children: [
          CommonImage(
            uint8List: uint8List,
            height: 335,
            onTap: (_) => onSlide(),
          ),
          CommonSpace(height: 10),
          Row(
            children: [
              ModalButton(
                svgName: 'image',
                actionText: '사진 보기',
                isBold: !isLight,
                color: isLight ? textColor : darkTextColor,
                onTap: onSlide,
              ),
              CommonSpace(width: 10),
              ModalButton(
                svgName: 'trash',
                actionText: '삭제하기',
                isBold: !isLight,
                color: red.original,
                onTap: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
