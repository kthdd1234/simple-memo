import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonDivider.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/appBar/ImageAppBar.dart';
import 'package:simple_memo_app/widget/image/ImageView.dart';
import 'package:simple_memo_app/widget/memo/MemoCategoryList.dart';

class ImageBody extends StatefulWidget {
  const ImageBody({super.key});

  @override
  State<ImageBody> createState() => _ImageBodyState();
}

class _ImageBodyState extends State<ImageBody> {
  // @override
  // void initState() {
  //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
  //     context.read<SelectedMemoCategoryIdProvider>().setId('imageAll');
  //   });

  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    List<MemoCategoryClass> categoryList =
        getMemoCategoryList(categoryRepository.categoryList);
    List<MemoCategoryClass> imageCategoryList = [
      MemoCategoryClass(id: 'imageAll', name: '전체'.tr()),
      ...categoryList
    ];

    return MultiValueListenableBuilder(
      valueListenables: valueListenables,
      builder: (context, values, child) {
        return Column(
          children: [
            ImageAppBar(),
            CommonDivider(horizontal: 10, color: grey.s400),
            ImageView(),
            CommonDivider(horizontal: 10, color: grey.s400),
            MemoCategoryList(categoryList: imageCategoryList)
          ],
        );
      },
    );
  }
}
