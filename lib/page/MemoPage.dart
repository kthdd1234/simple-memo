import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/provider/TextAlignProvider.dart';
import 'package:simple_memo_app/provider/selectedDateTimeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/memo/MemoActionBar.dart';
import 'package:simple_memo_app/widget/memo/MemoImages.dart';
import 'package:simple_memo_app/widget/memo/MemoTextFormField.dart';
import 'package:simple_memo_app/widget/popup/AlertPopup.dart';

class MemoPage extends StatefulWidget {
  MemoPage({super.key, required this.initTextAlign});

  TextAlign initTextAlign;

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<Uint8List> uint8ListList = [];

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

  onCompleted() {
    //
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TextAlignProvider>().initTextAlign(widget.initTextAlign);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String locale = context.locale.toString();
    DateTime selectedDateTime =
        context.watch<SelectedDateTimeProvider>().seletedDateTime;
    TextAlign textAlign = context.watch<TextAlignProvider>().textAlign;

    onTextAlign() {
      context.read<TextAlignProvider>().changeTextAlign();
    }

    action({
      required String name,
      required double right,
      required Color color,
      required double width,
    }) {
      return Padding(
        padding: EdgeInsets.only(right: right),
        child: svgAsset(name: name, width: width, color: color),
      );
    }

    return CommonBackground(
      child: CommonScaffold(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        appBarInfo: AppBarInfoClass(
            isCenter: false,
            title: ymdeShortFormatter(
              locale: locale,
              dateTime: selectedDateTime,
            ),
            actions: [
              action(name: 'star', right: 15, width: 20, color: Colors.black),
              action(name: 'trash', right: 20, width: 21, color: red.s400)
            ]),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: KeyboardActions(
            config: KeyboardActionsConfig(
              keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
              keyboardBarColor: const Color(0xffF8F4EA),
              actions: [
                KeyboardActionsItem(
                  focusNode: focusNode,
                  enabled: false,
                  displayArrows: false,
                  displayDoneButton: false,
                  toolbarButtons: [
                    (node) => MemoActionBar(
                          onCamera: onCamera,
                          onGallery: onGallery,
                          onTextAlign: onTextAlign,
                          onClock: onClock,
                          onCompleted: onCompleted,
                        )
                  ],
                )
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemoImages(uint8ListList: uint8ListList),
                  MemoTextFormField(
                    controller: textController,
                    textAlign: textAlign,
                    focusNode: focusNode,
                    fontSize: 14,
                    onChanged: (_) => setState(() {}),
                    cursorColor: textColor,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
