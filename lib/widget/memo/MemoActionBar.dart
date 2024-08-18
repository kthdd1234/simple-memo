import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:simple_memo_app/common/CommonNull.dart';
import 'package:simple_memo_app/common/CommonSpace.dart';
import 'package:simple_memo_app/util/final.dart';
import 'package:simple_memo_app/util/func.dart';
import 'package:simple_memo_app/widget/bottomSheet/ImageActionBottomSheet.dart';

class MemoActionBar extends StatefulWidget {
  MemoActionBar({
    super.key,
    required this.isRemove,
    required this.textAlign,
    required this.onCamera,
    required this.onGallery,
    required this.onTextAlign,
    required this.onClock,
    required this.onCompleted,
    required this.onRemove,
  });

  bool isRemove;
  TextAlign textAlign;
  Function(Uint8List uint8List) onCamera;
  Function(List<Uint8List> uint8ListList) onGallery;
  Function() onTextAlign, onClock, onCompleted, onRemove;

  @override
  State<MemoActionBar> createState() => _MemoActionBarState();
}

class _MemoActionBarState extends State<MemoActionBar> {
  onImage() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ImageActionBottomSheet(
        onCamera: widget.onCamera,
        onGallery: widget.onGallery,
      ),
    );
  }

  action({
    required String name,
    required double width,
    required Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: svgAsset(
          name: name,
          width: width,
          color: name == 'trash' ? red.s400 : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        action(name: 'image', width: 18, onTap: onImage),
        CommonSpace(width: 3),
        action(
          name: 'align-${textAlignName[widget.textAlign]}',
          width: 22,
          onTap: widget.onTextAlign,
        ),
        action(name: 'clock', width: 19, onTap: widget.onClock),
        CommonSpace(width: 2),
        widget.isRemove
            ? action(name: 'trash', width: 18, onTap: widget.onRemove)
            : const CommonNull(),
        const Spacer(),
        action(name: 'check', width: 22, onTap: widget.onCompleted),
      ],
    );
  }
}
