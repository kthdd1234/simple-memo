import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/ImageAppBar.dart';
import 'package:simple_memo_app/widget/image/ImageView.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';
import 'package:simple_memo_app/widget/popup/AlertPopup.dart';

class ImageBody extends StatefulWidget {
  const ImageBody({super.key});

  @override
  State<ImageBody> createState() => _ImageBodyState();
}

class _ImageBodyState extends State<ImageBody> {
  bool isRecent = true;
  String categoryId = 'all';

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

  onTag(String selectedId) {
    setState(() => categoryId = selectedId);
  }

  @override
  Widget build(BuildContext context) {
    List<ImageClass> imageClassList = [];
    List<CategoryBox> categoryList = getCategoryList();

    categoryList.insert(
      0,
      CategoryBox(
        id: 'all',
        name: '전체'.tr(),
        createDateTime: DateTime.now(),
      ),
    );

    for (var i = 0; i < recordRepository.recordList.length; i++) {
      RecordBox? record = recordRepository.recordList[i];

      if (record.memoInfoList != null) {
        for (var j = 0; j < record.memoInfoList!.length; j++) {
          MemoInfoClass memoInfo = memoInfoToClass(record.memoInfoList![j]);
          List<Uint8List> imageList = memoInfo.imageList ?? [];
          List<ImageClass> imageClassList2 = imageList
              .map(
                (Uint8List uint8List) => ImageClass(
                  dateTime: record.createDateTime,
                  uint8List: uint8List,
                ),
              )
              .toList();

          if (categoryId == 'all') {
            imageClassList = [...imageClassList, ...imageClassList2];
          } else if (memoInfo.categoryId == categoryId) {
            imageClassList = [...imageClassList, ...imageClassList2];
          }
        }
      }
    }

    imageClassList =
        isRecent ? imageClassList.reversed.toList() : imageClassList;

    return MultiValueListenableBuilder(
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
            ImageView(imageClassList: imageClassList, onImage: onImage),
            CommonSpace(height: 10),
            MemoCategoryList(
              categoryId: categoryId,
              categoryList: categoryList,
              onTag: onTag,
            ),
          ],
        );
      },
    );
  }
}
