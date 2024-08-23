import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonButton.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';

class PremiumPage extends StatelessWidget {
  const PremiumPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    onPurchase() {
      //
    }

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '프리미엄'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CommonText(text: '프리미엄 혜택'),
                    CommonText(
                      text: '구매 내역 가져오기',
                      color: grey.original,
                      fontSize: 14,
                    ),
                  ],
                ),
              ),
              Column(
                children: premiumBenefitsClassList
                    .map(
                      (premiumBenefit) => CommonContainer(
                        outerPadding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 20),
                              child: svgAsset(
                                isLight: isLight,
                                name: premiumBenefit.svgName,
                                width: 32.5,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CommonText(text: premiumBenefit.title),
                                CommonText(
                                  text: premiumBenefit.subTitle,
                                  color: grey.original,
                                  fontSize: 14,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
              CommonSpace(height: 5),
              CommonButton(
                text: '구매하기 ()',
                textColor: Colors.white,
                buttonColor: themeColor,
                verticalPadding: 10,
                borderRadius: 100,
                onTap: onPurchase,
              )
            ],
          ),
        ),
      ),
    );
  }
}
