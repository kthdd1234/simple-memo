import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonSvg.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/ImageAppBar.dart';
import 'package:simple_memo_app/widget/image/ImageView.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';
import 'package:simple_memo_app/widget/popup/AlertPopup.dart';

class ImagePage extends StatefulWidget {
  const ImagePage({super.key});

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool isRecent = true;

  onImage(List<Uint8List> uint8ListList, int index) {
    navigator(
      context: context,
      page: ImageSlidePage(uint8ListList: uint8ListList, curIndex: index),
    );
  }

  onRecent() {
    setState(() => isRecent = !isRecent);
  }

  onSlide(List<Uint8List> uint8ListList) {
    if (uint8ListList.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '추가한 사진이 없어요',
          buttonText: '확인',
          height: 170,
          onTap: () => pop(context),
        ),
      );
    } else {
      navigator(
        context: context,
        page: ImageSlidePage(uint8ListList: uint8ListList, curIndex: 0),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedMemoCategoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;
    List<ImageClass> imageClassList = [];

    for (var i = 0; i < recordRepository.recordList.length; i++) {
      RecordBox? record = recordRepository.recordList[i];

      if (record.memoInfoList != null) {
        for (var j = 0; j < record.memoInfoList!.length; j++) {
          MemoInfoClass memoInfo = memoInfoToClass(record.memoInfoList![j]);

          if (memoInfo.categoryId == selectedMemoCategoryId) {
            List<Uint8List> imageList = memoInfo.imageList ?? [];

            if (imageList.isNotEmpty) {
              List<ImageClass> map = imageList
                  .map((Uint8List uint8List) => ImageClass(
                      dateTime: record.createDateTime, uint8List: uint8List))
                  .toList();
              imageClassList = [...imageClassList, ...map];
            }
          }
        }
      }
    }

    imageClassList =
        isRecent ? imageClassList.reversed.toList() : imageClassList;

    return CommonBackground(
      child: CommonScaffold(
        body: MultiValueListenableBuilder(
          valueListenables: valueListenables,
          builder: (context, values, child) {
            return Column(
              children: [
                ImageAppBar(
                  isRecent: isRecent,
                  onSlide: () => onSlide(
                    imageClassList.map((image) => image.uint8List).toList(),
                  ),
                  onRecent: onRecent,
                ),
                MemoCategoryList(),
                CommonSpace(height: 10),
                ImageView(imageClassList: imageClassList, onImage: onImage),
              ],
            );
          },
        ),
      ),
    );
  }
}
