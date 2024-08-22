import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/button/ModalButton.dart';

class ScreenModeBottomSheet extends StatelessWidget {
  const ScreenModeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    UserBox user = userRepository.user;
    String theme = user.theme;

    onMode(String modeId) async {
      Brightness brightness = MediaQuery.of(context).platformBrightness;

      context.read<ThemeProvider>().setThemeValue(
            modeId == tSystem
                ? brightness == Brightness.light
                    ? tLight
                    : tDark
                : modeId,
          );

      user.theme = modeId;
      await user.save();

      pop(context);
    }

    return CommonModalSheet(
      title: '화면',
      height: 195,
      child: Row(
        children: [
          ModalButton(
            svgName: 'system',
            actionText: '시스템 설정',
            isSelection: tSystem == theme,
            onTap: () => onMode(tSystem),
          ),
          CommonSpace(width: 5),
          ModalButton(
            svgName: 'light',
            actionText: '화이트 모드',
            isSelection: tLight == theme,
            onTap: () => onMode(tLight),
          ),
          CommonSpace(width: 5),
          ModalButton(
            svgName: 'dark',
            actionText: '다크 모드',
            isSelection: tDark == theme,
            onTap: () => onMode(tDark),
          ),
        ],
      ),
    );
  }
}
