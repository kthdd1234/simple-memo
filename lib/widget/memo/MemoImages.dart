import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonImage.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/ImageSelectionModalSheet.dart';

class MemoImages extends StatefulWidget {
  MemoImages({
    super.key,
    required this.uint8ListList,
    required this.onImage,
  });

  List<Uint8List> uint8ListList;
  Function(Uint8List) onImage;

  @override
  State<MemoImages> createState() => _MemoImagesState();
}

class _MemoImagesState extends State<MemoImages> {
  image(Uint8List uint8List, double height) {
    return Expanded(
      child: CommonImage(
        uint8List: uint8List,
        height: height,
        onTap: widget.onImage,
      ),
    );
  }

  imageList() {
    List<Uint8List> uint8ListList = widget.uint8ListList;

    switch (uint8ListList.length) {
      case 1:
        return CommonImage(
          uint8List: uint8ListList[0],
          height: 250,
          onTap: widget.onImage,
        );

      case 2:
        return Row(children: [
          image(uint8ListList[0], 150),
          CommonSpace(width: 5),
          image(uint8ListList[1], 150)
        ]);
      case 3:
        return Row(
          children: [
            image(uint8ListList[0], 100),
            CommonSpace(width: 5),
            image(uint8ListList[1], 100),
            CommonSpace(width: 5),
            image(uint8ListList[2], 100)
          ],
        );
      case 4:
        return Column(
          children: [
            Row(
              children: [
                image(uint8ListList[0], 100),
                CommonSpace(width: 5),
                image(uint8ListList[1], 100),
                CommonSpace(width: 5),
                image(uint8ListList[2], 100)
              ],
            ),
            CommonSpace(height: 5),
            CommonImage(
              uint8List: uint8ListList[3],
              height: 100,
              onTap: widget.onImage,
            )
          ],
        );

      case 5:
        return Column(
          children: [
            Row(
              children: [
                image(uint8ListList[0], 100),
                CommonSpace(width: 5),
                image(uint8ListList[1], 100),
                CommonSpace(width: 5),
                image(uint8ListList[2], 100)
              ],
            ),
            CommonSpace(height: 5),
            Row(children: [
              image(uint8ListList[0], 100),
              CommonSpace(width: 5),
              image(uint8ListList[1], 100)
            ])
          ],
        );

      case 6:
        return Column(
          children: [
            Row(
              children: [
                image(uint8ListList[0], 100),
                CommonSpace(width: 5),
                image(uint8ListList[1], 100),
                CommonSpace(width: 5),
                image(uint8ListList[2], 100)
              ],
            ),
            CommonSpace(height: 5),
            Row(children: [
              image(uint8ListList[3], 100),
              CommonSpace(width: 5),
              image(uint8ListList[4], 100),
              CommonSpace(width: 5),
              image(uint8ListList[5], 100)
            ])
          ],
        );
      default:
        return const CommonNull();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.uint8ListList.isNotEmpty ? imageList() : const CommonNull();
  }
}
// ListView.separated(
//                 shrinkWrap: true,
//                 itemCount: widget.uint8ListList.length,
//                 scrollDirection: Axis.horizontal,
//                 separatorBuilder: (context, index) => CommonSpace(width: 5),
//                 itemBuilder: (context, index) => CommonImage(
//                   uint8List: widget.uint8ListList[index],
//                   width: 100,
//                   height: 100,
//                   onTap: widget.onImage,
//                 ),
//               )