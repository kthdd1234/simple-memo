import 'package:flutter/material.dart';
import 'package:simple_memo_app/widget/search/SearchItem.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          SearchItem(),
          SearchItem(),
        ],
      ),
    );
  }
}
