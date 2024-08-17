import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 1)
class UserBox extends HiveObject {
  UserBox({
    required this.id,
    required this.createDateTime,
    required this.fontFamily,
    required this.calendarMaker,
    required this.calendarFormat,
    required this.theme,
    required this.categoryOrderList,
    this.alarmInfo,
    this.passwords,
    this.googleDriveInfo,
  });

  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime createDateTime;

  @HiveField(2)
  String calendarFormat;

  @HiveField(3)
  String calendarMaker;

  @HiveField(4)
  String theme;

  @HiveField(5)
  String fontFamily;

  @HiveField(6)
  List<String> categoryOrderList;

  @HiveField(7)
  Map<String, dynamic>? googleDriveInfo;

  @HiveField(8)
  Map<String, dynamic>? alarmInfo;

  @HiveField(9)
  String? passwords;
}
