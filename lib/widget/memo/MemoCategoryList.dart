import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_memo_app/common/CommonTag.dart';
import 'package:simple_memo_app/provider/SelectedMemoCategoryIdProvider.dart';
import 'package:simple_memo_app/util/constants.dart';
import 'package:simple_memo_app/util/final.dart';

class MemoCategoryList extends StatefulWidget {
  const MemoCategoryList({super.key});

  @override
  State<MemoCategoryList> createState() => _MemoCategoryListState();
}

class _MemoCategoryListState extends State<MemoCategoryList> {
  onTag(String selectedId) {
    context.read<SelectedMemoCategoryIdProvider>().setId(selectedId);
  }

  @override
  Widget build(BuildContext context) {
    String selectedMemoCategoryId =
        context.watch<SelectedMemoCategoryIdProvider>().selectedMemoCategoryId;

    return Padding(
      padding: const EdgeInsets.only(top: 7, left: 10),
      child: SizedBox(
        height: 30,
        child: ListView.builder(
          itemCount: groupList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 7),
            child: CommonTag(
              text: groupList[index].name,
              textColor: selectedMemoCategoryId == groupList[index].id
                  ? Colors.white
                  : Colors.black,
              bgColor: selectedMemoCategoryId == groupList[index].id
                  ? textColor
                  : Colors.white,
              isBold: selectedMemoCategoryId == groupList[index].id,
              isNotTr: true,
              fontSize: 13,
              onTap: () => onTag(groupList[index].id),
            ),
          ),
        ),
      ),
    );
  }
}
