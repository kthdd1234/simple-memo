import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/model/record_box/record_box.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/provider/themeProvider.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/search/SearchItem.dart';

class SearchView extends StatelessWidget {
  SearchView({
    super.key,
    required this.keyword,
    required this.isRecent,
  });

  String keyword;
  bool isRecent;

  @override
  Widget build(BuildContext context) {
    bool isLight = context.watch<ThemeProvider>().isLight;

    String selectedMemoCategoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;
    List<MemoInfoClass> memoInfoList = [];

    for (var i = 0; i < recordRepository.recordList.length; i++) {
      RecordBox? record = recordRepository.recordList[i];

      if (record.memoInfoList != null) {
        for (var j = 0; j < record.memoInfoList!.length; j++) {
          MemoInfoClass memoInfo = memoInfoToClass(record.memoInfoList![j]);

          if (memoInfo.categoryId == selectedMemoCategoryId) {
            if (keyword != '') {
              bool isSearchKeyword = memoInfo.memo?.contains(keyword) == true;
              if (isSearchKeyword) {
                memoInfoList.add(MemoInfoClass(
                  dateTime: record.createDateTime,
                  categoryId: memoInfo.categoryId,
                  textAlign: memoInfo.textAlign,
                  imageList: memoInfo.imageList,
                  memo: memoInfo.memo,
                ));
              }
            } else {
              memoInfoList.add(MemoInfoClass(
                dateTime: record.createDateTime,
                categoryId: memoInfo.categoryId,
                textAlign: memoInfo.textAlign,
                imageList: memoInfo.imageList,
                memo: memoInfo.memo,
              ));
            }
          }
        }
      }
    }

    memoInfoList = isRecent ? memoInfoList.reversed.toList() : memoInfoList;

    return Expanded(
      child: memoInfoList.isNotEmpty
          ? SingleChildScrollView(
              child: Column(
              children: memoInfoList
                  .map((memoInfo) => SearchItem(memoInfo: memoInfo))
                  .toList(),
            ))
          : Center(
              child: CommonText(
              text: '글이 없어요',
              color: isLight ? grey.original : grey.s400,
            )),
    );
  }
}
