import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/widget/memo/MemoImages.dart';

class SearchImages extends StatelessWidget {
  SearchImages({super.key, required this.uint8ListList});

  List<Uint8List> uint8ListList;

  @override
  Widget build(BuildContext context) {
    return uint8ListList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: MemoImages(uint8ListList: uint8ListList),
          )
        : const CommonNull();
  }
}
