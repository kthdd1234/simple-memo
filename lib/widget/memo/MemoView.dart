import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/page/MemoPage.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/memo/MemoImages.dart';

class MemoView extends StatefulWidget {
  const MemoView({super.key});

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> {
  onMemo(MemoInfoClass? memoInfo) {
    navigator(context: context, page: MemoPage(initMemoInfo: memoInfo));
  }

  onSlide(Uint8List uint8List, List<Uint8List> imageList) {
    navigator(
      context: context,
      page: ImageSlidePage(
        curIndex: imageList.indexOf(uint8List),
        uint8ListList: imageList,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    String categoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;
    MemoInfoClass? memoInfo = getMemoInfo(selectedDateTime, categoryId);
    String? memo = memoInfo?.memo;
    List<Uint8List> imageList = memoInfo?.imageList ?? [];
    TextAlign? textAlign = memoInfo?.textAlign ?? TextAlign.left;

    return Expanded(
      child: InkWell(
        onTap: () => onMemo(memoInfo),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: memoInfo != null
              ? Container(
                  alignment: alignmentInfo[textAlign],
                  child: Column(
                    crossAxisAlignment: crossAxisAlignmentInfo[textAlign]!,
                    children: [
                      imageList.isNotEmpty
                          ? MemoImages(
                              uint8ListList: imageList,
                              onImage: (Uint8List uint8List) =>
                                  onSlide(uint8List, imageList),
                            )
                          : const CommonNull(),
                      CommonText(
                        text: memo!,
                        isNotTr: true,
                        textAlign: textAlign,
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: CommonText(
                      text: '+ 메모 추가하기',
                      color: grey.original,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
