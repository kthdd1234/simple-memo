import 'package:flutter/cupertino.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonModalSheet.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';

class FontBottomSheet extends StatelessWidget {
  const FontBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonModalSheet(
      title: '글꼴 변경',
      height: 400,
      child: CommonContainer(
        innerPadding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: fontFamilyList
              .map(
                (fontFamily) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: [
                          CommonText(text: fontFamily['name']!),
                          Spacer(),
                          svgAsset(name: 'check', width: 20),
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
    );
  }
}
