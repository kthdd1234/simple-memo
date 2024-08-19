import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonTag.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/page/ImageSlidePage.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/ImageSelectionModalSheet.dart';
import 'package:simple_memo_app/widget/memo/MemoActionBar.dart';
import 'package:simple_memo_app/widget/memo/MemoImages.dart';
import 'package:simple_memo_app/widget/memo/MemoTextFormField.dart';
import 'package:simple_memo_app/widget/popup/AlertPopup.dart';

class MemoPage extends StatefulWidget {
  MemoPage({super.key, this.initMemoInfo});

  MemoInfoClass? initMemoInfo;

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<Uint8List> uint8ListList = [];
  TextAlign textAlign = TextAlign.left;

  @override
  void initState() {
    if (widget.initMemoInfo != null) {
      textController.text = widget.initMemoInfo!.memo ?? '';
      uint8ListList = widget.initMemoInfo!.imageList ?? [];
      textAlign = widget.initMemoInfo!.textAlign;
    }

    super.initState();
  }

  onLimitedImagePopup() {
    return showDialog(
      context: context,
      builder: (context) => AlertPopup(
        desc: '사진은 최대 6장까지 추가할 수 있어요.',
        buttonText: '확인',
        height: 160,
        onTap: () => pop(context),
      ),
    );
  }

  onCamera(Uint8List uint8List) {
    pop(context);

    if (uint8ListList.length + 1 > 6) {
      onLimitedImagePopup();
    } else {
      setState(() => uint8ListList.add(uint8List));
    }
  }

  onGallery(List<Uint8List> uint8ListArray) {
    int length = uint8ListList.length + uint8ListArray.length;

    pop(context);

    if (length > 6) {
      onLimitedImagePopup();
    } else {
      setState(() => uint8ListList.addAll(uint8ListArray));
    }
  }

  onClock() {
    String locale = context.locale.toString();
    DateTime now = DateTime.now();
    String time = hmFormatter(locale: locale, dateTime: now);

    setState(() => textController.text = '${textController.text}$time');
  }

  onTextAlign() {
    setState(() => textAlign = nextTextAlign[textAlign]!);
  }

  onImage(Uint8List uint8List) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => ImageSelectionModalSheet(
        uint8List: uint8List,
        onSlide: () {
          pop(context);
          navigator(
            context: context,
            page: ImageSlidePage(
              curIndex: uint8ListList.indexOf(uint8List),
              uint8ListList: uint8ListList,
            ),
          );
        },
        onRemove: () {
          uint8ListList.removeWhere((uint8List_) => uint8List_ == uint8List);
          setState(() {});
          pop(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    String selectedCategoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;

    onCompleted() async {
      String? memo = textController.text != '' ? textController.text : null;
      int recordKey = dateTimeKey(selectedDateTime);
      RecordBox? record = recordRepository.recordBox.get(recordKey);
      List<Map<String, dynamic>> memoInfoList = record?.memoInfoList ?? [];
      List<Uint8List>? imageList =
          uint8ListList.isNotEmpty ? uint8ListList : null;
      Map<String, dynamic> newMemoInfo = memoInfoToMap(MemoInfoClass(
        categoryId: selectedCategoryId,
        imageList: imageList,
        memo: memo,
        textAlign: textAlign,
      ));

      if (widget.initMemoInfo == null) {
        recordRepository.updateRecord(
          key: recordKey,
          record: RecordBox(
            createDateTime: selectedDateTime,
            memoInfoList: [...memoInfoList, newMemoInfo],
          ),
        );
      } else {
        for (var i = 0; i < memoInfoList.length; i++) {
          if (memoInfoList[i]['categoryId'] == selectedCategoryId) {
            memoInfoList[i]['imageList'] = imageList;
            memoInfoList[i]['memo'] = memo;
            memoInfoList[i]['textAlign'] = textAlign.toString();

            break;
          }
        }

        await record?.save();
      }

      pop(context);
    }

    return CommonBackground(
      child: CommonScaffold(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        appBarInfo: AppBarInfoClass(
            title: ymdeShortFormatter(
              locale: locale,
              dateTime: selectedDateTime,
            ),
            isNotTr: true,
            isCenter: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15),
                child: CommonTag(
                  text: getMemoCategoryName(selectedCategoryId),
                  textColor: textColor,
                  bgColor: Colors.white,
                  isNotTr: true,
                  fontSize: 13,
                  onTap: () {},
                ),
              ),
            ]),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: crossAxisAlignmentInfo[textAlign]!,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: MemoImages(
                          uint8ListList: uint8ListList,
                          onImage: onImage,
                        ),
                      ),
                      MemoTextFormField(
                        controller: textController,
                        textAlign: textAlign,
                        focusNode: focusNode,
                        fontSize: 14,
                      ),
                      CommonSpace(height: 70)
                    ],
                  ),
                ),
              ),
            ),
            MemoActionBar(
              isRemove: widget.initMemoInfo != null,
              textAlign: textAlign,
              onCamera: onCamera,
              onGallery: onGallery,
              onTextAlign: onTextAlign,
              onClock: onClock,
              onCompleted: onCompleted,
            )
          ],
        ),
      ),
    );
  }
}
