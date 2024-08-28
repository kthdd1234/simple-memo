// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserBoxAdapter extends TypeAdapter<UserBox> {
  @override
  final int typeId = 1;

  @override
  UserBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserBox(
      id: fields[0] as String,
      createDateTime: fields[1] as DateTime,
      fontFamily: fields[5] as String,
      calendarMaker: fields[3] as String,
      calendarFormat: fields[2] as String,
      theme: fields[4] as String,
      categoryOrderList: (fields[6] as List).cast<String>(),
      alarmInfo: (fields[8] as Map?)?.cast<String, dynamic>(),
      passwords: fields[9] as String?,
      googleDriveInfo: (fields[7] as Map?)?.cast<String, dynamic>(),
      background: fields[10] as String?,
      isNoteUnderline: fields[11] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, UserBox obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createDateTime)
      ..writeByte(2)
      ..write(obj.calendarFormat)
      ..writeByte(3)
      ..write(obj.calendarMaker)
      ..writeByte(4)
      ..write(obj.theme)
      ..writeByte(5)
      ..write(obj.fontFamily)
      ..writeByte(6)
      ..write(obj.categoryOrderList)
      ..writeByte(7)
      ..write(obj.googleDriveInfo)
      ..writeByte(8)
      ..write(obj.alarmInfo)
      ..writeByte(9)
      ..write(obj.passwords)
      ..writeByte(10)
      ..write(obj.background)
      ..writeByte(11)
      ..write(obj.isNoteUnderline);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
