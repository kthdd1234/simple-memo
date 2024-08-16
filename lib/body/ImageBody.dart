import 'package:flutter/cupertino.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/widget/appBar/ImageAppBar.dart';
import 'package:simple_memo_app/widget/image/ImageView.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';

class ImageBody extends StatelessWidget {
  const ImageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        return Column(
          children: [
            ImageAppBar(),
            CommonDivider(horizontal: 10, color: grey.s400),
            ImageView(),
            CommonDivider(horizontal: 10, color: grey.s400),
            MemoCategoryList(categoryList: categoryList)
          ],
        );
      },
    );
  }
}
