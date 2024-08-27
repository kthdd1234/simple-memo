import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/memo/MemoImages.dart';

class SearchImages extends StatelessWidget {
  SearchImages({super.key, required this.uint8ListList});

  List<Uint8List> uint8ListList;

  @override
  Widget build(BuildContext context) {
    onSlide(Uint8List uint8List) {
      navigator(
        context: context,
        page: ImageSlidePage(
          curIndex: uint8ListList.indexOf(uint8List),
          uint8ListList: uint8ListList,
        ),
      );
    }

    return uint8ListList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(top: 5),
            child: MemoImages(uint8ListList: uint8ListList, onImage: onSlide),
          )
        : const CommonNull();
  }
}
