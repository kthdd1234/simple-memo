import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:provider/provider.dart';

class CommonModalSheet extends StatelessWidget {
  CommonModalSheet({
    super.key,
    this.title,
    this.isBack,
    this.isNotTr,
    required this.height,
    required this.child,
  });

  String? title;
  double height;
  bool? isBack, isNotTr;
  Widget child;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonBackground(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      height: height,
      isRadius: true,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              title != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        isBack == true
                            ? InkWell(
                                onTap: () => pop(context),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 15, right: 15),
                                  child: Icon(
                                    Icons.arrow_back_ios_new_rounded,
                                    color: isLight ? themeColor : Colors.white,
                                    size: 16,
                                  ),
                                ),
                              )
                            : const CommonNull(),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: CommonText(
                              text: title!,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              isBold: !isLight,
                              isNotTr: isNotTr,
                            ),
                          ),
                        ),
                        isBack == true
                            ? const Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Icon(
                                  Icons.arrow_back_ios_new_rounded,
                                  color: Colors.transparent,
                                  size: 16,
                                ),
                              )
                            : const CommonNull(),
                      ],
                    )
                  : const CommonNull(),
              Expanded(child: child),
            ],
          ),
        ),
      ),
    );
  }
}
