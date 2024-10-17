import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
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
    UserBox user = userRepository.user;
    MemoInfoClass memoInfo = widget.memoInfo;
    String? memo = memoInfo.memo;
    List<Uint8List> imageList = memoInfo.imageList ?? [];
    TextAlign? textAlign = memoInfo.textAlign;

    double fontSize = user.fontSize ?? defaultFontSize;

    return InkWell(
      onTap: () => widget.onMemo(memoInfo),
      child: Container(
        alignment: alignmentInfo[textAlign],
        child: Column(
          crossAxisAlignment: crossAxisAlignmentInfo[textAlign]!,
          children: [
            imageList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: MemoImages(
                      uint8ListList: imageList,
                      onImage: (Uint8List uint8List) =>
                          onSlide(uint8List, imageList),
                    ),
                  )
                : const CommonNull(),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CommonText(
                text: memo ?? '',
                isNotTr: true,
                isUnderline: user.isNoteUnderline == true,
                textAlign: textAlign,
                decorationColor: grey.s400,
                decoration: user.isNoteUnderline == true
                    ? TextDecoration.underline
                    : null,
                fontSize: fontSize + 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
