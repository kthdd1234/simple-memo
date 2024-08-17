import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';

class ScreenModeBottomSheet extends StatelessWidget {
  const ScreenModeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    onMode(String modeId) {
      //
    }

    return CommonModalSheet(
      title: '화면 모드',
      height: 185,
      child: Row(
        children: [
          ModalButton(
            svgName: 'system',
            actionText: '시스템 설정',
            onTap: () => onMode('system'),
          ),
          CommonSpace(width: 5),
          ModalButton(
            svgName: 'light',
            actionText: '기본 모드',
            onTap: () => onMode('light'),
          ),
          CommonSpace(width: 5),
          ModalButton(
            svgName: 'dark',
            actionText: '다크 모드',
            onTap: () => onMode('light'),
          ),
        ],
      ),
    );
  }
}
