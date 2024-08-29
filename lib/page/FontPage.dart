import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonButton.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/reload_provider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FontPage extends StatelessWidget {
  const FontPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '글꼴'),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [FontPreview(), FontSize(), FontList()],
            ),
          ),
        ),
      ),
    );
  }
}

class FontPreview extends StatelessWidget {
  const FontPreview({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> fontPreviewList = [
      "글꼴 미리보기입니다.",
      "가나다라마바사아자차카타파하",
      "ABCDEFGHIJKLMNOPQRSTUVWXYZ",
      "abcdefghijklnmopqrstuvwxyz",
      "いち、に、さん、よん、ご、ろく、なな",
      "0123456789!@#%^&*()",
    ];

    return CommonContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fontPreviewList
            .map((font) => CommonText(text: font, isNotTr: true))
            .toList(),
      ),
    );
  }
}

class FontSize extends StatefulWidget {
  const FontSize({super.key});

  @override
  State<FontSize> createState() => _FontSizeState();
}

class _FontSizeState extends State<FontSize> {
  UserBox user = userRepository.user;

  @override
  Widget build(BuildContext context) {
    List<double> fontSizeList = [14.0, 15.0, 16.0, 17.0, 18.0, 19.0, 20.0];
    bool isReload = context.watch<ReloadProvider>().isReload;
    bool isLight = context.watch<ThemeProvider>().isLight;

    onChanged(double newValue) async {
      user.fontSize = newValue;
      await user.save();

      context.read<ReloadProvider>().setReload(!isReload);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonText(text: '크기'),
          CommonSpace(height: 5),
          Row(
            children: fontSizeList
                .map((fontSize) => Expanded(
                      child: CommonButton(
                        isNotTr: true,
                        outerPadding: EdgeInsets.only(
                          right: fontSize != 20 ? 5 : 0,
                        ),
                        text: '${fontSize.toInt()}',
                        textColor: isLight
                            ? user.fontSize == fontSize
                                ? Colors.white
                                : Colors.black
                            : user.fontSize == fontSize
                                ? Colors.black
                                : Colors.white,
                        buttonColor: isLight
                            ? user.fontSize == fontSize
                                ? themeColor
                                : Colors.white
                            : user.fontSize == fontSize
                                ? Colors.white
                                : darkContainerColor,
                        isBold: false,
                        fontSize: fontSize.toDouble(),
                        verticalPadding: 10,
                        borderRadius: 5,
                        onTap: () => onChanged(fontSize),
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

class FontList extends StatefulWidget {
  const FontList({super.key});

  @override
  State<FontList> createState() => _FontListState();
}

class _FontListState extends State<FontList> {
  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;
    bool isReload = context.watch<ReloadProvider>().isReload;

    onChanged(String? newValue) async {
      UserBox user = userRepository.user;

      user.fontFamily = newValue!;
      await user.save();

      context.read<ReloadProvider>().setReload(!isReload);
    }

    return MultiValueListenableBuilder(
        valueListenables: valueListenables,
        builder: (context, values, child) {
          UserBox user = userRepository.user;
          String fontFamily = user.fontFamily;
          double fontSize = user.fontSize ?? defaultFontSize;

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonText(text: '종류'),
                CommonSpace(height: 10),
                Column(
                  children: fontFamilyList
                      .map(
                        (info) => CommonContainer(
                          onTap: () => onChanged(info['fontFamily']),
                          innerPadding:
                              const EdgeInsets.only(left: 20, right: 5),
                          outerPadding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            title: Text(
                              info['name']!.tr(),
                              style: TextStyle(
                                fontFamily: info['fontFamily'],
                                color: isLight ? Colors.black : Colors.white,
                                fontSize: fontSize,
                              ),
                            ),
                            trailing: Radio<String>(
                              activeColor: isLight ? themeColor : Colors.white,
                              value: info['fontFamily']!,
                              groupValue: fontFamily,
                              onChanged: (_) => onChanged(info['fontFamily']!),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          );
        });
  }
}
