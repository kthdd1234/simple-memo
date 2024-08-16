import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonOutlineInputField.dart';
import 'package:simple_memo_app/util/constants.dart';

class SearchMemoBar extends StatelessWidget {
  SearchMemoBar({
    super.key,
    required this.controller,
    required this.onEditingComplete,
  });

  TextEditingController controller;
  Function() onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        children: [
          CommonOutlineInputField(
            controller: controller,
            hintText: '키워드를 입력해주세요.',
            selectedColor: textColor,
            onEditingComplete: onEditingComplete,
            onSuffixIcon: onEditingComplete,
          )
        ],
      ),
    );
  }
}
