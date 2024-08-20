import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonImage.dart';
import 'package:simple_memo_app/common/CommonText.dart';
import 'package:simple_memo_app/util/class.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/widget/image/ImageDateTime.dart';

class ImageView extends StatelessWidget {
  ImageView({
    super.key,
    required this.imageClassList,
    required this.onImage,
  });

  List<ImageClass> imageClassList;
  Function(List<Uint8List> uint8ListList, int index) onImage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: imageClassList.isNotEmpty
          ? GridView.builder(
              itemCount: imageClassList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 1,
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (BuildContext buildContext, int index) {
                List<Uint8List> uint8ListList =
                    imageClassList.map((image) => image.uint8List).toList();

                return Stack(
                  children: [
                    CommonImage(
                      uint8List: imageClassList[index].uint8List,
                      height: MediaQuery.of(context).size.height,
                      onTap: (_) => onImage(uint8ListList, index),
                    ),
                    ImageDateTime(
                      dateTime: imageClassList[index].dateTime,
                      onTap: () => onImage(uint8ListList, index),
                    ),
                  ],
                );
              },
            )
          : Center(child: CommonText(text: '사진이 없어요.', color: grey.original)),
    );
  }
}
