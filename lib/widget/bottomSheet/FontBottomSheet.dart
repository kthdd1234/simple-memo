import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';

class FontBottomSheet extends StatelessWidget {
  const FontBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonModalSheet(
      title: '글꼴 변경',
      height: 430,
      child: CommonContainer(
        innerPadding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            children: fontFamilyList
                .map(
                  (data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: [
                            Text(
                              data['name']!,
                              style: TextStyle(
                                fontSize: 17,
                                fontFamily: data['fontFamily'],
                                color: isLight ? Colors.black : darkTextColor,
                                fontWeight: isLight
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            svgAsset(
                              name: 'check',
                              width: 20,
                              isLight: isLight,
                            ),
                          ],
                        ),
                      ),
                      CommonDivider()
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
