import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:simple_memo_app/common/CommonImage.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
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
    return CommonModalSheet(
      title: '사진',
      height: 540,
      child: Column(
        children: [
          CommonImage(
              uint8List: uint8List, height: 335, onTap: (_) => onSlide()),
          CommonSpace(height: 10),
          Row(
            children: [
              ModalButton(
                svgName: 'image',
                actionText: '사진 보기',
                onTap: onSlide,
              ),
              CommonSpace(width: 10),
              ModalButton(
                svgName: 'trash',
                color: red.s400,
                actionText: '삭제하기',
                onTap: onRemove,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
