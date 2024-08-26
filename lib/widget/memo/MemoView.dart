import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/MemoPasteBottomSheet.dart';
import 'package:simple_memo_app/widget/bottomSheet/MemoSettingBottomSheet.dart';
import 'package:simple_memo_app/widget/memo/MemoImages.dart';

class MemoView extends StatefulWidget {
  MemoView({
    super.key,
    required this.memoInfo,
    required this.selectedDateTime,
    required this.categoryId,
    required this.onMemo,
    this.copyMemoInfo,
  });

  DateTime selectedDateTime;
  String categoryId;
  MemoInfoClass memoInfo;
  Map<String, dynamic>? copyMemoInfo;
  Function(MemoInfoClass? memoInfo) onMemo;

  @override
  State<MemoView> createState() => _MemoViewState();
}

class _MemoViewState extends State<MemoView> {
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
    MemoInfoClass memoInfo = widget.memoInfo;
    String? memo = memoInfo.memo;
    List<Uint8List> imageList = memoInfo.imageList ?? [];
    TextAlign? textAlign = memoInfo.textAlign;

    return InkWell(
      onTap: () => widget.onMemo(memoInfo),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Container(
          alignment: alignmentInfo[textAlign],
          child: Column(
            crossAxisAlignment: crossAxisAlignmentInfo[textAlign]!,
            children: [
              imageList.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: MemoImages(
                        uint8ListList: imageList,
                        onImage: (Uint8List uint8List) =>
                            onSlide(uint8List, imageList),
                      ),
                    )
                  : const CommonNull(),
              CommonText(
                text: memo ?? '',
                isNotTr: true,
                textAlign: textAlign,
                fontSize: defaultFontSize + 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
