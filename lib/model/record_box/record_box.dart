import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'record_box.g.dart';

@HiveType(typeId: 2)
class RecordBox extends HiveObject {
  RecordBox({
    required this.createDateTime,
    this.imageList,
  });

  @HiveField(0)
  DateTime createDateTime;

  @HiveField(1)
  List<Uint8List>? imageList;
}
