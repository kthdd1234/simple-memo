import 'dart:typed_data';
import 'package:hive/hive.dart';

part 'record_box.g.dart';

@HiveType(typeId: 2)
class RecordBox extends HiveObject {
  RecordBox({
    required this.createDateTime,
    this.memoInfoList,
  });

  @HiveField(0)
  DateTime createDateTime;

  @HiveField(1)
  List<Map<String, dynamic>>? memoInfoList;
}
