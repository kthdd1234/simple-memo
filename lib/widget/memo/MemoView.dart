import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/page/MemoPage.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/MemoPasteBottomSheet.dart';
import 'package:simple_memo_app/widget/bottomSheet/MemoSettingBottomSheet.dart';
import 'package:simple_memo_app/widget/memo/MemoImages.dart';

class MemoView extends StatefulWidget {
  MemoView({
    super.key,
    required this.selectedDateTime,
    required this.categoryId,
    this.copyMemoInfo,
  });

  DateTime selectedDateTime;
  String categoryId;
  Map<String, dynamic>? copyMemoInfo;

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

  onHorizontalDrag(DragEndDetails dragEndDetails) {
    double? primaryVelocity = dragEndDetails.primaryVelocity;
    DateTime dateTime = widget.selectedDateTime;

    if (primaryVelocity == null) {
      return;
    } else if (primaryVelocity > 0) {
      dateTime = dateTime.subtract(const Duration(days: 1));
    } else if (primaryVelocity < 0) {
      dateTime = dateTime.add(const Duration(days: 1));
    }

    context
        .read<SelectedDateTimeProvider>()
        .changeSelectedDateTime(dateTime: dateTime);
  }

  onLongPress(MemoInfoClass? memoInfo) {
    if (memoInfo != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) => MemoSettingBottomSheet(
          memoInfo: memoInfo,
          copyMemoInfo: widget.copyMemoInfo,
          selectedCategoryId: widget.categoryId,
          selectedDateTime: widget.selectedDateTime,
        ),
      );
    } else if (widget.copyMemoInfo != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) => MemoPasteBottomSheet(
          copyMemoInfo: widget.copyMemoInfo,
          selectedCategoryId: widget.categoryId,
          selectedDateTime: widget.selectedDateTime,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    MemoInfoClass? memoInfo =
        getMemoInfo(widget.selectedDateTime, widget.categoryId);
    String? memo = memoInfo?.memo;
    List<Uint8List> imageList = memoInfo?.imageList ?? [];
    TextAlign? textAlign = memoInfo?.textAlign ?? TextAlign.left;

    return Expanded(
      child: GestureDetector(
        onHorizontalDragEnd: onHorizontalDrag,
        onLongPress: () => onLongPress(memoInfo),
        child: InkWell(
          onTap: () => onMemo(memoInfo),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: memoInfo != null
                ? Container(
                    alignment: alignmentInfo[textAlign],
                    child: SingleChildScrollView(
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
                            text: memo ?? '',
                            isNotTr: true,
                            textAlign: textAlign,
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
