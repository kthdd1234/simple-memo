import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder/multi_value_listenable_builder.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonBackground.dart';
import 'package:simple_memo_app/common/CommonContainer.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonScaffold.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/common/CommonSvgText.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/category_box/category_box.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/model/user_box/user_box.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/enum.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/MemoCategoryBottomSheet.dart';
import 'package:simple_memo_app/widget/popup/AlertPopup.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isEdit = false;

  onPressed() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => MemoCategoryBottomSheet(),
    );
  }

  getCount(String categoryId) {
    List<RecordBox> recordList = recordRepository.recordList;
    int count = 0;

    recordList.forEach((record) {
      record.memoInfoList?.forEach((memoInfo) {
        if (memoInfo['categoryId'] == categoryId) {
          count += 1;
        }
      });
    });

    return count;
  }

  onEdit() {
    setState(() => isEdit = !isEdit);
  }

  onReorder(int oldIndex, int newIndex) async {
    UserBox user = userRepository.user;

    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    String orderId = user.categoryOrderList.removeAt(oldIndex);
    user.categoryOrderList.insert(newIndex, orderId);

    await userRepository.user.save();
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return CommonBackground(
      child: CommonScaffold(
        padding: const EdgeInsets.only(left: 20, right: 20),
        appBarInfo: AppBarInfoClass(title: '노트 관리', actions: [
          InkWell(
            onTap: onEdit,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CommonText(
                text: isEdit ? '편집 해제' : '편집',
                color: isEdit
                    ? red.s300
                    : isLight
                        ? grey.original
                        : grey.s400,
              ),
            ),
          )
        ]),
        body: MultiValueListenableBuilder(
          valueListenables: valueListenables,
          builder: (_, __, ___) {
            List<CategoryBox> categoryList = getCategoryList();

            return ReorderableListView.builder(
              physics: const ClampingScrollPhysics(),
              itemBuilder: (_, index) {
                CategoryBox categoryBox = categoryList[index];

                return Padding(
                  key: Key(categoryBox.id),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MemoCategoryItem(
                    isEdit: isEdit,
                    categoryBox: categoryBox,
                    count: getCount(categoryBox.id),
                  ),
                );
              },
              itemCount: categoryList.length,
              onReorder: onReorder,
            );
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20),
          child: FloatingActionButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            onPressed: onPressed,
            child: const Icon(Icons.add_rounded, size: 25),
          ),
        ),
      ),
    );
  }
}

class MemoCategoryItem extends StatefulWidget {
  MemoCategoryItem({
    super.key,
    required this.categoryBox,
    required this.count,
    required this.isEdit,
  });

  CategoryBox categoryBox;
  int count;
  bool isEdit;

  @override
  State<MemoCategoryItem> createState() => _MemoCategoryItemState();
}

class _MemoCategoryItemState extends State<MemoCategoryItem> {
  onItem() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => MemoCategoryBottomSheet(
        initCategoryBox: widget.categoryBox,
      ),
    );
  }

  onRemove() {
    if (categoryRepository.categoryList.length == 1) {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '최소 1개 이상의 노트가 존재해야 합니다.',
          buttonText: '확인',
          height: 170,
          onTap: () => pop(context),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertPopup(
          desc: '삭제 시, 노트의 기록이 삭제됩니다.',
          buttonText: '삭제',
          isCancel: true,
          height: 170,
          onTap: () async {
            String categoryId = widget.categoryBox.id;
            await categoryRepository.categoryBox.delete(categoryId);
            userRepository.user.categoryOrderList.remove(categoryId);

            List<RecordBox> recordList = recordRepository.recordList;

            for (var i = 0; i < recordList.length; i++) {
              RecordBox record = recordList[i];
              List<Map<String, dynamic>> memoInfoList =
                  record.memoInfoList ?? [];

              for (var k = 0; k < memoInfoList.length; k++) {
                if (memoInfoList[k]['categoryId'] == categoryId) {
                  memoInfoList.removeAt(k);
                }
              }

              await record.save();
            }

            context
                .read<SelectedMemoCategoryIdProvider>()
                .setId(categoryRepository.categoryList[0].id);

            userRepository.user.save();
            pop(context);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    return Row(
      children: [
        widget.isEdit
            ? Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: onRemove,
                  child: Icon(Icons.remove_circle, size: 20, color: red.s400),
                ),
              )
            : const CommonNull(),
        Expanded(
          child: InkWell(
            onTap: onItem,
            child: CommonContainer(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: CommonText(
                      text: widget.categoryBox.name,
                      isNotTr: true,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  CommonSpace(width: 30),
                  CommonSvgText(
                    text: '${widget.count}',
                    fontSize: 16,
                    textColor: isLight ? grey.original : Colors.white,
                    svgColor: isLight ? grey.original : Colors.white,
                    svgWidth: 6,
                    svgLeft: 6,
                    isNotTr: true,
                    svgDirection: SvgDirection.right,
                  )
                ],
              ),
            ),
          ),
        ),
        widget.isEdit
            ? Padding(
                padding: const EdgeInsets.only(left: 10),
                child: InkWell(
                  child: Icon(
                    Icons.reorder_rounded,
                    size: 20,
                    color: grey.original,
                  ),
                ),
              )
            : const CommonNull(),
      ],
    );
  }
}
