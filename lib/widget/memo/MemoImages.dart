import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonImage.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/ImageSelectionModalSheet.dart';

class MemoImages extends StatefulWidget {
  MemoImages({super.key, required this.uint8ListList});

  List<Uint8List> uint8ListList;

  @override
  State<MemoImages> createState() => _MemoImagesState();
}

class _MemoImagesState extends State<MemoImages> {
  onImage(Uint8List uint8List) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ImageSelectionModalSheet(
        uint8List: uint8List,
        onSlide: () {
          pop(context);
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => ImageSlidePage(
                curIndex: widget.uint8ListList.indexOf(uint8List),
                uint8ListList: widget.uint8ListList,
              ),
            ),
          );
        },
        onRemove: () async {
          widget.uint8ListList.removeWhere(
            (uint8List_) => uint8List_ == uint8List,
          );

          if (widget.uint8ListList.isEmpty) {
            // widget.recordBox?.imageList = null;
          }

          // await widget.recordBox?.save();
          pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.uint8ListList.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              height: 100,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: widget.uint8ListList.length,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) => CommonSpace(width: 5),
                itemBuilder: (context, index) => CommonImage(
                  uint8List: widget.uint8ListList[index],
                  width: 100,
                  height: 100,
                  onTap: onImage,
                ),
              ),
            ),
          )
        : const CommonNull();
  }
}
