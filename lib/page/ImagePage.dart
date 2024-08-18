import 'package:flutter/cupertino.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/image/ImageView.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';

class ImagePage extends StatelessWidget {
  const ImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    List<MemoCategoryClass> categoryList =
        getMemoCategoryList(categoryRepository.categoryList);
    EdgeInsets padding = const EdgeInsets.fromLTRB(5, 10, 10, 10);

    return CommonBackground(
      child: CommonScaffold(
        appBarInfo: AppBarInfoClass(
          title: '사진 모아보기',
          isCenter: false,
          actions: [
            svgWidget(name: 'slide-show', onTap: () {}, padding: padding),
            svgWidget(name: 'image-remove', onTap: () {}, padding: padding),
            CommonSpace(width: 10)
          ],
        ),
        body: MultiValueListenableBuilder(
          valueListenables: valueListenables,
          builder: (context, values, child) {
            return Column(
              children: [
                ImageView(),
                CommonDivider(horizontal: 10, color: grey.s400),
                MemoCategoryList(categoryList: categoryList)
              ],
            );
          },
        ),
      ),
    );
  }
}
