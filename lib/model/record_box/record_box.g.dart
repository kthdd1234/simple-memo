// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'record_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RecordBoxAdapter extends TypeAdapter<RecordBox> {
  @override
  final int typeId = 2;

  @override
  RecordBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecordBox(
      createDateTime: fields[0] as DateTime,
      categoryId: fields[1] as String,
      imageList: (fields[2] as List?)?.cast<Uint8List>(),
      memoInfo: (fields[3] as List?)
          ?.map((dynamic e) => (e as Map).cast<String, String>())
          ?.toList(),
    );
  }

  @override
  void write(BinaryWriter writer, RecordBox obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.createDateTime)
      ..writeByte(1)
      ..write(obj.categoryId)
      ..writeByte(2)
      ..write(obj.imageList)
      ..writeByte(3)
      ..write(obj.memoInfo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecordBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
