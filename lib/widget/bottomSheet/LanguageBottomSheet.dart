import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    onLang(String lagnId) {
      //
    }

    return CommonModalSheet(
      title: '화면 모드',
      height: 185,
      child: Row(
        children: [
          ModalButton(
            isNotSvgColor: true,
            isNotTr: true,
            svgName: 'usa',
            actionText: 'English',
            onTap: () => onLang('usa'),
          ),
          CommonSpace(width: 5),
          ModalButton(
            isNotSvgColor: true,
            isNotTr: true,
            svgName: 'korea',
            actionText: '한국어',
            onTap: () => onLang('korea'),
          ),
          CommonSpace(width: 5),
          ModalButton(
            isNotSvgColor: true,
            isNotTr: true,
            svgName: 'japan',
            actionText: '日本語',
            onTap: () => onLang('japan'),
          ),
        ],
      ),
    );
  }
}
