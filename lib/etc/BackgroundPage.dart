import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonSwitch.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/page/PremiumPage.dart';
import 'package:simple_memo_app/provider/PremiumProvider.dart';
import 'package:simple_memo_app/provider/reload_provider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/popup/AlertPopup.dart';

class BackgroundPage extends StatelessWidget {
  const BackgroundPage({super.key});

  onChanged(bool newValue) {
    //
  }

  @override
  Widget build(BuildContext context) {
    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(title: '배경'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              CommonContainer(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CommonText(text: '노트에 줄무늬 표시', fontSize: 15),
                    SizedBox(
                      height: 25,
                      child: CommonSwitch(
                        activeColor: themeColor,
                        value: false,
                        onChanged: onChanged,
                      ),
                    )
                  ],
                ),
              ),
              CommonSpace(height: 10),
              CommonContainer(
                child: SingleChildScrollView(
                  child: Column(
                    children: backgroundClassList
                        .map(
                          (themeList) => Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: Row(children: [
                              BackgroundItem(
                                path: themeList[0].path,
                                name: themeList[0].name,
                              ),
                              CommonSpace(width: 20),
                              BackgroundItem(
                                path: themeList[1].path,
                                name: themeList[1].name,
                              )
                            ]),
                          ),
                        )
                        .toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BackgroundItem extends StatefulWidget {
  BackgroundItem({
    super.key,
    required this.path,
    required this.name,
  });

  String path, name;

  @override
  State<BackgroundItem> createState() => _BackgroundItemState();
}

class _BackgroundItemState extends State<BackgroundItem> {
  UserBox user = userRepository.user;

  @override
  Widget build(BuildContext context) {
    String? background = user.background ?? '1';
    bool isReload = context.watch<ReloadProvider>().isReload;

    onBackground(String path) async {
      user.background = path;
      await user.save();

      context.read<ReloadProvider>().setReload(!isReload);
    }

    return Expanded(
      child: InkWell(
        onTap: () => onBackground(widget.path),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(
                    'assets/images/texture-${widget.path}.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 200,
                  ),
                ),
                widget.path == background
                    ? BackgroundMask(height: 200, opacity: 0.2)
                    : const CommonNull()
              ],
            ),
            CommonSpace(height: 5),
            CommonText(text: widget.name, fontSize: 13, color: themeColor)
          ],
        ),
      ),
    );
    ;
  }
}

class BackgroundMask extends StatelessWidget {
  BackgroundMask({super.key, this.width, this.height, this.opacity});

  double? width, height, opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(opacity ?? 0.5),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Column(
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.white,
              size: 30,
              weight: 1,
            ),
            CommonSpace(height: 5),
            CommonText(text: '적용 중', color: Colors.white),
          ],
        )
      ],
    );
  }
}
