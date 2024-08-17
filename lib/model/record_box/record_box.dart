import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'record_box.g.dart';

@HiveType(typeId: 2)
class RecordBox extends HiveObject {
  RecordBox({
    required this.createDateTime,
    required this.categoryId,
    this.imageList,
    this.memoInfo,
  });

  @HiveField(0)
  DateTime createDateTime;

  @HiveField(1)
  String categoryId;

  @HiveField(2)
  List<Uint8List>? imageList;

  @HiveField(3)
  List<Map<String, String>>? memoInfo;
}
